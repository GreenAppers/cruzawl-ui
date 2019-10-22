// Copyright 2019 cruzawl developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:qr_flutter/qr_flutter.dart';
import 'package:sembast/sembast.dart' as sembast;
import 'package:scoped_model/scoped_model.dart';
import 'package:tweetnacl/tweetnacl.dart' as tweetnacl;

import 'package:cruzawl/currency.dart';
import 'package:cruzawl/exchange.dart';
import 'package:cruzawl/network.dart';
import 'package:cruzawl/network/http.dart';
import 'package:cruzawl/preferences.dart';
import 'package:cruzawl/test.dart';
import 'package:cruzawl/util.dart' hide VoidCallback;
import 'package:cruzawl/wallet.dart';

import 'package:cruzawl_ui/ui.dart';

typedef SetClipboardText = void Function(BuildContext, String);
typedef QrImageFunction = Widget Function(String);
typedef CruzawlCallback = void Function(Cruzawl);

/// Package details from pubspec.yaml.
class PackageInfo {
  final String appName, packageName, version, buildNumber;
  PackageInfo(this.appName, this.packageName, this.version, this.buildNumber);
}

/// [Transaction] metadata, e.g. is this transaction to/from our wallet?
class TransactionInfo {
  Color color;
  String amountPrefix = '';
  final bool toWallet, fromWallet, wideStyle;

  TransactionInfo(
      {this.toWallet = false,
      this.fromWallet = false,
      this.wideStyle = false}) {
    if (toWallet && !fromWallet) {
      color = Colors.green;
      amountPrefix = '+';
    } else if (fromWallet && !toWallet) {
      color = Colors.red;
      amountPrefix = '-';
    }
  }
}

/// Check if [Transaction] is to/from our [Wallet].
class WalletTransactionInfo extends TransactionInfo {
  WalletTransactionInfo(Wallet wallet, Transaction tx)
      : super(
            toWallet: wallet.isFromWallet(tx),
            fromWallet: wallet.isToWallet(tx));
}

/// [Model] wrapper for the pure-dart [Wallet.notifyListeners].
class WalletModel extends Model {
  final Wallet wallet;
  WalletModel(this.wallet) {
    if (wallet.notifyListeners != null) {
      throw FormatException('Wallet already bound');
    }
    wallet.notifyListeners = notifyListeners;
  }

  Currency get currency => wallet.currency;
  PeerNetwork get network => wallet.network;
}

/// Main [Model].
class Cruzawl extends Model {
  AppTheme theme;
  Locale localeOverride;
  StringFilter assetPath;
  SetClipboardText launchUrl, setClipboardText;
  StringFutureFunction getClipboardText, barcodeScan;
  QrImageFunction createIconImage;
  sembast.DatabaseFactory databaseFactory;
  CruzawlPreferences preferences;
  FlutterErrorDetails fatal;
  PackageInfo packageInfo;
  bool isTrustFall;
  String dataDir, userAgent, debugLog;
  int debugLevel = debugLevelInfo;
  HttpClient httpClient;
  FileSystem fileSystem;
  Currency currency;
  PeerNetwork network;
  List<PeerNetwork> networks;
  ExchangeRates exchangeRates;
  WalletModel wallet;
  List<WalletModel> wallets = <WalletModel>[];
  int walletsLoading = 0;
  static String walletSuffix = '.cruzall';

  Cruzawl(
    this.assetPath,
    this.launchUrl,
    this.setClipboardText,
    this.getClipboardText,
    this.databaseFactory,
    this.preferences,
    this.dataDir,
    this.fileSystem, {
    this.packageInfo,
    this.userAgent,
    this.barcodeScan,
    this.httpClient,
    this.createIconImage,
    this.isTrustFall = false,
  }) {
    if (preferences.debugLog) debugLog = '';
    createIconImage = createIconImage ?? createQrImage;
    exchangeRates = ExchangeRates(httpClient, preferences, debugPrint: print);
    exchangeRates.checkForUpdate();
    networks = currencies
        .map((currency) => currency.createNetwork(
            peerChanged: () => reloadWallets(currency),
            tipChanged: () => updateWallets(currency),
            httpClient: httpClient,
            userAgent: userAgent))
        .toList();
    setTheme();
  }

  /// Like [State.setState()] for this [Model].
  void setState(VoidCallback stateChangeCb) {
    stateChangeCb();
    notifyListeners();
  }

  /// Update for new local currency.
  void setLocalCurrency() => defaultUpdateBtcToCurrency(exchangeRates);

  /// Update for new theme.
  void setTheme() {
    theme = themes[preferences.getThemeName(currency)] ?? themes['blue'];
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

  /// Unlock all our wallets using [password].
  bool unlockWallets(String password) {
    try {
      preferences.walletsPassword = password;
      Map<String, String> loadedWallets = preferences.wallets;
      return loadedWallets != null;
    } on Exception {
      return false;
    }
  }

  /// Open our wallets from storage.
  Future<void> openWallets() async {
    Map<String, String> loadedWallets = preferences.wallets;
    loadedWallets.forEach((k, v) async => await addWallet(
        Wallet.fromFile(
            databaseFactory,
            networks,
            fileSystem,
            getWalletFilename(k),
            Seed(base64.decode(v)),
            preferences,
            print,
            openedWallet),
        store: false));
  }

  /// Called once [x] has been opened.
  void openedWallet(Wallet x) {
    if (x.fatal != null) {
      if (fatal == null) {
        fatal = FlutterErrorDetails(
            exception: x.fatal.exception, stack: x.fatal.stack);
        print(fatal.toString());
      }
    } else {
      /// Replaces [LoadingCurrency]
      if (wallet.wallet == x) setCurrency(x.currency);
      walletsLoading--;

      /// Main [PeerNetwork] connection initiation.
      if (x.network.length == 0 && preferences.networkEnabled) {
        connectPeers(x.currency);
      }
    }
    notifyListeners();
  }

  /// Set the active currency.
  void setCurrency(Currency x) {
    currency = x;
    network = findPeerNetworkForCurrency(networks, x);
    setTheme();
  }

  /// Set the active wallet.
  void setWallet(WalletModel x) {
    wallet = x;
    setCurrency(wallet.wallet.currency);
  }

  /// Returns the filename for [walletName].
  String getWalletFilename(String walletName) =>
      dataDir + walletName + walletSuffix;

  /// Add [x] to [wallets].
  Future<Wallet> addWallet(Wallet x, {bool store = true}) async {
    walletsLoading++;
    x.balanceChanged = notifyListeners;
    setWallet(WalletModel(x));
    wallets.add(wallet);
    if (store) {
      Map<String, String> loadedWallets = preferences.wallets;
      loadedWallets[x.name] = base64.encode(x.seed.data);
      await preferences.setWallets(loadedWallets);
    }
    return x;
  }

  /// Remove and delete the currenly active wallet.
  void removeWallet({bool store = true}) async {
    assert(wallets.length > 1);
    String name = wallet.wallet.name;
    wallets.remove(wallet);
    setWallet(wallets[0]);
    if (store) {
      Map<String, String> loadedWallets = preferences.wallets;
      loadedWallets.remove(name);
      await preferences.setWallets(loadedWallets);
    }
    await fileSystem.remove(getWalletFilename(name));
  }

  /// Changes the active wallet to [x].
  void changeActiveWallet(WalletModel x) => setState(() => setWallet(x));

  /// Called on new tip.
  void updateWallets(Currency currency) {
    if (wallets.isEmpty) {
      if (network != null) print('updated ${network.tipHeight}');
      notifyListeners();
    } else {
      for (WalletModel m in wallets) {
        if (m.wallet.currency == currency) m.wallet.updateTip();
      }
    }
  }

  /// Called on new peer connection.
  void reloadWallets(Currency currency) async {
    print('Cruzawl reloadWallets');
    if (wallets.isEmpty) {
      if (network != null && network.hasPeer) {
        await (await network.getPeer()).filterAdd(currency.nullAddress, (v) {});
      }
    } else {
      for (WalletModel m in wallets) {
        if (m.wallet.currency == currency) m.wallet.reload();
      }
    }
    notifyListeners();
  }

  /// Reconnect to the [PeerNetwork].
  void reconnectPeers(Currency currency) {
    network.shutdown();
    connectPeers(currency);
  }

  /// Calls [addPeer] on [peers] with [Peer.currency] matching [currency].
  void connectPeers(Currency currency) {
    List<Peer> peers = preferences.peers
        .where((v) => v.currency == currency.ticker)
        .map((v) => addPeer(v))
        .toList();
    if (peers.isNotEmpty && preferences.networkEnabled && peers[0] != null) {
      peers[0].connect();
    }
  }

  /// Creates the [Peer] described by [x] and adds to [PeerNetwork].
  Peer addPeer(PeerPreference x) {
    Currency currency = Currency.fromJson(x.currency);
    if (currency == null) {
      debugPrint('Unsupported currency: ${x.currency}');
      return null;
    }

    PeerNetwork network = findPeerNetworkForCurrency(networks, currency);
    if (network == null) {
      debugPrint('Unsupported network: ${x.currency}');
      return null;
    }

    x.debugPrint = print;
    x.debugLevel = debugLog != null ? debugLevelDebug : debugLevel;
    return network.addPeer(network.createPeerWithSpec(x));
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

  /// Runs a unit test suite on-device.
  int runUnitTests(Currency c) {
    int tests = 0;
    print('running unit tests');
    TestCallback testCallback = (n, f) {
      print('testing $n');
      tests++;
      f();
    };
    ExpectCallback expectCallback = (x, y) {
      if (!(x == y)) {
        setState(() => fatal = FlutterErrorDetails(
            exception: FormatException('unit test failure')));
      }
    };
    switch (c.ticker) {
      case 'BTC':
        BitcoinTester(testCallback, testCallback, expectCallback).run();
        BitcoinWalletTester(testCallback, testCallback, expectCallback).run();
        break;

      case 'CRUZ':
        CruzTester(testCallback, testCallback, expectCallback).run();
        CruzWalletTester(testCallback, testCallback, expectCallback).run();
        break;

      default:
        break;
    }
    if (fatal != null) return -1;
    print('unit tests succeeded');
    return tests;
  }

  /// Wraps [debugPrint()] and appends to [debugLog].
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
      Navigator.of(c).pushNamed('/address/${address.publicAddress.toJson()}');
  void navigateToAddressText(BuildContext c, String text) =>
      Navigator.of(c).pushNamed('/address/$text');
  void navigateToBlockChart(BuildContext c) =>
      navigateToAddressText(c, 'cruzbase');
  void navigateToBlockId(BuildContext c, String blockId) =>
      Navigator.of(c).pushNamed('/block/$blockId');
  void navigateToHeight(BuildContext c, int height) =>
      Navigator.of(c).pushNamed('/height/$height');
  void navigateToTransaction(BuildContext c, Transaction tx) =>
      Navigator.of(c).pushNamed('/transaction/' + tx.id().toJson());
  void launchMarketUrl(BuildContext c) =>
      launchUrl(c, 'https://qtrade.io/market/CRUZ_BTC');
}

QrImageFunction createQrImage = (String x) => QrImage(data: x);
