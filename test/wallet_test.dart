// Copyright 2019 cruzall developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sembast/sembast_memory.dart';

import 'package:cruzawl/currency.dart';
import 'package:cruzawl/cruz.dart';
import 'package:cruzawl/http.dart';
import 'package:cruzawl/preferences.dart';
import 'package:cruzawl/sembast.dart';
import 'package:cruzawl/util.dart';
import 'package:cruzawl/wallet.dart';
import 'package:cruzawl/websocket.dart';

import 'package:cruzawl_ui/explorer/settings.dart';
import 'package:cruzawl_ui/localization.dart';
import 'package:cruzawl_ui/model.dart';
import 'package:cruzawl_ui/routes.dart';
import 'package:cruzawl_ui/ui.dart';
import 'package:cruzawl_ui/wallet/add.dart';
import 'package:cruzawl_ui/wallet/app.dart';
import 'package:cruzawl_ui/wallet/settings.dart';

const num sendMoney = 3.29, feeMoney = 0.01;
const int money = 13, moneyBalance = money * CRUZ.cruzbitsPerCruz;
const int sendMoneyBalance = (sendMoney * CRUZ.cruzbitsPerCruz) ~/ 1;
const int feeMoneyBalance = (feeMoney * CRUZ.cruzbitsPerCruz) ~/ 1;
const String moneySender = 'xRL0D9U+jav9NxOwz4LsXe8yZ8KSS7Hst4/P8ChciAI=';
const String sendTo = '5lojzpXqrpAfrYSxF0s8vyRSQ0SlhiovzacD+tI1oK8=';
const String password = 'foobar';

void main() async {
  for (Locale locale in Localization.supportedLocales) {
    CruzawlPreferences preferences = CruzawlPreferences(
        SembastPreferences(await databaseFactoryMemoryFs
            .openDatabase('settings_wallet_$locale.db')),
        () => NumberFormat.currency().currencyName);
    await preferences.storage.load();
    await preferences.setNetworkEnabled(false);
    await preferences.setMinimumReserveAddress(3);
    Localization l10n = await Localization.load(locale);
    group('Wallet tests $locale',
        () => runWalletTests(preferences, locale, l10n));
  }
}

void runWalletTests(
    CruzawlPreferences preferences, Locale testLocale, Localization l10n) {
  List<LocalizationsDelegate> localizationsDelegates = <LocalizationsDelegate>[
    LocalizationDelegate(),
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate
  ];
  List<Locale> supportedLocales = <Locale>[testLocale];

  String walletName = 'normalFoolbar-$testLocale';
  String watchWalletName = 'watchOnlyFoobar-$testLocale';
  String moneyAddr, launchedUrl, clipboardText;
  SetClipboardText launchUrl = (BuildContext c, String x) => launchedUrl = x;
  SetClipboardText setClipboardText =
      (BuildContext c, String x) => clipboardText = x;
  TestHttpClient httpClient = TestHttpClient();
  Cruzawl appState = Cruzawl(
      (String x) => 'assets/' + x,
      launchUrl,
      setClipboardText,
      () async => clipboardText,
      databaseFactoryMemoryFs,
      preferences,
      '/',
      NullFileSystem(),
      httpClient: httpClient);
  appState.debugLevel = debugLevelDebug;
  TestWebSocket socket = TestWebSocket();
  CruzPeer peer = appState.addPeer(appState.preferences.peers[0]);
  peer.ws = socket;
  peer.connect();

  testWidgets('WalletApp Init', (WidgetTester tester) async {
    expect(appState.wallets.length, 0);
    WalletApp app = WalletApp(appState, localizationsDelegates,
        () async => null, Stream<String>.empty());
    await tester.pumpWidget(ScopedModel(model: appState, child: app));
    await tester.pumpAndSettle();

    // Enter wallet name
    await tester.enterText(find.byType(TextFormField).at(1), walletName);
    await tester.pumpAndSettle();

    await tester.tap(find.byType(RaisedGradientButton));
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 1));
    await tester.pump(Duration(seconds: 2));
    expect(appState.wallets.length, 1);
    expect(appState.wallet.wallet.addresses.length,
        preferences.minimumReserveAddress);
    for (var address in appState.wallet.wallet.addresses.values) {
      moneyAddr ??= address.publicKey.toJson();
      address.state = AddressState.used;
    }

    // CruzPeer connect
    expect(socket.sent.length, 2);
    var msg = jsonDecode(socket.sent.first);
    expect(msg['type'], 'get_tip_header');
    socket.sent.removeFirst();
    socket.messageHandler(
        '{"type":"tip_header","body":{"block_id":"0000000000000ab4ac72b9b6061cb19195fe1a8a6d5b961f793f6b61f6f9aa9c","header":{"previous":"0000000000003e69ff6f9e82aed1edf4fbeff282f483a155f15993a1d5b388f1","hash_list_root":"e621df23f3d1cbf31ff55eb35b58f149e1119f9bcaaeddbfd50a0492d761b3fe","time":1567226693,"target":"0000000000005a51944cead8d0ecf64b7b699564debb11582725296e08f6907b","chain_work":"0000000000000000000000000000000000000000000000001cac236eabb61ced","nonce":1339749016450629,"height":25352,"transaction_count":20},"time_seen":1567226903}}');
    msg = jsonDecode(socket.sent.first);
    expect(msg['type'], 'get_transaction_relay_policy');
    socket.sent.removeFirst();
    socket.messageHandler(
        '{"type":"transaction_relay_policy","body":{"min_fee":1000000,"min_amount":1000000}}');

    expect(appState.network.tipHeight, 25352);
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 1));

    await expectWalletLoadProtocol(tester, appState, socket, moneyAddr);
    expect(socket.sent.length, 0);
    expect(appState.wallet.wallet.balance, moneyBalance);
  });

  testWidgets('WalletReceiveWidget', (WidgetTester tester) async {
    Wallet wallet = appState.wallet.wallet;
    await tester.pumpWidget(ScopedModel(
        model: appState, child: WalletApp(appState, localizationsDelegates)));
    await tester.pumpAndSettle();

    // Open Receive
    await tester.tap(find.text(l10n.receive));
    await tester.pumpAndSettle();
    String publicKey = wallet.receiveAddress.publicKey.toJson();
    expect(find.text(publicKey), findsOneWidget);

    //await tester.tap(find.text(l10n.generateNewAddress));
    //await tester.pumpAndSettle();

    // Open WalletAddressWidget
    //await tester.tap(find.text(publicKey));
    CopyableText address =
        find.widgetWithText(CopyableText, publicKey).evaluate().first.widget;
    address.onTap();
    await tester.pumpAndSettle();
    expect(find.text(l10n.chainCode), findsOneWidget);
  });

  testWidgets('WalletSettingsWidget Verify', (WidgetTester tester) async {
    Wallet wallet = appState.wallet.wallet;
    await tester.pumpWidget(ScopedModel(
        model: appState,
        child: MaterialApp(
            localizationsDelegates: localizationsDelegates,
            supportedLocales: supportedLocales,
            home: SimpleScaffold(WalletSettingsWidget(wallet),
                title: wallet.name))));
    await tester.pumpAndSettle();
    await tester.drag(find.text(l10n.addresses), Offset(0.0, -600));
    await tester.pump();
    await tester.tap(find.widgetWithText(RaisedGradientButton, l10n.verify));
    await tester.pump(Duration(seconds: 1));
    await tester.pump(Duration(seconds: 2));
    expect(find.text(l10n.verifyWalletResults(3, 3, 11, 11)), findsOneWidget);
  });

  testWidgets('WalletSettingsWidget Copy Public Keys',
      (WidgetTester tester) async {
    Wallet wallet = appState.wallet.wallet;
    await tester.pumpWidget(ScopedModel(
        model: appState,
        child: MaterialApp(
            localizationsDelegates: localizationsDelegates,
            supportedLocales: supportedLocales,
            home: SimpleScaffold(WalletSettingsWidget(wallet),
                title: wallet.name))));
    await tester.pumpAndSettle();
    await tester.drag(find.text(l10n.addresses), Offset(0.0, -600));
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 1));

    // await tester.tap(find.widgetWithText(RaisedGradientButton, l10n.copyPublicKeys));
    RaisedGradientButton copy = find
        .widgetWithText(RaisedGradientButton, l10n.copyAddresses)
        .evaluate()
        .first
        .widget;
    copy.onPressed();
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 1));

    String publicKeyList = '';
    for (Address address in wallet.addresses.values.toList()
      ..sort(Address.compareBalance)) {
      publicKeyList += '${address.publicKey.toJson()}\n';
    }
    expect(clipboardText, publicKeyList);
  });

  testWidgets('WalletSettingsWidget Enable encryption',
      (WidgetTester tester) async {
    await tester.pumpWidget(ScopedModel(
        model: appState,
        child: ScopedModel(
            model: appState.wallet,
            child: MaterialApp(
                localizationsDelegates: localizationsDelegates,
                supportedLocales: supportedLocales,
                home: Container(),
                routes: <String, WidgetBuilder>{
                  '/enableEncryption': (BuildContext context) => SimpleScaffold(
                      EnableEncryptionWidget(),
                      title: Localization.of(context).encryption),
                },
                onGenerateRoute: CruzawlRoutes(appState,
                        includeWalletRoutes: true, blockChartSearchBar: true)
                    .onGenerateRoute,
                initialRoute: '/settings'))));
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 1));

    // Open EnableEncryptionWidget
    Finder parent = find.ancestor(
        of: find.text(l10n.encryption), matching: find.byType(ListTile));
    await tester
        .tap(find.descendant(of: parent, matching: find.byType(Switch)));
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 1));
    expect(find.widgetWithText(RaisedGradientButton, l10n.encrypt),
        findsOneWidget);

    // Enable encryption
    expect(find.byType(TextFormField), findsNWidgets(2));
    await tester.enterText(find.byType(TextFormField).at(0), password);
    await tester.enterText(find.byType(TextFormField).at(1), password);
    await tester.tap(find.byType(RaisedGradientButton));
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 1));
    expect(find.text(l10n.theme), findsOneWidget);
    expect(preferences.walletsEncrypted, true);
  });

  testWidgets('WalletApp load encrypted', (WidgetTester tester) async {
    await tester
        .runAsync(() async => await preferences.setMinimumReserveAddress(0));
    Wallet wallet = appState.wallet.wallet;
    for (Address address in wallet.addresses.values) {
      address.state = AddressState.open;
      await tester.runAsync(() async =>
          await wallet.updateAddressState(address, AddressState.used));
    }
    appState.wallets = <WalletModel>[];
    WalletApp app = WalletApp(appState, localizationsDelegates,
        () async => null, Stream<String>.empty());
    await tester.pumpWidget(ScopedModel(model: appState, child: app));
    await tester.pumpAndSettle();
    expect(find.text(l10n.unlockTitle), findsOneWidget);
    await tester.enterText(find.byType(TextFormField), password);
    await tester.tap(find.byType(RaisedGradientButton));
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 1));

    await expectWalletLoadProtocol(tester, appState, socket, moneyAddr);
    expect(socket.sent.length, 0);
    expect(appState.wallet.wallet.balance, moneyBalance);
  });

  testWidgets('WalletSendWidget', (WidgetTester tester) async {
    Wallet wallet = appState.wallet.wallet;
    expect(wallet.transactions.length, 1);
    await tester.pumpWidget(ScopedModel(
        model: appState, child: WalletApp(appState, localizationsDelegates)));
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 1));

    // Open Send
    await tester.tap(find.text(l10n.send));
    await tester.pumpAndSettle();

    /// Select from
    await tester.tap(find.text(l10n.from));
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 1));
    await tester.tap(find.text(moneyAddr));
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 1));

    /// Open contacts
    String contactName = 'Foobar Contact';
    expect(preferences.contacts.length, 0);
    await tester.tap(find.text(l10n.payTo));
    await tester.pumpAndSettle();

    /// Add contact
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), contactName);
    await tester.enterText(find.byType(TextFormField).at(1), sendTo);
    await tester.tap(find.widgetWithText(RaisedGradientButton, l10n.create));
    await tester.pumpAndSettle();

    /// Select contact
    expect(preferences.contacts.length, 1);
    await tester.tap(find.text(contactName));
    await tester.pumpAndSettle();
    //await tester.enterText(find.byType(TextFormField).at(1), sendTo);

    // Enter amount
    await tester.enterText(
        find.byType(TextFormField).at(3), sendMoney.toString());
    await tester.pumpAndSettle();

    // Send
    //await tester.tap(find.widgetWithText(RaisedGradientButton, l10n.send));
    RaisedGradientButton send = find
        .widgetWithText(RaisedGradientButton, l10n.send)
        .evaluate()
        .first
        .widget;
    send.onPressed();
    await tester.pumpAndSettle();
    expect(socket.sent.length, 1);
    var msg = jsonDecode(socket.sent.first);
    expect(msg['type'], 'push_transaction');
    CruzTransaction transaction =
        CruzTransaction.fromJson(msg['body']['transaction']);
    expect(transaction.from.toJson(), moneyAddr);
    expect(transaction.to.toJson(), sendTo);
    expect(transaction.amount, sendMoneyBalance);
    expect(transaction.verify(), true);

    String transactionId = transaction.id().toJson();
    socket.sent.removeFirst();
    socket.messageHandler(
        '{"type":"push_transaction_result","body":{"transaction_id":"$transactionId"}}');
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 1));
    await tester.pump(Duration(seconds: 2));
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 1));
    await tester.pump(Duration(seconds: 2));
    expect(find.text(l10n.sentTransactionId(transactionId)), findsOneWidget);
    await tester.pump(Duration(seconds: 1));
    await tester.pump(Duration(seconds: 2));
    await tester.pumpAndSettle();
    expect(wallet.transactions.length, 2);
  });

  testWidgets('WalletBalanceWidget', (WidgetTester tester) async {
    Wallet wallet = appState.wallet.wallet;
    await tester.pumpWidget(ScopedModel(
        model: appState, child: WalletApp(appState, localizationsDelegates)));
    await tester.pumpAndSettle();
    expect(
        find.text(
            cruz.format(moneyBalance - sendMoneyBalance - feeMoneyBalance)),
        findsOneWidget);
    await tester.drag(
        find.byType(TransactionListTile).at(0), Offset(0.0, -600));

    expect(wallet.transactions.length, 2);
    List<Element> transactions =
        find.byType(TransactionListTile).evaluate().toList();
    expect(transactions.length, 2);
    TransactionListTile transaction = transactions[0].widget;
    expect(transaction.tx.inputs.length, 1);
    expect(transaction.tx.outputs.length, 1);
    expect(transaction.tx.inputs[0].fromText, moneyAddr);
    expect(transaction.tx.outputs[0].toText, sendTo);
    expect(transaction.tx.amount, sendMoneyBalance);
    expect(transaction.tx.verify(), true);

    transaction = transactions[1].widget;
    expect(transaction.tx.inputs.length, 1);
    expect(transaction.tx.outputs.length, 1);
    expect(transaction.tx.inputs[0].fromText, moneySender);
    expect(transaction.tx.outputs[0].toText, moneyAddr);
    expect(transaction.tx.amount, moneyBalance);
    expect(transaction.tx.verify(), false);
  });

  testWidgets('AddWalletWidget watch-only wallet', (WidgetTester tester) async {
    expect(appState.wallets.length, 1);
    await tester.pumpWidget(ScopedModel(
        model: appState,
        child: MaterialApp(
            localizationsDelegates: localizationsDelegates,
            supportedLocales: supportedLocales,
            home: SimpleScaffold(AddWalletWidget(appState),
                title: l10n.addWallet))));
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 1));

    // Disable HD wallet switch
    expect(find.byType(SwitchListTile), findsOneWidget);
    await tester.tap(find.byType(SwitchListTile));
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 1));

    // Enable watch-only wallet switch
    expect(find.byType(SwitchListTile), findsNWidgets(2));
    await tester.tap(find.byType(SwitchListTile).at(1));
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 1));

    // Enter name & private key
    expect(find.byType(TextFormField), findsNWidgets(3));
    await tester.enterText(find.byType(TextFormField).at(1), watchWalletName);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(2), moneyAddr);
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 1));

    // Generate
    expect(find.byType(RaisedGradientButton), findsOneWidget);
    await tester.tap(find.byType(RaisedGradientButton));
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 1));
    expect(appState.wallets.length, 2);

    expect(appState.wallet.wallet.addresses.length, 1);
    for (var address in appState.wallet.wallet.addresses.values) {
      address.state = AddressState.used;
    }

    await expectWalletLoadProtocol(tester, appState, socket, moneyAddr);
    expect(socket.sent.length, 0);
  });

  testWidgets('WalletSettingsWidget Delete', (WidgetTester tester) async {
    Wallet wallet = appState.wallet.wallet;
    await tester.pumpWidget(ScopedModel(
        model: appState,
        child: MaterialApp(
            localizationsDelegates: localizationsDelegates,
            supportedLocales: supportedLocales,
            home: SimpleScaffold(WalletSettingsWidget(wallet),
                title: wallet.name))));
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 1));
    expect(find.text(l10n.name), findsOneWidget);
    expect(
        find.descendant(
            of: find.byType(ListTile), matching: find.text(watchWalletName)),
        findsOneWidget);

    // Open delete wallet AlertDialog
    await tester.tap(find.descendant(
        of: find.byType(RaisedButton),
        matching: find.text(l10n.deleteThisWallet)));
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 1));

    // Delete the wallet
    await tester.tap(find.text(l10n.delete));
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 1));
    expect(appState.wallets.length, 1);
  });

  test('CruzPeerNetwork shutdown', () {
    appState.network.shutdown();
  });
}

void expectWalletLoadProtocol(WidgetTester tester, Cruzawl appState,
    TestWebSocket socket, String moneyAddr) async {
  Wallet wallet = appState.wallet.wallet;
  int addresses = wallet.addresses.length;

  // filter_add
  expect(socket.sent.length, addresses);
  for (int i = 0; i < addresses; i++) {
    var msg = jsonDecode(socket.sent.first);
    expect(msg['type'], 'filter_add');
    expect(
        appState.wallet.wallet.addresses
            .containsKey(msg['body']['public_keys'][0]),
        true);
    socket.sent.removeFirst();
    socket.messageHandler('{"type":"filter_result"}');
  }
  await tester.pumpAndSettle();
  await tester.pump(Duration(seconds: 1));

  // get_balance
  expect(socket.sent.length, addresses);
  for (int i = 0; i < addresses; i++) {
    var msg = jsonDecode(socket.sent.first);
    expect(msg['type'], 'get_balance');
    String addr = msg['body']['public_key'];
    int balance = addr == moneyAddr ? moneyBalance : 0;
    expect(appState.wallet.wallet.addresses.containsKey(addr), true);
    socket.sent.removeFirst();
    socket.messageHandler(
        '{"type":"balance","body":{"block_id":"0000000000000ab4ac72b9b6061cb19195fe1a8a6d5b961f793f6b61f6f9aa9c","height":25352,"public_key":"$addr","balance":$balance}}');
  }
  await tester.pumpAndSettle();
  await tester.pump(Duration(seconds: 1));

  // get_public_key_transactions
  expect(socket.sent.length, addresses);
  for (int i = 0; i < addresses; i++) {
    var msg = jsonDecode(socket.sent.first);
    expect(msg['type'], 'get_public_key_transactions');
    String addr = msg['body']['public_key'];
    expect(appState.wallet.wallet.addresses.containsKey(addr), true);
    socket.sent.removeFirst();
    if (addr == moneyAddr) {
      socket.messageHandler(
          '{"type":"public_key_transactions","body":{"public_key":"$addr","start_height":25352,"stop_height":0,"stop_index":0,"filter_blocks":[{"block_id":"00000000000555de1d28a55fd2d5d2069c61fd46c4618cfea16c5adf6d902f4d","header":{"previous":"000000000001e0313c0536e700a8e6c02b2fc6bbddb755d749d6e00746d52b2b","hash_list_root":"3c1b3f728653444e8bca498bf5a6d76a259637e592f749ad881f1f1da0087db0","time":1564553276,"target":"000000000007a38c469f3be96898a11435ea27592c2bae351147392e9cd3408d","chain_work":"00000000000000000000000000000000000000000000000000faa7649c97e894","nonce":1989109050083893,"height":17067,"transaction_count":2},"transactions":[{"time":1564550817,"nonce":1130916028,"from":"$moneySender","to":"$addr","amount":$moneyBalance,"fee":1000000,"expires":17068,"series":17,"signature":"mcvGJ59Q9U9j5Tbjk/gIKYPFmz3lXNb3t8DwkznINJWI7uFPymmywBJjE18UzL2+MMicm0xbyKVJ3XEvQiQ5BQ=="}]}]}}');
    } else {
      socket.messageHandler(
          '{"type":"public_key_transactions","body":{"public_key":"$addr","start_height":25352,"stop_height":0,"stop_index":0,"filter_blocks":null}}');
    }
  }
  await tester.pumpAndSettle();
  await tester.pump(Duration(seconds: 1));

  // get_filter_transaction_queue
  expect(socket.sent.length, 1);
  var msg = jsonDecode(socket.sent.first);
  expect(msg['type'], 'get_filter_transaction_queue');
  socket.sent.removeFirst();
  socket.messageHandler(
      '{"type":"filter_transaction_queue","body":{"transactions":null}}');
  await tester.pumpAndSettle();
  await tester.pump(Duration(seconds: 1));
}
