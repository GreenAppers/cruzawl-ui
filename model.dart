// Copyright 2019 cruzawl developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart'
    if (dart.library.html) 'package:flutter_web/material.dart';

import 'package:sembast/sembast.dart' as sembast;
import 'package:scoped_model/scoped_model.dart';
import 'package:tweetnacl/tweetnacl.dart' as tweetnacl;

import 'package:cruzawl/currency.dart';
import 'package:cruzawl/network.dart';
import 'package:cruzawl/preferences.dart';
import 'package:cruzawl/test.dart';
import 'package:cruzawl/wallet.dart';

import 'ui.dart';

typedef SetClipboardText = void Function(BuildContext, String);

class PackageInfo {
  final String appName, packageName, version, buildNumber;
  PackageInfo(this.appName, this.packageName, this.version, this.buildNumber);
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
  SetClipboardText setClipboardText;
  sembast.DatabaseFactory databaseFactory;
  CruzawlPreferences preferences;
  FlutterErrorDetails fatal;
  PackageInfo packageInfo;
  bool isTrustFall;
  String debugLog;
  Directory dataDir;
  WalletModel wallet;
  Currency currency;
  List<WalletModel> wallets = <WalletModel>[];
  int walletsLoading = 0;
  static String walletSuffix = '.cruzall';

  Cruzawl(this.setClipboardText, this.databaseFactory, this.preferences,
      this.dataDir,
      {this.packageInfo, this.isTrustFall = false}) {
    if (preferences.debugLog) debugLog = '';
    setTheme();
  }

  void setState(VoidCallback stateChangeCb) {
    stateChangeCb();
    notifyListeners();
  }

  void setTheme() => theme = themes[preferences.theme] ?? themes['teal'];

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
        Wallet.fromFile(databaseFactory, getWalletFilename(k),
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
      if (wallet.wallet == x)
        currency = x.currency; // Replace [LoadingCurrency]
      walletsLoading--;
    }
    notifyListeners();
  }

  void setWallet(WalletModel x) {
    wallet = x;
    currency = wallet.wallet.currency;
  }

  String getWalletFilename(String walletName) =>
      dataDir.path + Platform.pathSeparator + walletName + walletSuffix;

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

  void removeWallet({bool store = true}) {
    assert(wallets.length > 1);
    String name = wallet.wallet.name;
    wallets.remove(wallet);
    setWallet(wallets[0]);
    if (store) {
      Map<String, String> loadedWallets = preferences.wallets;
      loadedWallets.remove(name);
      preferences.wallets = loadedWallets;
    }
    File(getWalletFilename(name)).deleteSync();
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
    currency.network.reset();
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
    currency.network.tipChanged = () => updateWallets(currency);
    currency.network.peerChanged = () => reloadWallets(currency);
    return currency.network.addPeerWithSpec(x, currency.genesisBlockId());
  }

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
    CruzTest(testCallback, testCallback, expectCallback).run();
    WalletTest(testCallback, testCallback, expectCallback).run();
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
}
