// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(address) => "Address ${address}";

  static m1(height) => "Your balance at block height {@<a>}${height}{@</a>} is:";

  static m2(height) => "Your balance maturing by height ${height} is:";

  static m3(ticker, balance) => "${ticker} +${balance}";

  static m4(algorithm) => "Creating... (${algorithm})";

  static m5(days) => "${Intl.plural(days, one: 'day', other: '${days} days')}";

  static m6(exaHashPerSecond) => "${exaHashPerSecond} EH/s";

  static m7(address) => "From: ${address}";

  static m8(gigaHashPerSecond) => "${gigaHashPerSecond} GH/s";

  static m9(hashPerSecond) => "${hashPerSecond} H/s";

  static m10(height) => "height={@<a>}${height}{@</a>}";

  static m11(product) => "${product} Home Page";

  static m12(hours) => "${Intl.plural(hours, one: 'hour', other: '${hours} hours')}";

  static m13(id) => "Id: ${id}";

  static m14(kiloHashPerSecond) => "${kiloHashPerSecond} KH/s";

  static m15(item1, item2, item3, item4) => "${item1}, ${item2}, ${item3}, ${item4}";

  static m16(item1, item2, item3) => "${item1}, ${item2}, ${item3}";

  static m17(item1, item2) => "${item1}, ${item2}";

  static m18(cap) => "Market cap {@<a>}${cap}{@</a>}";

  static m19(megaHashPerSecond) => "${megaHashPerSecond} MH/s";

  static m20(item) => "[{@<a>}${item}{@</a>}]";

  static m21(item1, item2) => "[{@<a1>}${item1}{@</a1>}, {@<a2>}${item2}{@</a2>}]";

  static m22(amount) => "Minimum amount is ${amount}";

  static m23(fee) => "Minimum fee is ${fee}";

  static m24(minutes, seconds) => "${minutes} ${seconds}";

  static m25(minutes) => "${Intl.plural(minutes, one: '${minutes} minute', other: '${minutes} minutes')}";

  static m26(type) => "${type} Network";

  static m27(number) => "Transactions (${number})";

  static m28(petaHashPerSecond) => "${petaHashPerSecond} PH/s";

  static m29(seconds) => "${Intl.plural(seconds, one: '${seconds} second', other: '${seconds} seconds')}";

  static m30(transactionId) => "Sent ${transactionId}";

  static m31(teraHashPerSecond) => "${teraHashPerSecond} TH/s";

  static m32(address) => "To: ${address}";

  static m33(totalBlocks, duration) => "${totalBlocks} {@<a1>}blocks{@</a1>} in last {@<a2>}${duration}{@</a2>}";

  static m34(totalBlocks, totalTransactions, duration) => "${totalBlocks} {@<a1>}blocks{@</a1>}, ${totalTransactions} transactions in last {@<a2>}${duration}{@</a2>}";

  static m35(addressText) => "verify failed: ${addressText}";

  static m36(goodAddresses, totalAddresses, goodTests, totalTests) => "Verified ${goodAddresses}/${totalAddresses} addresses and ${goodTests}/${totalTests} tests succeeded";

  static m37(walletName, accountId, chainIndex) => "${walletName}: Account ${accountId}, Address ${chainIndex}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "account" : MessageLookupByLibrary.simpleMessage("Account"),
    "accounts" : MessageLookupByLibrary.simpleMessage("Accounts"),
    "activeTransactions" : MessageLookupByLibrary.simpleMessage("Active transactions"),
    "addWallet" : MessageLookupByLibrary.simpleMessage("Add Wallet"),
    "address" : MessageLookupByLibrary.simpleMessage("Address"),
    "addressMustBeUnique" : MessageLookupByLibrary.simpleMessage("Address must be unique."),
    "addressStateOpen" : MessageLookupByLibrary.simpleMessage("open"),
    "addressStateReserve" : MessageLookupByLibrary.simpleMessage("reserve"),
    "addressStateUsed" : MessageLookupByLibrary.simpleMessage("used"),
    "addressTitle" : m0,
    "addresses" : MessageLookupByLibrary.simpleMessage("Addresses"),
    "amount" : MessageLookupByLibrary.simpleMessage("Amount"),
    "backupKeysWarning" : MessageLookupByLibrary.simpleMessage("Your keys must be backed up on external storage."),
    "balance" : MessageLookupByLibrary.simpleMessage("Balance"),
    "balanceAtHeightIs" : m1,
    "balanceMaturingByHeightIs" : m2,
    "balanceTitle" : m3,
    "block" : MessageLookupByLibrary.simpleMessage("Block"),
    "blocks" : MessageLookupByLibrary.simpleMessage("Blocks"),
    "btcTicker" : MessageLookupByLibrary.simpleMessage("BTC"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Cancel"),
    "cantDeleteOnlyWallet" : MessageLookupByLibrary.simpleMessage("Can\'t delete the only wallet."),
    "chainCode" : MessageLookupByLibrary.simpleMessage("Chain Code"),
    "chainIndex" : MessageLookupByLibrary.simpleMessage("Chain Index"),
    "chainWork" : MessageLookupByLibrary.simpleMessage("Chain Work"),
    "confirmPassword" : MessageLookupByLibrary.simpleMessage("Confirm Password"),
    "confirmations" : MessageLookupByLibrary.simpleMessage("Confirmations"),
    "connected" : MessageLookupByLibrary.simpleMessage("Connected"),
    "console" : MessageLookupByLibrary.simpleMessage("Console"),
    "contacts" : MessageLookupByLibrary.simpleMessage("Contacts"),
    "copied" : MessageLookupByLibrary.simpleMessage("Copied."),
    "copy" : MessageLookupByLibrary.simpleMessage("Copy"),
    "copyAddresses" : MessageLookupByLibrary.simpleMessage("Copy Addresses"),
    "copyPublicKeys" : MessageLookupByLibrary.simpleMessage("Copy Public Keys"),
    "create" : MessageLookupByLibrary.simpleMessage("Create"),
    "creating" : MessageLookupByLibrary.simpleMessage("Creating..."),
    "creatingUsingAlgorithm" : m4,
    "cruzTicker" : MessageLookupByLibrary.simpleMessage("CRUZ"),
    "currency" : MessageLookupByLibrary.simpleMessage("Currency"),
    "currentBalanceIs" : MessageLookupByLibrary.simpleMessage("Your current balance is:"),
    "dangerZone" : MessageLookupByLibrary.simpleMessage("Danger Zone"),
    "date" : MessageLookupByLibrary.simpleMessage("Date"),
    "daysDuration" : m5,
    "debugLog" : MessageLookupByLibrary.simpleMessage("Debug Log"),
    "defaultWalletName" : MessageLookupByLibrary.simpleMessage("My wallet"),
    "delete" : MessageLookupByLibrary.simpleMessage("Delete"),
    "deletePeer" : MessageLookupByLibrary.simpleMessage("Delete Peer"),
    "deleteThisWallet" : MessageLookupByLibrary.simpleMessage("Delete this wallet"),
    "deleteWallet" : MessageLookupByLibrary.simpleMessage("Delete Wallet"),
    "deleteWalletDescription" : MessageLookupByLibrary.simpleMessage("Once you delete a wallet, there is no going back. Please be certain."),
    "deltaHashPower" : MessageLookupByLibrary.simpleMessage("Delta Hash Power"),
    "deltaTime" : MessageLookupByLibrary.simpleMessage("Delta Time"),
    "donations" : MessageLookupByLibrary.simpleMessage("Donations"),
    "duration" : MessageLookupByLibrary.simpleMessage("Duration"),
    "earliestSeen" : MessageLookupByLibrary.simpleMessage("Earliest Seen"),
    "email" : MessageLookupByLibrary.simpleMessage("Email"),
    "encrypt" : MessageLookupByLibrary.simpleMessage("Encrypt"),
    "encryption" : MessageLookupByLibrary.simpleMessage("Encryption"),
    "ethTicker" : MessageLookupByLibrary.simpleMessage("ETH"),
    "exaHashPerSecond" : m6,
    "expired" : MessageLookupByLibrary.simpleMessage("Expired"),
    "expires" : MessageLookupByLibrary.simpleMessage("Expires"),
    "externalAddress" : MessageLookupByLibrary.simpleMessage("External Address"),
    "fee" : MessageLookupByLibrary.simpleMessage("Fee"),
    "from" : MessageLookupByLibrary.simpleMessage("From"),
    "fromAddress" : m7,
    "generateNewAddress" : MessageLookupByLibrary.simpleMessage("Generate new address"),
    "gigaHashPerSecond" : m8,
    "hashPerSecond" : m9,
    "hashRoot" : MessageLookupByLibrary.simpleMessage("Hash Root"),
    "hdWallet" : MessageLookupByLibrary.simpleMessage("HD Wallet"),
    "hdWalletAlgorithm" : MessageLookupByLibrary.simpleMessage("PBKDF: 2048 iterations"),
    "height" : MessageLookupByLibrary.simpleMessage("Height"),
    "heightEquals" : m10,
    "hide" : MessageLookupByLibrary.simpleMessage("Hide"),
    "home" : MessageLookupByLibrary.simpleMessage("Home"),
    "homePage" : m11,
    "hoursDuration" : m12,
    "id" : MessageLookupByLibrary.simpleMessage("Id"),
    "ignore" : MessageLookupByLibrary.simpleMessage("Ignore"),
    "insecureDeviceWarning" : MessageLookupByLibrary.simpleMessage("Insecure Device Warning"),
    "insecureDeviceWarningDescription" : MessageLookupByLibrary.simpleMessage("A rooted or jailbroken device has been detected.\n\nFurther use not recommended."),
    "insufficientFunds" : MessageLookupByLibrary.simpleMessage("Insufficient funds"),
    "invalidAddress" : MessageLookupByLibrary.simpleMessage("Invalid address"),
    "invalidCurrency" : MessageLookupByLibrary.simpleMessage("Invalid currency"),
    "invalidJson" : MessageLookupByLibrary.simpleMessage("Invalid JSON."),
    "invalidMnemonic" : MessageLookupByLibrary.simpleMessage("Invalid mnemonic"),
    "invalidPrivateKey" : MessageLookupByLibrary.simpleMessage("Invalid private key."),
    "invalidPublicKey" : MessageLookupByLibrary.simpleMessage("Invalid public key."),
    "invalidUrl" : MessageLookupByLibrary.simpleMessage("Invalid URL."),
    "itemId" : m13,
    "kiloHashPerSecond" : m14,
    "language" : MessageLookupByLibrary.simpleMessage("Language"),
    "latestSeen" : MessageLookupByLibrary.simpleMessage("Latest seen"),
    "license" : MessageLookupByLibrary.simpleMessage("License"),
    "listOfFour" : m15,
    "listOfThree" : m16,
    "listOfTwo" : m17,
    "loading" : MessageLookupByLibrary.simpleMessage("Loading..."),
    "localeLanguage" : MessageLookupByLibrary.simpleMessage("English"),
    "marketCap" : m18,
    "matured" : MessageLookupByLibrary.simpleMessage("Matured"),
    "matures" : MessageLookupByLibrary.simpleMessage("Matures"),
    "maturing" : MessageLookupByLibrary.simpleMessage("Maturing"),
    "maturingTransactions" : MessageLookupByLibrary.simpleMessage("Maturing transactions"),
    "maxMemoLength" : MessageLookupByLibrary.simpleMessage("Maximum memo length is 100"),
    "megaHashPerSecond" : m19,
    "memo" : MessageLookupByLibrary.simpleMessage("Memo"),
    "menuOfOne" : m20,
    "menuOfTwo" : m21,
    "minAmount" : m22,
    "minFee" : m23,
    "minutesAndSecondsDuration" : m24,
    "minutesDuration" : m25,
    "name" : MessageLookupByLibrary.simpleMessage("Name"),
    "nameMustBeUnique" : MessageLookupByLibrary.simpleMessage("Name must be unique."),
    "network" : MessageLookupByLibrary.simpleMessage("Network"),
    "networkOffline" : MessageLookupByLibrary.simpleMessage("Network offline"),
    "networkType" : m26,
    "newContact" : MessageLookupByLibrary.simpleMessage("New Contact"),
    "newPeer" : MessageLookupByLibrary.simpleMessage("New Peer"),
    "newWallet" : MessageLookupByLibrary.simpleMessage("New Wallet"),
    "next" : MessageLookupByLibrary.simpleMessage("Next"),
    "noPrivateKeys" : MessageLookupByLibrary.simpleMessage("No private keys"),
    "noPublicKeys" : MessageLookupByLibrary.simpleMessage("No public keys"),
    "nonce" : MessageLookupByLibrary.simpleMessage("Nonce"),
    "numTransactions" : m27,
    "ok" : MessageLookupByLibrary.simpleMessage("Ok"),
    "password" : MessageLookupByLibrary.simpleMessage("Password"),
    "passwordCantBeEmpty" : MessageLookupByLibrary.simpleMessage("Password can\'t be empty."),
    "passwordsDontMatch" : MessageLookupByLibrary.simpleMessage("Passwords don\'t match."),
    "paste" : MessageLookupByLibrary.simpleMessage("Paste"),
    "payTo" : MessageLookupByLibrary.simpleMessage("Pay to"),
    "peers" : MessageLookupByLibrary.simpleMessage("Peers"),
    "pending" : MessageLookupByLibrary.simpleMessage("Pending"),
    "petaHashPerSecond" : m28,
    "previous" : MessageLookupByLibrary.simpleMessage("Previous"),
    "privacyPolicy" : MessageLookupByLibrary.simpleMessage("Privacy Policy"),
    "privateKey" : MessageLookupByLibrary.simpleMessage("Private Key"),
    "privateKeyList" : MessageLookupByLibrary.simpleMessage("Private Key List"),
    "publicKeyList" : MessageLookupByLibrary.simpleMessage("Public Key List"),
    "receive" : MessageLookupByLibrary.simpleMessage("Receive"),
    "recentHistory" : MessageLookupByLibrary.simpleMessage("Recent History"),
    "requireSSLCert" : MessageLookupByLibrary.simpleMessage("Require SSL certificate"),
    "result" : MessageLookupByLibrary.simpleMessage("Result"),
    "search" : MessageLookupByLibrary.simpleMessage("Search"),
    "secondsDuration" : m29,
    "seedPhrase" : MessageLookupByLibrary.simpleMessage("Seed phrase"),
    "seedPhraseWarning" : MessageLookupByLibrary.simpleMessage("This seed allows anyone knowing it to spend all the funds from you wallet.  Write it down.  Keep it safe."),
    "send" : MessageLookupByLibrary.simpleMessage("Send"),
    "sendFailed" : MessageLookupByLibrary.simpleMessage("Send failed"),
    "sending" : MessageLookupByLibrary.simpleMessage("Sending..."),
    "sentTransactionId" : m30,
    "settings" : MessageLookupByLibrary.simpleMessage("Settings"),
    "show" : MessageLookupByLibrary.simpleMessage("Show"),
    "showWalletNameInTitle" : MessageLookupByLibrary.simpleMessage("Show wallet name in title"),
    "state" : MessageLookupByLibrary.simpleMessage("State"),
    "submit" : MessageLookupByLibrary.simpleMessage("Submit"),
    "support" : MessageLookupByLibrary.simpleMessage("Support"),
    "target" : MessageLookupByLibrary.simpleMessage("Target"),
    "teraHashPerSecond" : m31,
    "thanksForDonating" : MessageLookupByLibrary.simpleMessage("Right on!  Thanks CRUZ community!"),
    "theme" : MessageLookupByLibrary.simpleMessage("Theme"),
    "time" : MessageLookupByLibrary.simpleMessage("Time"),
    "tip" : MessageLookupByLibrary.simpleMessage("Tip"),
    "title" : MessageLookupByLibrary.simpleMessage("Cruzall"),
    "to" : MessageLookupByLibrary.simpleMessage("To"),
    "toAddress" : m32,
    "totalBlocksInLastDuration" : m33,
    "totalBlocksTransactionsInLastDuration" : m34,
    "transaction" : MessageLookupByLibrary.simpleMessage("Transaction"),
    "transactions" : MessageLookupByLibrary.simpleMessage("Transactions"),
    "typingAddressesWarning" : MessageLookupByLibrary.simpleMessage("Warning: Typing addresses by hand is dangerous and error prone.  Always use the copy button or QR scanner."),
    "unableToDecode" : MessageLookupByLibrary.simpleMessage("Unable to decode"),
    "unitTestBeforeCreatingWallets" : MessageLookupByLibrary.simpleMessage("Unit test before creating wallets"),
    "unitTestFailure" : MessageLookupByLibrary.simpleMessage("Unit test failure"),
    "unknown" : MessageLookupByLibrary.simpleMessage("Unknown"),
    "unknownAddress" : MessageLookupByLibrary.simpleMessage("Unknown address"),
    "unknownQuery" : MessageLookupByLibrary.simpleMessage("Unknown query"),
    "unlock" : MessageLookupByLibrary.simpleMessage("Unlock"),
    "unlockTitle" : MessageLookupByLibrary.simpleMessage("Unlock Cruzall"),
    "url" : MessageLookupByLibrary.simpleMessage("URL"),
    "valueMustBePositive" : MessageLookupByLibrary.simpleMessage("Value must be positive"),
    "verify" : MessageLookupByLibrary.simpleMessage("Verify"),
    "verifyAddressFailed" : m35,
    "verifyKeyPairsEveryLoad" : MessageLookupByLibrary.simpleMessage("Verify key pairs every load"),
    "verifyWalletResults" : m36,
    "verifying" : MessageLookupByLibrary.simpleMessage("Verifying..."),
    "version" : MessageLookupByLibrary.simpleMessage("Version"),
    "walletAccountName" : m37,
    "wallets" : MessageLookupByLibrary.simpleMessage("Wallets"),
    "warning" : MessageLookupByLibrary.simpleMessage("Warning"),
    "watchOnlyWallet" : MessageLookupByLibrary.simpleMessage("Watch-Only Wallet"),
    "welcomeDesc" : MessageLookupByLibrary.simpleMessage("To begin, create a wallet:"),
    "welcomeTitle" : MessageLookupByLibrary.simpleMessage("Welcome to Cruzall")
  };
}
