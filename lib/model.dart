// Copyright 2019 cruzawl developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_web/material.dart'
    if (dart.library.io) 'package:flutter/material.dart';

import 'package:sembast/sembast.dart' as sembast;
import 'package:scoped_model/scoped_model.dart';
import 'package:tweetnacl/tweetnacl.dart' as tweetnacl;

import 'package:cruzawl/currency.dart';
import 'package:cruzawl/exchange.dart';
import 'package:cruzawl/network.dart';
import 'package:cruzawl/preferences.dart';
import 'package:cruzawl/test.dart';
import 'package:cruzawl/util.dart' hide VoidCallback;
import 'package:cruzawl/wallet.dart';

import 'transaction.dart';
import 'ui.dart';

typedef StringFilter = String Function(String);
typedef StringFutureFunction = Future<String> Function();
typedef SetClipboardText = void Function(BuildContext, String);

class PackageInfo {
  final String appName, packageName, version, buildNumber;
  PackageInfo(this.appName, this.packageName, this.version, this.buildNumber);
}

class WalletTransactionInfo extends TransactionInfo {
  WalletTransactionInfo(Wallet wallet, Transaction tx)
      : super(
            toWallet: wallet.addresses.containsKey(tx.toText),
            fromWallet: wallet.addresses.containsKey(tx.fromText));
}

class WalletModel extends Model {
  final Wallet wallet;
  WalletModel(this.wallet) {
    if (wallet.notifyListeners != null)
      throw FormatException('Wallet already bound');
    wallet.notifyListeners = notifyListeners;
  }

  Currency get currency => wallet.currency;
}

class Cruzawl extends Model {
  AppTheme theme;
  Locale localeOverride;
  StringFilter assetPath;
  SetClipboardText launchUrl, setClipboardText;
  StringFutureFunction barcodeScan;
  sembast.DatabaseFactory databaseFactory;
  CruzawlPreferences preferences;
  FlutterErrorDetails fatal;
  PackageInfo packageInfo;
  bool isTrustFall;
  String dataDir, debugLog;
  FileSystem fileSystem;
  Currency currency;
  ExchangeRates exchangeRates;
  WalletModel wallet;
  List<WalletModel> wallets = <WalletModel>[];
  int walletsLoading = 0;
  static String walletSuffix = '.cruzall';

  Cruzawl(this.assetPath, this.launchUrl, this.setClipboardText,
      this.databaseFactory, this.preferences, this.dataDir, this.fileSystem,
      {this.packageInfo, this.barcodeScan, this.isTrustFall = false}) {
    if (preferences.debugLog) debugLog = '';
    exchangeRates = ExchangeRates(preferences, debugPrint: print);
    exchangeRates.checkForUpdate();
    setTheme();
  }

  void setState(VoidCallback stateChangeCb) {
    stateChangeCb();
    notifyListeners();
  }

  void setLocalCurrency() =>
    defaultUpdateBtcToCurrency(exchangeRates);

  void setTheme() {
    theme = themes[preferences.theme] ?? themes['teal'];
    theme.titleFont = 'MartelSans';
    theme.titleStyle = theme.data.primaryTextTheme.title.copyWith(
      fontFamily: theme.titleFont,
    );
    theme.labelStyle = TextStyle(
      fontFamily: theme.titleFont,
      color: Colors.grey,
    );
    theme.linkStyle = TextStyle(
      color: theme.linkColor,
      decoration: TextDecoration.underline,
    );
  }

  bool unlockWallets(String password) {
    try {
      preferences.walletsPassword = password;
      Map<String, String> loadedWallets = preferences.wallets;
      return loadedWallets != null;
    } on Exception {
      return false;
    }
  }

  void openWallets() {
    Map<String, String> loadedWallets = preferences.wallets;
    loadedWallets.forEach((k, v) => addWallet(
        Wallet.fromFile(databaseFactory, fileSystem, getWalletFilename(k),
            Seed(base64.decode(v)), preferences, print, openedWallet),
        store: false));
  }

  void openedWallet(Wallet x) {
    if (x.fatal != null) {
      if (fatal == null) {
        fatal = FlutterErrorDetails(
            exception: x.fatal.exception, stack: x.fatal.stack);
        print(fatal.toString());
      }
    } else {
      /// Replaces [LoadingCurrency]
      if (wallet.wallet == x) currency = x.currency;
      walletsLoading--;
    }
    notifyListeners();
  }

  void setWallet(WalletModel x) {
    wallet = x;
    currency = wallet.wallet.currency;
  }

  String getWalletFilename(String walletName) =>
      dataDir + walletName + walletSuffix;

  Wallet addWallet(Wallet x, {bool store = true}) {
    walletsLoading++;
    x.balanceChanged = notifyListeners;
    setWallet(WalletModel(x));
    wallets.add(wallet);
    if (store) {
      Map<String, String> loadedWallets = preferences.wallets;
      loadedWallets[x.name] = base64.encode(x.seed.data);
      preferences.wallets = loadedWallets;
    }
    return x;
  }

  void removeWallet({bool store = true}) async {
    assert(wallets.length > 1);
    String name = wallet.wallet.name;
    wallets.remove(wallet);
    setWallet(wallets[0]);
    if (store) {
      Map<String, String> loadedWallets = preferences.wallets;
      loadedWallets.remove(name);
      preferences.wallets = loadedWallets;
    }
    await fileSystem.remove(getWalletFilename(name));
  }

  void changeActiveWallet(WalletModel x) => setState(() => setWallet(x));

  void updateWallets(Currency currency) {
    if (wallets.isEmpty) {
      print('updated ${currency.network.tipHeight}');
      notifyListeners();
    } else
      for (WalletModel m in wallets) {
        if (m.wallet.currency == currency) m.wallet.updateTip();
      }
  }

  void reloadWallets(Currency currency) async {
    print('Cruzawl reloadWallets');
    if (wallets.isEmpty) {
      if (currency.network.hasPeer)
        (await currency.network.getPeer())
            .filterAdd(currency.nullAddress, (v) {});
    } else
      for (WalletModel m in wallets) {
        if (m.wallet.currency == currency) m.wallet.reload();
      }
    notifyListeners();
  }

  void reconnectPeers(Currency currency) {
    currency.network.shutdown();
    connectPeers(currency);
  }

  void connectPeers(Currency currency) {
    List<Peer> peers = preferences.peers
        .where((v) => v.currency == currency.ticker)
        .map((v) => addPeer(v))
        .toList();
    if (peers.length > 0 && preferences.networkEnabled) peers[0].connect();
  }

  Peer addPeer(PeerPreference x) {
    Currency currency = Currency.fromJson(x.currency);
    if (currency == null) return null;

    x.debugPrint = print;
    x.debugLevel = debugLevelInfo;
    currency.network.tipChanged = () => updateWallets(currency);
    currency.network.peerChanged = () => reloadWallets(currency);
    return currency.network.addPeer(currency.network
        .createPeerWithSpec(x, currency.genesisBlock().id().toJson()));
  }

  /// https://github.com/jspschool/tweetnacl-dart/issues/3
  bool runQuickTestVector() {
    Uint8List testVector =
        base64.decode('0JVc4TQg5shsqLNo6UDurejr4YUk8WUvYM+8lFAlAdI=');
    Uint8List publicKey =
        tweetnacl.Signature.keyPair_fromSeed(testVector).publicKey;
    if ((base64.encode(publicKey) !=
        'h6KFAcKAl9pi6cqfRJv5J0f3ffSh292+6MPO7Q92iF0=')) {
      fatal = FlutterErrorDetails(
          exception: FormatException('test vector failure'));
      return false;
    }
    return true;
  }

  int runUnitTests() {
    int tests = 0;
    print('running unit tests');
    TestCallback testCallback = (n, f) {
      print('testing $n');
      tests++;
      f();
    };
    ExpectCallback expectCallback = (x, y) {
      if (!(x == y))
        setState(() => fatal = FlutterErrorDetails(
            exception: FormatException('unit test failure')));
    };
    CruzTester(testCallback, testCallback, expectCallback).run();
    WalletTester(testCallback, testCallback, expectCallback).run();
    if (fatal != null) return -1;
    print('unit tests succeeded');
    return tests;
  }

  void print(String text) {
    if (debugLog != null) {
      debugLog += text;
      debugLog += '\n';
    }
    debugPrint(text);
  }

  void navigateToTip(BuildContext c) => Navigator.of(c).pushNamed('/tip');
  void navigateToWallet(BuildContext c) => Navigator.of(c).pushNamed('/wallet');
  void navigateToConsole(BuildContext c) =>
      Navigator.of(c).pushNamed('/console');
  void navigateToAddWallet(BuildContext c) =>
      Navigator.of(c).pushNamed('/addWallet');
  void navigateToSettings(BuildContext c) =>
      Navigator.of(c).pushNamed('/settings');
  void navigateToNetwork(BuildContext c) =>
      Navigator.of(c).pushNamed('/network');
  void navigateToAddress(BuildContext c, Address address) =>
      Navigator.of(c).pushNamed('/address/${address.publicKey.toJson()}');
  void navigateToAddressText(BuildContext c, String text) =>
      Navigator.of(c).pushNamed('/address/$text');
  void navigateToBlockId(BuildContext c, String blockId) =>
      Navigator.of(c).pushNamed('/block/$blockId');
  void navigateToHeight(BuildContext c, int height) =>
      Navigator.of(c).pushNamed('/height/$height');
  void navigateToTransaction(BuildContext c, Transaction tx) =>
      Navigator.of(c).pushNamed('/transaction/' + tx.id().toJson());
  void launchMarketUrl(BuildContext c) =>
      launchUrl(c, 'https://qtrade.io/market/CRUZ_BTC');
}

class PagePath {
  String page, arg;
  PagePath(this.page, this.arg);

  factory PagePath.parse(String path) {
    int start = 0 + (path.length > 0 && path[0] == '/' ? 1 : 0);
    int slash = path.indexOf('/', start);
    return (slash >= start && slash < path.length)
        ? PagePath(path.substring(start, slash), path.substring(slash + 1))
        : PagePath(path.substring(start), '');
  }
}
