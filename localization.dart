// Copyright 2019 cruzawl developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:flutter_web/material.dart'
    if (dart.library.io) 'package:flutter/material.dart';

import 'package:flutter_web/gestures.dart'
    if (dart.library.io) 'package:flutter/gestures.dart';

import 'package:intl/intl.dart';

import 'l10n/messages_all.dart';

class Localization {
  static Future<Localization> load(Locale locale) {
    final String name =
        locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return Localization();
    });
  }

  static Localization of(BuildContext context) {
    return Localizations.of<Localization>(context, Localization);
  }

  /// Title & balance
  String get title => Intl.message('Cruzall', name: 'title');
  String get unlockTitle => Intl.message('Unlock Cruzall', name: 'unlockTitle');
  String get welcomeTitle =>
      Intl.message('Welcome to Cruzall', name: 'welcomeTitle');
  String get welcomeDesc =>
      Intl.message('To begin, create a wallet:', name: 'welcomeDesc');
  String get currentBalanceIs =>
      Intl.message('Your current balance is:', name: 'currentBalanceIs');
  String get recentHistory =>
      Intl.message('Recent History', name: 'recentHistory');
  String balanceTitle(String ticker, String balance) =>
      Intl.message('$ticker +$balance',
          name: 'balanceTitle', args: [ticker, balance]);
  String balanceAtHeightIs(int height) =>
      Intl.message('Your balance at block height {@<a>}$height{@</a>} is:',
          name: 'balanceAtHeightIs', args: [height]);
  String balanceMaturingByHeightIs(int height) =>
      Intl.message('Your balance maturing by height $height is:',
          name: 'balanceMaturingByHeightIs', args: [height]);
  String get insecureDeviceWarning =>
      Intl.message('Insecure Device Warning', name: 'insecureDeviceWarning');
  String get insecureDeviceWarningDescription => Intl.message(
      'A rooted or jailbroken device has been detected.\n\nFurther use not recommended.',
      name: 'insecureDeviceWarningDescription');

  /// Wallet
  String creatingUsingAlgorithm(String algorithm) =>
      Intl.message('Creating... ($algorithm)',
          name: 'creatingUsingAlgorithm', args: [algorithm]);
  String get addWallet => Intl.message('Add Wallet', name: 'addWallet');
  String get hdWallet => Intl.message('HD Wallet', name: 'hdWallet');
  String get hdWalletAlgorithm =>
      Intl.message('PBKDF: 2048 iterations', name: 'hdWalletAlgorithm');
  String get watchOnlyWallet =>
      Intl.message('Watch-Only Wallet', name: 'watchOnlyWallet');
  String get generateNewAddress =>
      Intl.message('Generate new address', name: 'generateNewAddress');
  String get deleteWallet =>
      Intl.message('Delete Wallet', name: 'deleteWallet');
  String get deleteThisWallet =>
      Intl.message('Delete this wallet', name: 'deleteThisWallet');
  String get cantDeleteOnlyWallet =>
      Intl.message("Can't delete the only wallet.",
          name: 'cantDeleteOnlyWallet');
  String get deleteWalletDescription => Intl.message(
      'Once you delete a wallet, there is no going back. Please be certain.',
      name: 'deleteWalletDescription');

  /// Verbs & interactions
  String get ok => Intl.message('Ok', name: 'ok');
  String get hide => Intl.message('Hide', name: 'hide');
  String get show => Intl.message('Show', name: 'show');
  String get copy => Intl.message('Copy', name: 'copy');
  String get cancel => Intl.message('Cancel', name: 'cancel');
  String get delete => Intl.message('Delete', name: 'delete');
  String get create => Intl.message('Create', name: 'create');
  String get ignore => Intl.message('Ignore', name: 'ignore');
  String get unlock => Intl.message('Unlock', name: 'unlock');
  String get encrypt => Intl.message('Encrypt', name: 'encrypt');
  String get verify => Intl.message('Verify', name: 'verify');
  String get verifying => Intl.message('Verifying...', name: 'verifying');
  String get send => Intl.message('Send', name: 'send');
  String get sending => Intl.message('Sending...', name: 'sending');
  String get sendFailed => Intl.message('Send failed', name: 'sendFailed');
  String get loading => Intl.message('Loading...', name: 'loading');
  String get creating => Intl.message('Creating...', name: 'creating');
  String get copied => Intl.message('Copied.', name: 'copied');
  String get copyPublicKeys =>
      Intl.message('Copy Public Keys', name: 'copyPublicKeys');
  String sentTransactionId(String transactionId) =>
      Intl.message('Sent $transactionId',
          name: 'sentTransactionId', args: [transactionId]);

  /// Titles
  String get account => Intl.message('Account', name: 'account');
  String get accounts => Intl.message('Accounts', name: 'accounts');
  String get externalAddress =>
      Intl.message('External Address', name: 'externalAddress');
  String get address => Intl.message('Address', name: 'address');
  String get addresses => Intl.message('Addresses', name: 'addresses');
  String get receive => Intl.message('Receive', name: 'receive');
  String get unknown => Intl.message('Unknown', name: 'unknown');
  String get settings => Intl.message('Settings', name: 'settings');
  String get network => Intl.message('Network', name: 'network');
  String get newPeer => Intl.message('New Peer', name: 'newPeer');
  String get newWallet => Intl.message('New Wallet', name: 'newWallet');
  String get peers => Intl.message('Peers', name: 'peers');
  String get deletePeer => Intl.message('Delete Peer', name: 'deletePeer');
  String get block => Intl.message('Block', name: 'block');
  String get blocks => Intl.message('Blocks', name: 'blocks');
  String get encryption => Intl.message('Encryption', name: 'encryption');
  String get transaction => Intl.message('Transaction', name: 'transaction');
  String get transactions => Intl.message('Transactions', name: 'transactions');
  String get dangerZone => Intl.message('Danger Zone', name: 'dangerZone');
  String addressTitle(String address) =>
      Intl.message('Address $address', name: 'addressTitle', args: [address]);
  String networkType(String type) =>
      Intl.message('$type Network', name: 'networkType', args: [type]);
  String numTransactions(int number) => Intl.message('Transactions ($number)',
      name: 'numTransactions', args: [number]);
  String totalBlocksInLastDuration(int totalBlocks, String duration) =>
      Intl.message(
          '$totalBlocks {@<a1>}blocks{@</a1>} in last {@<a2>}$duration{@</a2>}',
          name: 'totalBlocksInLastDuration',
          args: [totalBlocks, duration]);

  /// Fields
  String get id => Intl.message('Id', name: 'id');
  String get tip => Intl.message('Tip', name: 'tip');
  String get date => Intl.message('Date', name: 'date');
  String get name => Intl.message('Name', name: 'name');
  String get time => Intl.message('Time', name: 'time');
  String get state => Intl.message('State', name: 'state');
  String get height => Intl.message('Height', name: 'height');
  String get balance => Intl.message('Balance', name: 'balance');
  String get currency => Intl.message('Currency', name: 'currency');
  String get nonce => Intl.message('Nonce', name: 'nonce');
  String get amount => Intl.message('Amount', name: 'amount');
  String get fee => Intl.message('Fee', name: 'fee');
  String get payTo => Intl.message('Pay to', name: 'payTo');
  String get to => Intl.message('To', name: 'to');
  String get from => Intl.message('From', name: 'from');
  String get memo => Intl.message('Memo', name: 'memo');
  String get theme => Intl.message('Theme', name: 'theme');
  String get url => Intl.message('URL', name: 'url');
  String get password => Intl.message('Password', name: 'password');
  String get version => Intl.message('Version', name: 'version');
  String get previous => Intl.message('Previous', name: 'previous');
  String get confirmations =>
      Intl.message('Confirmations', name: 'confirmations');
  String get earliestSeen =>
      Intl.message('Earliest Seen', name: 'earliestSeen');
  String get latestSeen => Intl.message('Latest seen', name: 'latestSeen');
  String get target => Intl.message('Target', name: 'target');
  String get chainCode => Intl.message('Chain Code', name: 'chainCode');
  String get chainIndex => Intl.message('Chain Index', name: 'chainIndex');
  String get seedPhrase => Intl.message('Seed phrase', name: 'seedPhrase');
  String get privateKey => Intl.message('Private Key', name: 'privateKey');
  String get activeTransactions =>
      Intl.message('Active transactions', name: 'activeTransactions');
  String get expired => Intl.message('Expired', name: 'expired');
  String get expires => Intl.message('Expires', name: 'expires');
  String get matured => Intl.message('Matured', name: 'matured');
  String get matures => Intl.message('Matures', name: 'matures');
  String get maturing => Intl.message('Maturing', name: 'maturing');
  String get maturingTransactions =>
      Intl.message('Maturing transactions', name: 'maturingTransactions');
  String get chainWork => Intl.message('Chain Work', name: 'chainWork');
  String get hashListRoot =>
      Intl.message('Hash List Root', name: 'hashListRoot');
  String get deltaTime => Intl.message('Delta Time', name: 'deltaTime');
  String get deltaHashPower =>
      Intl.message('Delta Hash Power', name: 'deltaHashPower');
  String get publicKeyList =>
      Intl.message('Public Key List', name: 'publicKeyList');
  String get privateKeyList =>
      Intl.message('Private Key List', name: 'privateKeyList');
  String fromAddress(String address) =>
      Intl.message('From:\u00A0$address', name: 'fromAddress', args: [address]);
  String toAddress(String address) =>
      Intl.message('To:\u00A0$address', name: 'toAddress', args: [address]);
  String heightEquals(int height) =>
      Intl.message('height={@<a>}$height{@</a>} ', name: 'heightEquals', args: [height]);

  /// Meta-Fields
  String get invalidUrl => Intl.message('Invalid URL.', name: 'invalidUrl');
  String get invalidCurrency =>
      Intl.message('Invalid currency', name: 'invalidCurrency');
  String get maxMemoLength =>
      Intl.message('Maximum memo length is 100', name: 'maxMemoLength');
  String get nameMustBeUnique =>
      Intl.message('Name must be unique.', name: 'nameMustBeUnique');
  String get passwordCantBeEmpty =>
      Intl.message("Password can't be empty.", name: 'passwordCantBeEmpty');
  String get passwordsDontMatch =>
      Intl.message("Passwords don't match.", name: 'passwordsDontMatch');
  String get confirmPassword =>
      Intl.message("Confirm Password", name: 'confirmPassword');
  String get unknownAddress =>
      Intl.message('Unknown address', name: 'unknownAddress');
  String get invalidAddress =>
      Intl.message('Invalid address', name: 'invalidAddress');
  String get invalidMnemonic =>
      Intl.message('Invalid mnemonic', name: 'invalidMnemonic');
  String get valueMustBePositive =>
      Intl.message('Value must be positive', name: 'valueMustBePositive');
  String get insufficientFunds =>
      Intl.message('Insufficient funds', name: 'insufficientFunds');
  String get networkOffline =>
      Intl.message('Network offline', name: 'networkOffline');
  String get noPublicKeys =>
      Intl.message('No public keys', name: 'noPublicKeys');
  String get noPrivateKeys =>
      Intl.message('No private keys', name: 'noPrivateKeys');
  String minFee(num fee) =>
      Intl.message('Minimum fee is $fee', name: 'minFee', args: [fee]);
  String minAmount(num amount) => Intl.message('Minimum amount is $amount',
      name: 'minAmount', args: [amount]);

  /// Settings & Verify
  String get defaultWalletName =>
      Intl.message('My wallet', name: 'defaultWalletName');
  String get debugLog => Intl.message('Debug Log', name: 'debugLog');
  String get requireSSLCert =>
      Intl.message('Require SSL certificate', name: 'requireSSLCert');
  String get showWalletNameInTitle =>
      Intl.message('Show wallet name in title', name: 'showWalletNameInTitle');
  String get verifyKeyPairsEveryLoad =>
      Intl.message('Verify key pairs every load',
          name: 'verifyKeyPairsEveryLoad');
  String get unitTestBeforeCreatingWallets =>
      Intl.message('Unit test before creating wallets',
          name: 'unitTestBeforeCreatingWallets');
  String get unitTestFailure =>
      Intl.message('Unit test failure', name: 'unitTestFailure');
  String verifyAddressFailed(String addressText) =>
      Intl.message('verify failed: $addressText',
          name: 'verifyAddressFailed', args: [addressText]);
  String verifyWalletResults(int goodAddresses, int totalAddresses,
          int goodTests, int totalTests) =>
      Intl.message(
          'Verified $goodAddresses/$totalAddresses addresses and $goodTests/$totalTests tests succeeded',
          name: 'verifyWalletResults',
          args: [goodAddresses, totalAddresses, goodTests, totalTests]);

  String formatHashRate(int hashesPerSec) {
    if (hashesPerSec > 1000000000)
      return '${(hashesPerSec / 1000000000).toStringAsFixed(1)} GH/s';
    if (hashesPerSec > 1000000)
      return '${(hashesPerSec ~/ 1000000).toStringAsFixed(1)} MH/s';
    else
      return '$hashesPerSec H/S';
  }

  String formatDuration(Duration duration) {
    if (duration.inDays >= 1)
      return duration.inDays == 1 ? 'day' : '${duration.inDays} days';
    if (duration.inHours >= 1)
      return duration.inHours == 1 ? 'hour' : '${duration.inHours} hours';
    if (duration.inMinutes >= 1)
      return duration.inMinutes == 1
          ? 'minute'
          : '${duration.inMinutes} minutes';
    if (duration.inSeconds >= 1)
      return duration.inSeconds == 1
          ? 'second'
          : '${duration.inSeconds} seconds';
    return duration.toString();
  }

  String formatShortDuration(Duration duration) {
    int seconds = duration.inSeconds - duration.inMinutes * 60;
    return duration.inMinutes > 0
        ? ('${duration.inMinutes} minutes' +
            (seconds != 0 ? ' $seconds seconds' : ''))
        : '${duration.inSeconds} seconds';
  }
}

class LocalizationDelegate extends LocalizationsDelegate<Localization> {
  const LocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<Localization> load(Locale locale) {
    return Localization.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<Localization> old) {
    return false;
  }
}

class LocalizationMarkup {
  Widget override;
  TextStyle style;
  VoidCallback onTap;
  LocalizationMarkup({this.override, this.style, this.onTap});
}

abstract class LocalizationMarkupVisitor {
  int state = 0;
  String lastOpenedTag;
  TextStyle currentStyle;
  LocalizationMarkup currentTag;
  void visit(String curText);
}

class TextSpanLocalizationMarkupVisitor extends LocalizationMarkupVisitor {
  TextSpan ret;

  void visit(String curText) {
    GestureRecognizer recognizer;
    if (currentTag != null && currentTag.onTap != null)
      recognizer = TapGestureRecognizer()..onTap = currentTag.onTap;

    TextSpan cur = TextSpan(
        text: curText,
        children: <TextSpan>[],
        style: currentStyle,
        recognizer: recognizer);

    if (ret == null)
      ret = cur;
    else
      ret.children.add(cur);
  }
}

class WidgetsLocalizationMarkupVisitor extends LocalizationMarkupVisitor {
  List<Widget> ret = <Widget>[];

  void visit(String curText) {
    Widget cur;
    if (currentTag != null && currentTag.override != null)
      cur = currentTag.override;
    else {
      Widget child = Text(curText, style: currentStyle);
      cur = (currentTag != null && currentTag.onTap != null)
          ? GestureDetector(onTap: currentTag.onTap, child: child)
          : child;
    }
    ret.add(cur);
  }
}

TextSpan buildLocalizationMarkupTextSpan(String text,
    {TextStyle style, Map<String, LocalizationMarkup> tags}) {
  if (tags == null || tags.length == 0)
    return TextSpan(style: style, text: text);
  TextSpanLocalizationMarkupVisitor visitor =
      TextSpanLocalizationMarkupVisitor();
  buildLocalizationMarkup(text, visitor, style: style, tags: tags);
  return visitor.ret;
}

List<Widget> buildLocalizationMarkupWidgets(String text,
    {TextStyle style, Map<String, LocalizationMarkup> tags}) {
  if (tags == null || tags.length == 0)
    return <Widget>[Text(text, style: style)];
  WidgetsLocalizationMarkupVisitor visitor = WidgetsLocalizationMarkupVisitor();
  buildLocalizationMarkup(text, visitor, style: style, tags: tags);
  return visitor.ret;
}

/// Parse unnested ARB guarded tags
void buildLocalizationMarkup(String text, LocalizationMarkupVisitor visitor,
    {TextStyle style, Map<String, LocalizationMarkup> tags}) {
  visitor.currentStyle = style;
  const String beginTag = '{@<', endTag = '>}';
  for (int i = 0, next; i < text.length; i = next) {
    bool insideTag = visitor.state % 2 == 1;
    bool insideTagged = visitor.state == 2;
    String search =
        insideTagged ? (beginTag + '/') : (insideTag ? endTag : beginTag);

    next = text.indexOf(search, i);
    if (next < i) next = text.length;
    String curText = text.substring(i, next);

    if (curText.length > 0) {
      if (insideTag) {
        bool insideCloseTag = visitor.state == 3;
        if (insideCloseTag) {
          if (curText != visitor.lastOpenedTag)
            throw FormatException(
                'Closed tag $curText mismatches ${visitor.lastOpenedTag}');
          visitor.currentStyle = style;
          visitor.currentTag = null;
        } else {
          visitor.lastOpenedTag = curText;
          LocalizationMarkup tag = tags[curText];
          if (tag != null) {
            visitor.currentStyle = tag.style;
            visitor.currentTag = tag;
          }
        }
      } else {
        visitor.visit(curText);
      }
    }
    if (next < text.length) next += search.length;
    visitor.state = (visitor.state + 1) % 4;
  }
}