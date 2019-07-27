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
  String get hide => Intl.message('Hide', name: 'hide');
  String get show => Intl.message('Show', name: 'show');
  String get date => Intl.message('Date', name: 'date');

  String get ok => Intl.message('Ok', name: 'ok');
  String get name => Intl.message('Name', name: 'name');
  String get time => Intl.message('Time', name: 'time');
  String get state => Intl.message('State', name: 'state');
  String get height => Intl.message('Height', name: 'height');
  String get account => Intl.message('Account', name: 'account');
  String get accounts => Intl.message('Accounts', name: 'accounts');
  String get address => Intl.message('Address', name: 'address');
  String get addresses => Intl.message('Addresses', name: 'addresses');
  String get balance => Intl.message('Balance', name: 'balance');
  String get create => Intl.message('Create', name: 'create');
  String get ignore => Intl.message('Ignore', name: 'ignore');
  String get verify => Intl.message('Verify', name: 'verify');
  String get verifying => Intl.message('Verifying...', name: 'verifying');
  String get unlock => Intl.message('Unlock', name: 'unlock');
  String get to => Intl.message('To', name: 'to');
  String get from => Intl.message('From', name: 'from');
  String get send => Intl.message('Send', name: 'send');
  String get sending => Intl.message('Sending...', name: 'sending');
  String get sendFailed => Intl.message('Send failed', name: 'sendFailed');
  String get receive => Intl.message('Receive', name: 'receive');
  String get settings => Intl.message('Settings', name: 'settings');
  String get network => Intl.message('Network', name: 'network');
  String get peers => Intl.message('Peers', name: 'peers');
  String get deletePeer => Intl.message('Delete Peer', name: 'deletePeer');
  String get password => Intl.message('Password', name: 'password');
  String get passwordCantBeEmpty => Intl.message("Password can't be empty.", name: 'passwordCantBeEmpty');
  String get confirmPassword => Intl.message("Confirm Password", name: 'confirmPassword');
  String get passwordsDontMatch => Intl.message("Passwords don't match.", name: 'passwordsDontMatch');
  String get generateNewAddress => Intl.message('Generate new address', name: 'generateNewAddress');
  String get unknownAddress => Intl.message('Unknown address', name: 'unknownAddress');
  String get invalidAddress => Intl.message('Invalid address', name: 'invalidAddress');
  String get hdWallet => Intl.message('HD Wallet', name: 'hdWallet');
  String get watchOnlyWallet => Intl.message('Watch-Only Wallet', name: 'watchOnlyWallet');
  String get payTo => Intl.message('Pay to', name: 'payTo');
  String get currency => Intl.message('Currency', name: 'currency');
  String get invalidCurrency => Intl.message('Invalid currency', name: 'invalidCurrency');
  String get fee => Intl.message('Fee', name: 'fee');
  String get memo => Intl.message('Memo', name: 'memo');
  String get amount => Intl.message('Amount', name: 'amount');
  String get maxMemoLength => Intl.message('Maximum memo length is 100', name: 'maxMemoLength');
  String get valueMustBePositive => Intl.message('Value must be positive', name: 'valueMustBePositive');
  String get insufficientFunds => Intl.message('Insufficient funds', name: 'insufficientFunds');
  String get networkOffline => Intl.message('Network offline', name: 'networkOffline');
  String get chainWork => Intl.message('Chain Work', name: 'chainWork');
  String get hashListRoot => Intl.message('Hash List Root', name: 'hashListRoot');
  String get deltaTime => Intl.message('Delta Time', name: 'deltaTime');
  String get deltaHashPower => Intl.message('Delta Hash Power', name: 'deltaHashPower');
  String get requireSSLCert => Intl.message('Require SSL certificate', name: 'requireSSLCert');

  String get id => Intl.message('Id', name: 'id');
  String get tip => Intl.message('Tip', name: 'tip');
  String get url => Intl.message('URL', name: 'url');
  String get invalidUrl => Intl.message('Invalid URL.', name: 'invalidUrl');
  String get nonce => Intl.message('Nonce', name: 'nonce');
  String get block => Intl.message('Block', name: 'block');
  String get blocks => Intl.message('Blocks', name: 'blocks');
  String get theme => Intl.message('Theme', name: 'theme');
  String get previous => Intl.message('Previous', name: 'previous');
  String get version => Intl.message('Version', name: 'version');
  String get unknown => Intl.message('Unknown', name: 'unknown');
  String get target => Intl.message('Target', name: 'target');
  String get encrypt => Intl.message('Encrypt', name: 'encrypt');
  String get encryption => Intl.message('Encryption', name: 'encryption');
  String get confirmations => Intl.message('Confirmations', name: 'confirmations');
  String get transaction => Intl.message('Transaction', name: 'transaction');
  String get transactions => Intl.message('Transactions', name: 'transactions');
  String get earliestSeen => Intl.message('Earliest Seen', name: 'earliestSeen');
  String get latestSeen => Intl.message('Latest seen', name: 'latestSeen');
  String get chainCode => Intl.message('Chain Code', name: 'chainCode');
  String get chainIndex => Intl.message('Chain Index', name: 'chainIndex');
  String get seedPhrase => Intl.message('Seed phrase', name: 'seedPhrase');
  String get privateKey => Intl.message('Private Key', name: 'privateKey');
  String get activeTransactions => Intl.message('Active transactions', name: 'activeTransactions');
  String get expired => Intl.message('Expired', name: 'expired');
  String get expires => Intl.message('Expires', name: 'expires');
  String get matured => Intl.message('Matured', name: 'matured');
  String get matures => Intl.message('Matures', name: 'matures');
  String get maturing => Intl.message('Maturing', name: 'maturing');
  String get maturingTransactions => Intl.message('Maturing transactions', name: 'maturingTransactions');
  String get dangerZone => Intl.message('Danger Zone', name: 'dangerZone');
  String get addWallet => Intl.message('Add Wallet', name: 'addWallet');
  String get copy => Intl.message('Copy', name: 'copy');
  String get cancel => Intl.message('Cancel', name: 'cancel');
  String get delete => Intl.message('Delete', name: 'delete');
  String get deleteWallet => Intl.message('Delete Wallet', name: 'deleteWallet');
  String get deleteThisWallet => Intl.message('Delete this wallet', name: 'deleteThisWallet');
  String get deleteWalletDescription => Intl.message('Once you delete a wallet, there is no going back. Please be certain.', name: 'deleteWalletDescription');
  String get cantDeleteOnlyWallet => Intl.message("Can't delete the only wallet.", name: 'cantDeleteOnlyWallet');
  String get copyPublicKeys => Intl.message('Copy Public Keys', name: 'copyPublicKeys');
  String get publicKeyList => Intl.message('Public Key List', name: 'publicKeyList');
  String get privateKeyList => Intl.message('Private Key List', name: 'privateKeyList');
  String get noPublicKeys => Intl.message('No public keys', name: 'noPublicKeys');
  String get noPrivateKeys => Intl.message('No private keys', name: 'noPrivateKeys');
  String get copied => Intl.message('Copied.', name: 'copied');
  String get unitTestFailure => Intl.message('Unit test failure', name: 'unitTestFailure');
  String get invalidMnemonic => Intl.message('Invalid mnemonic', name: 'invalidMnemonic');
  String get insecureDeviceWarning => Intl.message('Insecure Device Warning', name: 'insecureDeviceWarning');
  String get insecureDeviceWarningDescription => Intl.message('A rooted or jailbroken device has been detected.\n\nFurther use not recommended.', name: 'insecureDeviceWarningDescription');
  String get verifyKeyPairsEveryLoad => Intl.message('Verify key pairs every load', name: 'verifyKeyPairsEveryLoad');
  String get unitTestBeforeCreatingWallets => Intl.message('Unit test before creating wallets', name: 'unitTestBeforeCreatingWallets');
  String get showWalletNameInTitle => Intl.message('Show wallet name in title', name: 'showWalletNameInTitle');
  String get nameMustBeUnique => Intl.message('Name must be unique.', name: 'nameMustBeUnique');
  String get defaultWalletName => Intl.message('My wallet', name: 'defaultWalletName');
  String get debugLog => Intl.message('Debug Log', name: 'debugLog');
  String get loading => Intl.message('Loading...', name: 'loading');
  String get creating => Intl.message('Creating...', name: 'creating');
  String get hdWalletAlgorithm => Intl.message('PBKDF: 2048 iterations', name: 'hdWalletAlgorithm');

  String creatingUsingAlgorithm(String algorithm) =>
    Intl.message('Creating... ($algorithm)', name: 'creatingUsingAlgorithm', args: [algorithm]);
  String numTransactions(int number) =>
    Intl.message('Transactions ($number)', name: 'numTransactions', args: [number]);
  String addressTitle(String address) =>
    Intl.message('Address $address', name: 'addressTitle', args: [address]);

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
  String verifyAddressFailed(String addressText) =>
      Intl.message('verify failed: $addressText',
          name: 'verifyAddressFailed', args: [addressText]);
  
  String verifyWalletResults(int goodAddresses, int totalAddresses, int goodTests, int totalTests) =>
      Intl.message('Verified $goodAddresses/$totalAddresses addresses and $goodTests/$totalTests tests succeeded',
          name: 'verifyWalletResults', args: [goodAddresses, totalAddresses, goodTests, totalTests]);

  String minFee(num fee) =>
      Intl.message('Minimum fee is $fee', name: 'minFee', args: [fee]);
  String minAmount(num amount) =>
      Intl.message('Minimum amount is $amount', name: 'minAmount', args: [amount]);
  String sentTransactionId(String transactionId) =>
      Intl.message('Sent $transactionId', name: 'sentTransactionId', args: [transactionId]);
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
