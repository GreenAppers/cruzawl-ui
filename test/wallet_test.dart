// Copyright 2019 cruzall developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
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
import 'package:cruzawl/test.dart';
import 'package:cruzawl/util.dart';
import 'package:cruzawl/wallet.dart';
import 'package:cruzawl/websocket.dart';

import 'package:cruzawl_ui/localization.dart';
import 'package:cruzawl_ui/model.dart';
import 'package:cruzawl_ui/routes.dart';
import 'package:cruzawl_ui/ui.dart';
import 'package:cruzawl_ui/wallet/add.dart';
import 'package:cruzawl_ui/wallet/app.dart';
import 'package:cruzawl_ui/wallet/address.dart';
import 'package:cruzawl_ui/wallet/balance.dart';
import 'package:cruzawl_ui/wallet/contacts.dart';
import 'package:cruzawl_ui/wallet/receive.dart';
import 'package:cruzawl_ui/wallet/send.dart';
import 'package:cruzawl_ui/wallet/settings.dart';

void main() async {
  for (Locale locale in Localization.supportedLocales) {
    CruzawlPreferences preferences = CruzawlPreferences(
        await databaseFactoryMemoryFs
            .openDatabase('settings_wallet_$locale.db'),
        () => NumberFormat.currency().currencyName);
    await preferences.load();
    preferences.networkEnabled = false;
    preferences.minimumReserveAddress = 3;
    Localization localization = await Localization.load(locale);
    group('Wallet tests $locale',
        () => runWalletTests(preferences, locale, localization));
  }
}

void runWalletTests(
    CruzawlPreferences preferences, Locale testLocale, Localization locale) {
  List<LocalizationsDelegate> localizationsDelegates = <LocalizationsDelegate>[
    LocalizationDelegate(),
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate
  ];
  List<Locale> supportedLocales = <Locale>[testLocale];

  SetClipboardText stringCallback = (BuildContext c, String x) {};
  TestHttpClient httpClient = TestHttpClient();
  Cruzawl appState = Cruzawl((String x) => x, stringCallback, stringCallback,
      null, databaseFactoryMemoryFs, preferences, '/', NullFileSystem(),
      httpClient: httpClient);
  appState.debugLevel = debugLevelDebug;
  TestWebSocket socket = TestWebSocket();
  CruzPeer peer = appState.addPeer(appState.preferences.peers[0]);
  peer.ws = socket;
  peer.connect();

  num sendMoney = 3.29, feeMoney = 0.01;
  int money = 13, moneyBalance = money * CRUZ.cruzbitsPerCruz;
  int sendMoneyBalance = (sendMoney * CRUZ.cruzbitsPerCruz).toInt();
  int feeMoneyBalance = (feeMoney * CRUZ.cruzbitsPerCruz).toInt();
  int feeBalance = (feeMoney * CRUZ.cruzbitsPerCruz).toInt();
  String moneyAddr,
      moneySender = 'xRL0D9U+jav9NxOwz4LsXe8yZ8KSS7Hst4/P8ChciAI=';
  String sendTo = '5lojzpXqrpAfrYSxF0s8vyRSQ0SlhiovzacD+tI1oK8=';
  String walletName = 'normalFoolbar-$testLocale';
  String watchWalletName = 'watchOnlyFoobar-$testLocale';

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
      address.state = AddressState.used;
    }
  });

  test('CruzPeer connect', () {
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
  });

  test('CruzPeer filter_add', () {
    expect(socket.sent.length, 3);
    for (int i = 0; i < 3; i++) {
      var msg = jsonDecode(socket.sent.first);
      expect(msg['type'], 'filter_add');
      expect(
          appState.wallet.wallet.addresses
              .containsKey(msg['body']['public_keys'][0]),
          true);
      socket.sent.removeFirst();
      socket.messageHandler('{"type":"filter_result"}');
    }
  });

  test('CruzPeer get_balance', () {
    expect(socket.sent.length, 3);
    for (int i = 0; i < 3; i++) {
      var msg = jsonDecode(socket.sent.first);
      expect(msg['type'], 'get_balance');
      String addr = msg['body']['public_key'];
      if (i == 0) moneyAddr = addr;
      int balance = i == 0 ? moneyBalance : 0;
      expect(appState.wallet.wallet.addresses.containsKey(addr), true);
      socket.sent.removeFirst();
      socket.messageHandler(
          '{"type":"balance","body":{"block_id":"0000000000000ab4ac72b9b6061cb19195fe1a8a6d5b961f793f6b61f6f9aa9c","height":25352,"public_key":"$addr","balance":$balance}}');
    }
  });

  test('CruzPeer get_public_key_transactions', () {
    expect(socket.sent.length, 3);
    for (int i = 0; i < 3; i++) {
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
  });

  test('CruzPeer get_filter_transaction_queue', () {
    expect(socket.sent.length, 1);
    var msg = jsonDecode(socket.sent.first);
    expect(msg['type'], 'get_filter_transaction_queue');
    socket.sent.removeFirst();
    socket.messageHandler(
        '{"type":"filter_transaction_queue","body":{"transactions":null}}');
  });

  test('Wallet load', () {
    expect(socket.sent.length, 0);
    expect(appState.wallet.wallet.balance, moneyBalance);
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
    await tester.drag(find.text(locale.addresses), Offset(0.0, -600));
    await tester.pump();
    await tester.tap(find.widgetWithText(RaisedGradientButton, locale.verify));
    await tester.pump(Duration(seconds: 1));
    await tester.pump(Duration(seconds: 2));
    expect(find.text(locale.verifyWalletResults(3, 3, 11, 11)), findsOneWidget);
  });

  testWidgets('WalletSendWidget', (WidgetTester tester) async {
    Wallet wallet = appState.wallet.wallet;
    expect(wallet.transactions.length, 1);
    await tester.pumpWidget(ScopedModel(
        model: appState,
        child: ScopedModel(
            model: appState.wallet,
            child: MaterialApp(
                localizationsDelegates: localizationsDelegates,
                supportedLocales: supportedLocales,
                home: SimpleScaffold(WalletSendWidget(wallet),
                    title: wallet.name),
                onGenerateRoute: CruzawlRoutes(appState,
                        includeWalletRoutes: true, cruzbaseSearchBar: true)
                    .onGenerateRoute,
                routes: <String, WidgetBuilder>{
                  '/sendFrom': (BuildContext context) => SimpleScaffold(
                      SendFromWidget(wallet),
                      title: Localization.of(context).from),
                }))));
    await tester.pumpAndSettle();

    /// Select from
    await tester.tap(find.text(locale.from));
    await tester.pumpAndSettle();
    await tester.tap(find.text(moneyAddr));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(1), sendTo);
    await tester.enterText(
        find.byType(TextFormField).at(3), sendMoney.toString());
    await tester.tap(find.widgetWithText(RaisedGradientButton, locale.send));
    await tester.pump(Duration(seconds: 1));
    await tester.pump(Duration(seconds: 2));
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
    expect(find.text(locale.sentTransactionId(transactionId)), findsOneWidget);
    await tester.pump(Duration(seconds: 1));
    await tester.pump(Duration(seconds: 2));
    await tester.pumpAndSettle();
    expect(wallet.transactions.length, 2);
  });

  testWidgets('WalletBalanceWidget', (WidgetTester tester) async {
    Wallet wallet = appState.wallet.wallet;
    await tester.pumpWidget(ScopedModel(
        model: appState,
        child: ScopedModel(
            model: appState.wallet,
            child: MaterialApp(
                localizationsDelegates: localizationsDelegates,
                supportedLocales: supportedLocales,
                home: SimpleScaffold(WalletBalanceWidget(),
                    title: wallet.name)))));
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
    expect(transaction.tx.from.toJson(), moneyAddr);
    expect(transaction.tx.to.toJson(), sendTo);
    expect(transaction.tx.amount, sendMoneyBalance);
    expect(transaction.tx.verify(), true);

    transaction = transactions[1].widget;
    expect(transaction.tx.from.toJson(), moneySender);
    expect(transaction.tx.to.toJson(), moneyAddr);
    expect(transaction.tx.amount, moneyBalance);
    expect(transaction.tx.verify(), false);
  });

  testWidgets('WalletAddressWidget', (WidgetTester tester) async {
    Wallet wallet = appState.wallet.wallet;
    await tester.pumpWidget(ScopedModel(
        model: appState,
        child: ScopedModel(
            model: appState.wallet,
            child: MaterialApp(
                localizationsDelegates: localizationsDelegates,
                supportedLocales: supportedLocales,
                home: SimpleScaffold(
                    AddressWidget(wallet, wallet.addresses[moneyAddr]),
                    title: wallet.name)))));
    await tester.pumpAndSettle();
  });

  testWidgets('WalletReceiveWidget', (WidgetTester tester) async {
    Wallet wallet = appState.wallet.wallet;
    await tester.pumpWidget(ScopedModel(
        model: appState,
        child: ScopedModel(
            model: appState.wallet,
            child: MaterialApp(
                localizationsDelegates: localizationsDelegates,
                supportedLocales: supportedLocales,
                home: SimpleScaffold(WalletReceiveWidget(), title: wallet.name),
                onGenerateRoute: CruzawlRoutes(appState,
                        includeWalletRoutes: true, cruzbaseSearchBar: true)
                    .onGenerateRoute))));
    await tester.pumpAndSettle();
    //await tester.tap(find.text(locale.generateNewAddress));
    //await tester.pumpAndSettle();
    await tester
        .tap(find.text(wallet.getNextReceiveAddress().publicKey.toJson()));
    await tester.pumpAndSettle();
  });

  testWidgets('AddWalletWidget watch-only wallet', (WidgetTester tester) async {
    expect(appState.wallets.length, 1);
    AddWalletWidget addWallet = AddWalletWidget(appState);
    await tester.pumpWidget(ScopedModel(
        model: appState,
        child: MaterialApp(
            localizationsDelegates: localizationsDelegates,
            supportedLocales: supportedLocales,
            home: SimpleScaffold(AddWalletWidget(appState),
                title: locale.addWallet))));
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
  });

  test('watch-only wallet CruzPeer filter_add', () {
    expect(socket.sent.length, 1);
    var msg = jsonDecode(socket.sent.first);
    expect(msg['type'], 'filter_add');
    expect(msg['body']['public_keys'][0], moneyAddr);
    socket.sent.removeFirst();
    socket.messageHandler('{"type":"filter_result"}');
  });

  /*test('watch-only wallet CruzPeer get_balance', () {
    expect(socket.sent.length, 1);
    var msg = jsonDecode(socket.sent.first);
    expect(msg['type'], 'get_balance');
    String addr = msg['body']['public_key'];
    expect(addr, moneyAddr);
    socket.sent.removeFirst();
    socket.messageHandler(
        '{"type":"balance","body":{"block_id":"0000000000000ab4ac72b9b6061cb19195fe1a8a6d5b961f793f6b61f6f9aa9c","height":25352,"public_key":"$addr","balance":$moneyBalance}}');
  });

  test('watch-only wallet CruzPeer get_public_key_transactions', () {
    expect(socket.sent.length, 1);
    var msg = jsonDecode(socket.sent.first);
    expect(msg['type'], 'get_public_key_transactions');
    String addr = msg['body']['public_key'];
    expect(addr, moneyAddr);
    socket.sent.removeFirst();
    socket.messageHandler(
        '{"type":"public_key_transactions","body":{"public_key":"$addr","start_height":25352,"stop_height":0,"stop_index":0,"filter_blocks":[{"block_id":"00000000000555de1d28a55fd2d5d2069c61fd46c4618cfea16c5adf6d902f4d","header":{"previous":"000000000001e0313c0536e700a8e6c02b2fc6bbddb755d749d6e00746d52b2b","hash_list_root":"3c1b3f728653444e8bca498bf5a6d76a259637e592f749ad881f1f1da0087db0","time":1564553276,"target":"000000000007a38c469f3be96898a11435ea27592c2bae351147392e9cd3408d","chain_work":"00000000000000000000000000000000000000000000000000faa7649c97e894","nonce":1989109050083893,"height":17067,"transaction_count":2},"transactions":[{"time":1564550817,"nonce":1130916028,"from":"$moneySender","to":"$addr","amount":$moneyBalance,"fee":1000000,"expires":17068,"series":17,"signature":"mcvGJ59Q9U9j5Tbjk/gIKYPFmz3lXNb3t8DwkznINJWI7uFPymmywBJjE18UzL2+MMicm0xbyKVJ3XEvQiQ5BQ=="}]}]}}');
  });*/

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
    await expect(find.text(locale.name), findsOneWidget);
    await expect(
        find.descendant(
            of: find.byType(ListTile), matching: find.text(watchWalletName)),
        findsOneWidget);

    // Open delete wallet AlertDialog
    await tester.tap(find.descendant(
        of: find.byType(RaisedButton),
        matching: find.text(locale.deleteThisWallet)));
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 1));

    // Delete the wallet
    await tester.tap(find.text(locale.delete));
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 1));
    expect(appState.wallets.length, 1);
  });

  test('CruzPeerNetwork shutdown', () {
    appState.network.shutdown();
  });
}
