// Copyright 2019 cruzall developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

import 'dart:convert';

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
import 'package:cruzawl/network.dart';
import 'package:cruzawl/sembast.dart';
import 'package:cruzawl/util.dart';
import 'package:cruzawl/wallet.dart';
import 'package:cruzawl/websocket.dart';

import 'package:cruzawl_ui/localization.dart';
import 'package:cruzawl_ui/model.dart';
import 'package:cruzawl_ui/routes.dart';
import 'package:cruzawl_ui/ui.dart';
import 'package:cruzawl_ui/explorer/chart/block.dart';
import 'package:cruzawl_ui/explorer/settings.dart';

void main() async {
  await runExplorerGroups((String asset) => 'assets/' + asset);
}

Future<void> runExplorerGroups(StringFilter assetPath) async {
  for (Locale locale in Localization.supportedLocales) {
    CruzawlPreferences preferences = CruzawlPreferences(
        SembastPreferences(await databaseFactoryMemoryFs
            .openDatabase('settings_explorer_$locale.db')),
        () => NumberFormat.currency().currencyName);
    await preferences.storage.load();
    await preferences.setNetworkEnabled(false);
    await preferences.setMinimumReserveAddress(3);
    Localization l10n = await Localization.load(locale);
    group('Explorer tests $locale',
        () => runExplorerTests(preferences, locale, l10n, assetPath));
  }
}

void runExplorerTests(CruzawlPreferences preferences, Locale testLocale,
    Localization l10n, StringFilter assetPath) {
  List<LocalizationsDelegate> localizationsDelegates = <LocalizationsDelegate>[
    LocalizationDelegate(),
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate
  ];
  List<Locale> supportedLocales = <Locale>[testLocale];

  SetClipboardText stringCallback = (BuildContext c, String x) {};
  TestHttpClient httpClient = TestHttpClient();
  Cruzawl appState = Cruzawl(assetPath, stringCallback, stringCallback, null,
      databaseFactoryMemoryFs, preferences, '/', NullFileSystem(),
      packageInfo:
          PackageInfo('Cruzall', 'com.greenappers.cruzall', '1.0.0', '0'),
      httpClient: httpClient);
  appState.debugLevel = debugLevelDebug;
  appState.preferences.setDebugLog(true);
  TestWebSocket socket = TestWebSocket();
  Currency currency = Currency.fromJson('CRUZ');
  CruzPeer peer;

  String addressText = '5lojzpXqrpAfrYSxF0s8vyRSQ0SlhiovzacD+tI1oK8=';
  String tipBlockId =
      '0000000000000ab4ac72b9b6061cb19195fe1a8a6d5b961f793f6b61f6f9aa9c';
  String previousBlockId =
      '0000000000003e69ff6f9e82aed1edf4fbeff282f483a155f15993a1d5b388f1';
  String chainWork =
      '00000000000000000000000000000000000000000000000029fbd65f3156de92';
  String nonce = '568670894';
  String transactionId =
      '8d7356420c301d41462a2e1646f43b6841a86d4e8809439a2003e05bd2330a8f';

  test('CruzPeer connect', () async {
    await appState.addWallet(
        Wallet.fromPublicKeyList(
            databaseFactoryMemoryFs,
            appState.fileSystem,
            'empty.cruzall',
            'Empty wallet',
            findPeerNetworkForCurrency(appState.networks, currency),
            Seed(randBytes(64)),
            <PublicAddress>[currency.nullAddress],
            appState.preferences,
            debugPrint,
            appState.openedWallet),
        store: false);

    peer = appState.addPeer(appState.preferences.peers[0]);
    peer.ws = socket;
    peer.connect();

    expect(socket.sent.length, 2);
    var msg = jsonDecode(socket.sent.first);
    expect(msg['type'], 'get_tip_header');
    socket.sent.removeFirst();
    socket.messageHandler(
        '{"type":"tip_header","body":{"block_id":"$tipBlockId","header":{"previous":"$previousBlockId","hash_list_root":"e621df23f3d1cbf31ff55eb35b58f149e1119f9bcaaeddbfd50a0492d761b3fe","time":1567226693,"target":"0000000000005a51944cead8d0ecf64b7b699564debb11582725296e08f6907b","chain_work":"0000000000000000000000000000000000000000000000001cac236eabb61ced","nonce":1339749016450629,"height":25352,"transaction_count":20},"time_seen":1567226903}}');

    msg = jsonDecode(socket.sent.first);
    expect(msg['type'], 'get_transaction_relay_policy');
    socket.sent.removeFirst();
    socket.messageHandler(
        '{"type":"transaction_relay_policy","body":{"min_fee":1000000,"min_amount":1000000}}');
    expect(appState.network.tipHeight, 25352);
    await pumpEventQueue();

    // filter_add
    expect(socket.sent.length, 1);
    msg = jsonDecode(socket.sent.first);
    expect(msg['type'], 'filter_add');
    expect(msg['body']['public_keys'][0], cruz.nullAddress.toJson());
    socket.sent.removeFirst();
    socket.messageHandler('{"type":"filter_result"}');
    await pumpEventQueue();

    // get_balance
    expect(socket.sent.length, 1);
    msg = jsonDecode(socket.sent.first);
    expect(msg['type'], 'get_balance');
    String addr = msg['body']['public_key'];
    int balance = 0;
    expect(addr, cruz.nullAddress.toJson());
    socket.sent.removeFirst();
    socket.messageHandler(
        '{"type":"balance","body":{"block_id":"0000000000000ab4ac72b9b6061cb19195fe1a8a6d5b961f793f6b61f6f9aa9c","height":25352,"public_key":"$addr","balance":$balance}}');
    await pumpEventQueue();

    // get_public_key_transactions
    expect(socket.sent.length, 1);
    msg = jsonDecode(socket.sent.first);
    expect(msg['type'], 'get_public_key_transactions');
    addr = msg['body']['public_key'];
    expect(addr, cruz.nullAddress.toJson());
    socket.sent.removeFirst();
    socket.messageHandler(
        '{"type":"public_key_transactions","body":{"public_key":"$addr","start_height":25352,"stop_height":0,"stop_index":0,"filter_blocks":null}}');
    await pumpEventQueue();

    // get_filter_transaction_queue
    expect(socket.sent.length, 1);
    msg = jsonDecode(socket.sent.first);
    expect(msg['type'], 'get_filter_transaction_queue');
    socket.sent.removeFirst();
    socket.messageHandler(
        '{"type":"filter_transaction_queue","body":{"transactions":null}}');
    await pumpEventQueue();
  });

  testWidgets('ExternalAddressWidget', (WidgetTester tester) async {
    await tester.pumpWidget(ScopedModel(
        model: appState,
        child: ScopedModel(
            model: appState.wallet,
            child: MaterialApp(
                localizationsDelegates: localizationsDelegates,
                supportedLocales: supportedLocales,
                home: Container(),
                onGenerateRoute: CruzawlRoutes(appState,
                        includeWalletRoutes: true, blockChartSearchBar: true)
                    .onGenerateRoute,
                initialRoute: '/address/$addressText'))));
    await tester.pump(Duration(seconds: 1));

    expect(socket.sent.length, 1);
    var msg = jsonDecode(socket.sent.first);
    expect(msg['type'], 'get_balance');
    String addr = msg['body']['public_key'];
    num balance = 13.37;
    int moneyBalance = (balance * CRUZ.cruzbitsPerCruz).toInt();
    String moneySender = 'xRL0D9U+jav9NxOwz4LsXe8yZ8KSS7Hst4/P8ChciAI=';
    expect(addr, addressText);
    socket.sent.removeFirst();
    socket.messageHandler(
        '{"type":"balance","body":{"block_id":"0000000000000ab4ac72b9b6061cb19195fe1a8a6d5b961f793f6b61f6f9aa9c","height":25352,"public_key":"$addr","balance":$moneyBalance}}');

    await tester.pump(Duration(seconds: 1));
    expect(socket.sent.length, 1);
    msg = jsonDecode(socket.sent.first);
    expect(msg['type'], 'get_public_key_transactions');
    addr = msg['body']['public_key'];
    expect(addr, addressText);
    socket.sent.removeFirst();
    socket.messageHandler(
        '{"type":"public_key_transactions","body":{"public_key":"$addr","start_height":25352,"stop_height":0,"stop_index":0,"filter_blocks":[{"block_id":"00000000000555de1d28a55fd2d5d2069c61fd46c4618cfea16c5adf6d902f4d","header":{"previous":"000000000001e0313c0536e700a8e6c02b2fc6bbddb755d749d6e00746d52b2b","hash_list_root":"3c1b3f728653444e8bca498bf5a6d76a259637e592f749ad881f1f1da0087db0","time":1564553276,"target":"000000000007a38c469f3be96898a11435ea27592c2bae351147392e9cd3408d","chain_work":"00000000000000000000000000000000000000000000000000faa7649c97e894","nonce":1989109050083893,"height":17067,"transaction_count":2},"transactions":[{"time":1564550817,"nonce":1130916028,"from":"$moneySender","to":"$addr","amount":$moneyBalance,"fee":1000000,"expires":17068,"series":17,"signature":"mcvGJ59Q9U9j5Tbjk/gIKYPFmz3lXNb3t8DwkznINJWI7uFPymmywBJjE18UzL2+MMicm0xbyKVJ3XEvQiQ5BQ=="}]}]}}');

    await tester.pump(Duration(seconds: 1));
    expect(socket.sent.length, 0);
    expect(find.text(l10n.balance), findsOneWidget);
    expect(find.text('$balance'), findsOneWidget);
  });

  testWidgets('BlockWidget', (WidgetTester tester) async {
    await tester.pumpWidget(ScopedModel(
        model: appState,
        child: ScopedModel(
            model: appState.wallet,
            child: MaterialApp(
                localizationsDelegates: localizationsDelegates,
                supportedLocales: supportedLocales,
                home: Container(),
                onGenerateRoute: CruzawlRoutes(appState,
                        includeWalletRoutes: true, blockChartSearchBar: true)
                    .onGenerateRoute,
                initialRoute: '/tip'))));

    await tester.pump(Duration(seconds: 1));
    expect(socket.sent.length, 1);
    var msg = jsonDecode(socket.sent.first);
    expect(msg['type'], 'get_block');
    expect(msg['body']['block_id'], tipBlockId);
    socket.sent.removeFirst();
    socket.messageHandler(
        '{"type":"block","body":{"block_id":"$tipBlockId","block":{"header":{"previous":"$previousBlockId","hash_list_root":"32ce7385c039a70df7fd74cc19cb198ff4f1f2baa5673f2e21610b1553fcd39d","time":1567637897,"target":"0000000000004f964e22081d801e498701aba18e8203e2327984ccdf84835fca","chain_work":"$chainWork","nonce":190254286704880,"height":25352,"transaction_count":1},"transactions":[{"time":1567637704,"nonce":1154811886,"to":"98G12B2Gm75Klo+Z3RL1rit9jtD9ZIJCvJ6Dh4ZNHfs=","amount":5000000000,"series":27}]}}}');

    await tester.pump(Duration(seconds: 1));
    expect(socket.sent.length, 1);
    msg = jsonDecode(socket.sent.first);
    expect(msg['type'], 'get_block_header');
    expect(msg['body']['block_id'], previousBlockId);
    socket.sent.removeFirst();
    socket.messageHandler(
        '{"type":"block_header","body":{"block_id":"$previousBlockId","header":{"previous":"00000000000016b4d4fd6a6b73b13d370023f84b9912083d2e8910a1fa1ba22b","hash_list_root":"3789ee33ed9817a99dfed1c40d2a6dc05d76cdd7a8001b7b570fcfd8f3245c43","time":1567638346,"target":"0000000000004f964e22081d801e498701aba18e8203e2327984ccdf84835fca","chain_work":"0000000000000000000000000000000000000000000000002a057cb894aede85","nonce":119850769305355,"height":26516,"transaction_count":1}}}');

    await tester.pump(Duration(seconds: 1));
    expect(socket.sent.length, 0);
    expect(find.text(l10n.chainWork), findsOneWidget);
    expect(find.text('$chainWork'), findsOneWidget);
  });

  testWidgets('CruzawlConsole', (WidgetTester tester) async {
    await tester.pumpWidget(ScopedModel(
        model: appState,
        child: ScopedModel(
            model: appState.wallet,
            child: MaterialApp(
                localizationsDelegates: localizationsDelegates,
                supportedLocales: supportedLocales,
                home: Container(),
                onGenerateRoute: CruzawlRoutes(appState,
                        includeWalletRoutes: true, blockChartSearchBar: true)
                    .onGenerateRoute,
                initialRoute: '/console'))));
    await tester.pump(Duration(seconds: 1));

    await tester.tap(find.byType(RaisedGradientButton));
    await tester.pump(Duration(seconds: 1));
    expect(socket.sent.length, 1);
    var msg = jsonDecode(socket.sent.first);
    expect(msg['type'], 'get_tip_header');
    socket.sent.removeFirst();
    socket.messageHandler(
        '{"type":"tip_header","body":{"block_id":"0000000000001bfae2632eac057f090d5adcce5f3131fe36d9cdf34cc0184106","header":{"previous":"00000000000001513800d8a347a374ec33963ea06a7527677b4784b2a15753d1","hash_list_root":"133a6657cc2b68a7a495f93a26eb8ae6c9d03b61de2baef628c9c3868ce26217","time":1567651882,"target":"0000000000004f964e22081d801e498701aba18e8203e2327984ccdf84835fca","chain_work":"0000000000000000000000000000000000000000000000002ab99de7d319883d","nonce":105066634308909,"height":26572,"transaction_count":1},"time_seen":1567651980}}');

    await tester.pump(Duration(seconds: 1));
    expect(socket.sent.length, 0);
  });

  testWidgets('BlockChartWidget', (WidgetTester tester) async {
    final SimpleScaffoldActions searchBar =
        SimpleScaffoldActions(<Widget>[], searchBar: true);
    await tester.pumpWidget(ScopedModel(
        model: appState,
        child: ScopedModel(
            model: appState.wallet,
            child: MaterialApp(
                localizationsDelegates: localizationsDelegates,
                supportedLocales: supportedLocales,
                home: ScopedModel(
                    model: searchBar,
                    child: BlockChartWidget(appState.network,
                        fetchBlock: 2,
                        windowDuration: const Duration(hours: 1),
                        bucketDuration: BlockChartBucketDuration.minute)),
                onGenerateRoute: CruzawlRoutes(appState,
                        includeWalletRoutes: true, blockChartSearchBar: true)
                    .onGenerateRoute))));

    int time1 = DateTime.now().millisecondsSinceEpoch ~/ 1000,
        time2 = time1 - 60 * 60 * 6;
    await tester.pump(Duration(seconds: 1));
    expect(socket.sent.length, 2);
    var msg = jsonDecode(socket.sent.first);
    String blockJson1 =
        '{"previous":"$previousBlockId","hash_list_root":"32ce7385c039a70df7fd74cc19cb198ff4f1f2baa5673f2e21610b1553fcd39d","time":$time1,"target":"0000000000004f964e22081d801e498701aba18e8203e2327984ccdf84835fca","chain_work":"$chainWork","nonce":190254286704880,"height":25352,"transaction_count":1}';
    CruzBlockHeader block1 = CruzBlockHeader.fromJson(jsonDecode(blockJson1));
    expect(msg['type'], 'get_block_header_by_height');
    socket.sent.removeFirst();
    socket.messageHandler(
        '{"type":"block_header","body":{"block_id":"$tipBlockId","header":$blockJson1,"transactions":[{"time":1567637704,"nonce":1154811886,"to":"98G12B2Gm75Klo+Z3RL1rit9jtD9ZIJCvJ6Dh4ZNHfs=","amount":5000000000,"series":27}]}}');

    String blockJson2 =
        '{"previous":"00000000000016b4d4fd6a6b73b13d370023f84b9912083d2e8910a1fa1ba22b","hash_list_root":"3789ee33ed9817a99dfed1c40d2a6dc05d76cdd7a8001b7b570fcfd8f3245c43","time":$time2,"target":"0000000000004f964e22081d801e498701aba18e8203e2327984ccdf84835fca","chain_work":"0000000000000000000000000000000000000000000000002a057cb894aede85","nonce":119850769305355,"height":26516,"transaction_count":1}';
    //CruzBlockHeader block2 = CruzBlockHeader.fromJson(jsonDecode(blockJson2));
    msg = jsonDecode(socket.sent.first);
    expect(msg['type'], 'get_block_header_by_height');
    socket.sent.removeFirst();
    socket.messageHandler(
        '{"type":"block_header","body":{"block_id":"$previousBlockId","header":$blockJson2}}');

    await tester.pump(Duration(seconds: 1));
    expect(socket.sent.length, 0);
    expect(
        find.text(l10n
            .formatHashRate((block1.blockWork() ~/ BigInt.from(3600)).toInt())),
        findsOneWidget);

    /// Open search box
    expect(find.byType(IconButton), findsOneWidget);
    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();
    expect(find.byType(TextFormField), findsOneWidget);

    /// Search transaction
    await tester.enterText(find.byType(TextFormField), transactionId);
    expect(find.byType(IconButton), findsNWidgets(2));
    //await tester.tap(find.byType(IconButton).at(0);
    //await tester.tap(find.descendant(of: find.byType(TextFormField), matching: find.byType(IconButton)));
    await tester.testTextInput.receiveAction(TextInputAction.done);

    /// Respond to search
    await tester.pump(Duration(seconds: 1));
    expect(socket.sent.length, 2);
    msg = jsonDecode(socket.sent.first);
    expect(msg['type'], 'get_block_header');
    expect(msg['body']['block_id'], transactionId);
    socket.sent.removeFirst();
    socket.messageHandler(
        '{"type":"block_header","body":{"block_id":"$transactionId"}}');
    msg = jsonDecode(socket.sent.first);
    expect(msg['type'], 'get_transaction');
    expect(msg['body']['transaction_id'], transactionId);
    socket.sent.removeFirst();
    socket.messageHandler(
        '{"type":"transaction","body":{"block_id":"000000000000191da2e1392c323de6982a1f36fde6030776349bcad5b74770ca","height":26703,"transaction_id":"8d7356420c301d41462a2e1646f43b6841a86d4e8809439a2003e05bd2330a8f","transaction":{"time":1567693165,"nonce":$nonce,"from":"VWH6z8QrxrWMErzV0A9B7P2nltIdWXjmS0NrPJs/dZ8=","to":"+HMfJJD+RYQdnO0T4mptyTFLu+RTGMyGfS+X4rE18v8=","amount":23669655,"fee":1000000,"expires":26762,"series":27,"signature":"6NLGrXzGnhcZk2fIaTj84HDEgAfZlHolAddnKkQ4k5OvNKpt8UxjDzFeG9A7BX2iWZx5XMQkCv4M5CRZcSBjAg=="}}}');

    /// Respond to [TransactionWidget.load]
    await tester.pump(Duration(seconds: 1));
    expect(socket.sent.length, 1);
    msg = jsonDecode(socket.sent.first);
    expect(msg['type'], 'get_transaction');
    expect(msg['body']['transaction_id'], transactionId);
    socket.sent.removeFirst();
    socket.messageHandler(
        '{"type":"transaction","body":{"block_id":"000000000000191da2e1392c323de6982a1f36fde6030776349bcad5b74770ca","height":26703,"transaction_id":"8d7356420c301d41462a2e1646f43b6841a86d4e8809439a2003e05bd2330a8f","transaction":{"time":1567693165,"nonce":$nonce,"from":"VWH6z8QrxrWMErzV0A9B7P2nltIdWXjmS0NrPJs/dZ8=","to":"+HMfJJD+RYQdnO0T4mptyTFLu+RTGMyGfS+X4rE18v8=","amount":23669655,"fee":1000000,"expires":26762,"series":27,"signature":"6NLGrXzGnhcZk2fIaTj84HDEgAfZlHolAddnKkQ4k5OvNKpt8UxjDzFeG9A7BX2iWZx5XMQkCv4M5CRZcSBjAg=="}}}');

    await tester.pump(Duration(seconds: 1));
    expect(socket.sent.length, 0);
    expect(find.text(l10n.nonce), findsOneWidget);
    expect(find.text(nonce), findsOneWidget);
  });

  testWidgets('TransactionWidget', (WidgetTester tester) async {
    await tester.pumpWidget(ScopedModel(
        model: appState,
        child: ScopedModel(
            model: appState.wallet,
            child: MaterialApp(
                localizationsDelegates: localizationsDelegates,
                supportedLocales: supportedLocales,
                home: Container(),
                onGenerateRoute: CruzawlRoutes(appState,
                        includeWalletRoutes: true, blockChartSearchBar: true)
                    .onGenerateRoute,
                initialRoute: '/transaction/$transactionId'))));

    await tester.pump(Duration(seconds: 1));
    expect(socket.sent.length, 1);
    var msg = jsonDecode(socket.sent.first);
    expect(msg['type'], 'get_transaction');
    expect(msg['body']['transaction_id'], transactionId);
    socket.sent.removeFirst();
    socket.messageHandler(
        '{"type":"transaction","body":{"block_id":"000000000000191da2e1392c323de6982a1f36fde6030776349bcad5b74770ca","height":26703,"transaction_id":"8d7356420c301d41462a2e1646f43b6841a86d4e8809439a2003e05bd2330a8f","transaction":{"time":1567693165,"nonce":$nonce,"from":"VWH6z8QrxrWMErzV0A9B7P2nltIdWXjmS0NrPJs/dZ8=","to":"+HMfJJD+RYQdnO0T4mptyTFLu+RTGMyGfS+X4rE18v8=","amount":23669655,"fee":1000000,"expires":26762,"series":27,"signature":"6NLGrXzGnhcZk2fIaTj84HDEgAfZlHolAddnKkQ4k5OvNKpt8UxjDzFeG9A7BX2iWZx5XMQkCv4M5CRZcSBjAg=="}}}');

    await tester.pump(Duration(seconds: 1));
    expect(socket.sent.length, 0);
    expect(find.text(l10n.nonce), findsOneWidget);
    expect(find.text(nonce), findsOneWidget);
  });

  testWidgets('CruzawlNetworkSettings', (WidgetTester tester) async {
    await tester.pumpWidget(ScopedModel(
        model: appState,
        child: ScopedModel(
            model: appState.wallet,
            child: MaterialApp(
                localizationsDelegates: localizationsDelegates,
                supportedLocales: supportedLocales,
                home: Container(),
                onGenerateRoute: CruzawlRoutes(appState,
                        includeWalletRoutes: true, blockChartSearchBar: true)
                    .onGenerateRoute,
                initialRoute: '/network'))));

    // Open AddPeerWidget
    await tester.pump(Duration(seconds: 1));
    expect(find.byType(Row), findsOneWidget);
    List<Element> buttons = find
        .descendant(of: find.byType(Row), matching: find.byType(IconButton))
        .evaluate()
        .toList();
    expect(buttons.length, 2);
    await tester.tap(find.byWidget(buttons[1].widget));

    // Add a peer
    String peerName = 'peerNameFoo', peerUrl = '127.99.99.99';
    await tester.pumpAndSettle();
    expect(find.byType(TextFormField), findsNWidgets(2));
    await tester.enterText(find.byType(TextFormField).at(0), peerName);
    await tester.enterText(find.byType(TextFormField).at(1), peerUrl);
    await tester.tap(find.byType(RaisedGradientButton));

    // Check added peer
    await tester.pumpAndSettle();
    expect(find.text(peerName), findsOneWidget);
    List<PeerPreference> peers = preferences.peers;
    expect(peers.length, 2);
    expect(peers[1].name, peerName);
    expect(peers[1].url, peerUrl);

    // Open Remove Peer AlertDialog
    await tester.tap(find.text(peerName));
    await tester.tap(find.byWidget(buttons[0].widget));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.delete));

    // Remove the added peer
    await tester.pumpAndSettle();
    peers = preferences.peers;
    expect(peers.length, 1);
  });

  testWidgets('CruzawlSupport', (WidgetTester tester) async {
    await tester.pumpWidget(ScopedModel(
        model: appState,
        child: ScopedModel(
            model: appState.wallet,
            child: MaterialApp(
                localizationsDelegates: localizationsDelegates,
                supportedLocales: supportedLocales,
                home: Container(),
                onGenerateRoute: CruzawlRoutes(appState,
                        includeWalletRoutes: true, blockChartSearchBar: true)
                    .onGenerateRoute,
                initialRoute: '/support'))));

    await tester.pump(Duration(seconds: 1));
    expect(find.text('support@greenappers.com'), findsOneWidget);
    await tester.tap(find.text(l10n.license));
    await tester.pumpAndSettle();

    await tester.pump(Duration(seconds: 1));
    expect(find.byType(LicensePage), findsOneWidget);
  });

  testWidgets('CruzawlSettings', (WidgetTester tester) async {
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
    await tester.pump(Duration(seconds: 1));
    await tester.drag(find.text(l10n.theme), Offset(0.0, -300));
    expect(find.text(l10n.theme), findsOneWidget);

    /* Disable encryption
    parent = find.ancestor(
        of: find.text(l10n.encryption), matching: find.byType(ListTile));
    await tester
        .tap(find.descendant(of: parent, matching: find.byType(Switch)));
    expect(preferences.walletsEncrypted, false);
    */
    await tester.drag(find.text(l10n.encryption), Offset(0.0, -300));
    await tester.pumpAndSettle();

    // Disable insecureDeviceWarning
    expect(preferences.insecureDeviceWarning, true);
    Finder parent = find.ancestor(
        of: find.text(l10n.insecureDeviceWarning),
        matching: find.byType(ListTile));
    await tester
        .tap(find.descendant(of: parent, matching: find.byType(Switch)));
    await tester.pumpAndSettle();
    expect(preferences.insecureDeviceWarning, false);

    // Enable verifyAddressEveryLoad
    expect(preferences.verifyAddressEveryLoad, false);
    parent = find.ancestor(
        of: find.text(l10n.verifyKeyPairsEveryLoad),
        matching: find.byType(ListTile));
    await tester
        .tap(find.descendant(of: parent, matching: find.byType(Switch)));
    await tester.pumpAndSettle();
    expect(preferences.verifyAddressEveryLoad, true);

    // Enable unitTestBeforeCreatingWallets
    expect(preferences.unitTestBeforeCreating, false);
    parent = find.ancestor(
        of: find.text(l10n.unitTestBeforeCreatingWallets),
        matching: find.byType(ListTile));
    await tester
        .tap(find.descendant(of: parent, matching: find.byType(Switch)));
    await tester.pumpAndSettle();
    expect(preferences.unitTestBeforeCreating, true);

    // Enable walletNameInTitle
    expect(preferences.walletNameInTitle, false);
    parent = find.ancestor(
        of: find.text(l10n.showWalletNameInTitle),
        matching: find.byType(ListTile));
    await tester
        .tap(find.descendant(of: parent, matching: find.byType(Switch)));
    await tester.pumpAndSettle();
    expect(preferences.walletNameInTitle, true);

    // Disable debugLog
    expect(preferences.debugLog, true);
    parent = find.ancestor(
        of: find.text(l10n.debugLog), matching: find.byType(ListTile));
    await tester
        .tap(find.descendant(of: parent, matching: find.byType(Switch)));
    await tester.pumpAndSettle();
    expect(preferences.debugLog, false);
  });

  test('CruzPeerNetwork shutdown', () {
    appState.network.shutdown();
  });
}
