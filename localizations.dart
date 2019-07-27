// Copyright 2019 cruzawl developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:flutter_web/material.dart'
    if (dart.library.io) 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'l10n/messages_all.dart';

class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// Parse ARB guarded tags
  static TextSpan parseTextSpan(String text,
      {TextStyle style, Map<String, TextSpan> tags}) {
    const String beginTag = '{@<', endTag = '>}';
    if (tags == null || tags.length == 0) {
      return TextSpan(style: style, text: text);
    } else if (tags.length == 1) {
      String tagKey = tags.keys.first;
      TextSpan tagVal = tags.values.first;
      String begin1 = '$beginTag$tagKey$endTag';
      String end1 = '$beginTag/$tagKey$endTag';
      bool inside = false;
      TextSpan ret;
      for (int i = 0, next; i < text.length; i = next) {
        next = text.indexOf(inside ? end1 : begin1, i);
        if (next < i) next = text.length;
        String curText = text.substring(i, next);
        TextSpan cur = TextSpan(
            text: curText,
            children: <TextSpan>[],
            style: inside ? tagVal.style : style,
            recognizer: inside ? tagVal.recognizer : null);
        if (ret == null)
          ret = cur;
        else
          ret.children.add(cur);
        if (next < text.length) next += inside ? end1.length : begin1.length;
        inside = !inside;
      }
      return ret;
    } else {
      // XXX not implemented;
      return TextSpan(style: style, text: text);
    }
  }

  String get title => Intl.message('Cruzall', name: 'title');
  String get unlockTitle => Intl.message('Unlock Cruzall', name: 'unlockTitle');

  String get ok => Intl.message('Ok', name: 'ok');
  String get name => Intl.message('Name', name: 'name');
  String get time => Intl.message('Time', name: 'time');
  String get height => Intl.message('Height', name: 'height');
  String get accounts => Intl.message('Accounts', name: 'accounts');
  String get addresses => Intl.message('Addresses', name: 'addresses');
  String get balance => Intl.message('Balance', name: 'balance');
  String get create => Intl.message('Create', name: 'create');
  String get verify => Intl.message('Verify', name: 'verify');
  String get verifying => Intl.message('Verifying...', name: 'verifying');
  String get seedPhrase => Intl.message('Seed phrase', name: 'seedPhrase');
  String get activeTransactions => Intl.message('Active transactions', name: 'activeTransactions');
  String get maturingTransactions => Intl.message('Maturing transactions', name: 'maturingTransactions');
  String get dangerZone => Intl.message('Danger Zone', name: 'dangerZone');
  String get deleteWallet => Intl.message('Delete Wallet', name: 'deleteWallet');
  String get deleteThisWallet => Intl.message('Delete this wallet', name: 'deleteThisWallet');
  String get deleteWalletDescription => Intl.message('Once you delete a wallet, there is no going back. Please be certain.', name: 'deleteWalletDescription');
  String get cantDeleteOnlyWallet => Intl.message("Can't delete the only wallet.", name: 'cantDeleteOnlyWallet');
  String get copyPublicKeys => Intl.message('Copy Public Keys', name: 'copyPublicKeys');
  String get copied => Intl.message('Copied.', name: 'copied');
  String get unitTestFailure => Intl.message('Unit test failure', name: 'unitTestFailure');

  String get recentHistory =>
      Intl.message('Recent History', name: 'recentHistory');
  String get currentBalanceIs =>
      Intl.message('Your current balance is:', name: 'currentBalance');

  String balanceAtHeightIs(int height) =>
      Intl.message('Your balance at block height {@<a>}$height{@</a>} is:',
          name: 'balanceAtHeight', args: [height]);
  String balanceMaturingByHeightIs(int height) =>
      Intl.message('Your balance maturing by height $height is:',
          name: 'balanceMaturingByHeight', args: [height]);
  String verifyWalletResults(int goodAddresses, int totalAddresses, int goodTests, int totalTests) =>
      Intl.message('Verified $goodAddresses/$totalAddresses addresses and $goodTests/$totalTests tests succeeded',
          name: 'verifyWalletResults', args: [goodAddresses, totalAddresses, goodTests, totalTests]);
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
