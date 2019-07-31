// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

// ignore: unnecessary_new
final messages = new MessageLookup();

// ignore: unused_element
final _keepAnalysisHappy = Intl.defaultLocale;

// ignore: non_constant_identifier_names
typedef MessageIfAbsent(String message_str, List args);

class MessageLookup extends MessageLookupByLibrary {
  get localeName => 'en';

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

  static m10(height) => "height={@<a>}${height}{@</a>} ";

  static m11(product) => "${product} Home Page";

  static m12(hours) => "${Intl.plural(hours, one: 'hour', other: '${hours} hours')}";

  static m13(kiloHashPerSecond) => "${kiloHashPerSecond} KH/s";

  static m14(item1, item2, item3) => "${item1}, ${item2}, ${item3}";

  static m15(item1, item2) => "${item1}, ${item2}";

  static m16(megaHashPerSecond) => "${megaHashPerSecond} MH/s";

  static m17(item) => "[{@<a>}${item}{@</a>}]";

  static m18(item1, item2) => "[{@<a1>}${item1}{@</a1>}, {@<a2>}${item2}{@</a2>}]";

  static m19(amount) => "Minimum amount is ${amount}";

  static m20(fee) => "Minimum fee is ${fee}";

  static m21(minutes, seconds) => "${minutes} ${seconds}";

  static m22(minutes) => "${Intl.plural(minutes, one: '${minutes} minute', other: '${minutes} minutes')}";

  static m23(type) => "${type} Network";

  static m24(number) => "Transactions (${number})";

  static m25(petaHashPerSecond) => "${petaHashPerSecond} PH/s";

  static m26(seconds) => "${Intl.plural(seconds, one: '${seconds} second', other: '${seconds} seconds')}";

  static m27(transactionId) => "Sent ${transactionId}";

  static m28(teraHashPerSecond) => "${teraHashPerSecond} TH/s";

  static m29(address) => "To: ${address}";

  static m30(totalBlocks, duration) => "${totalBlocks} {@<a1>}blocks{@</a1>} in last {@<a2>}${duration}{@</a2>}";

  static m31(addressText) => "verify failed: ${addressText}";

  static m32(goodAddresses, totalAddresses, goodTests, totalTests) => "Verified ${goodAddresses}/${totalAddresses} addresses and ${goodTests}/${totalTests} tests succeeded";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "account" : MessageLookupByLibrary.simpleMessage("Account"),
    "accounts" : MessageLookupByLibrary.simpleMessage("Accounts"),
    "activeTransactions" : MessageLookupByLibrary.simpleMessage("Active transactions"),
    "addWallet" : MessageLookupByLibrary.simpleMessage("Add Wallet"),
    "address" : MessageLookupByLibrary.simpleMessage("Address"),
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
    "cancel" : MessageLookupByLibrary.simpleMessage("Cancel"),
    "cantDeleteOnlyWallet" : MessageLookupByLibrary.simpleMessage("Can\'t delete the only wallet."),
    "chainCode" : MessageLookupByLibrary.simpleMessage("Chain Code"),
    "chainIndex" : MessageLookupByLibrary.simpleMessage("Chain Index"),
    "chainWork" : MessageLookupByLibrary.simpleMessage("Chain Work"),
    "confirmPassword" : MessageLookupByLibrary.simpleMessage("Confirm Password"),
    "confirmations" : MessageLookupByLibrary.simpleMessage("Confirmations"),
    "copied" : MessageLookupByLibrary.simpleMessage("Copied."),
    "copy" : MessageLookupByLibrary.simpleMessage("Copy"),
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
    "earliestSeen" : MessageLookupByLibrary.simpleMessage("Earliest Seen"),
    "email" : MessageLookupByLibrary.simpleMessage("Email"),
    "encrypt" : MessageLookupByLibrary.simpleMessage("Encrypt"),
    "encryption" : MessageLookupByLibrary.simpleMessage("Encryption"),
    "exaHashPerSecond" : m6,
    "expired" : MessageLookupByLibrary.simpleMessage("Expired"),
    "expires" : MessageLookupByLibrary.simpleMessage("Expires"),
    "externalAddress" : MessageLookupByLibrary.simpleMessage("External Address"),
    "fee" : MessageLookupByLibrary.simpleMessage("Fee"),
    "from" : MessageLookupByLibrary.simpleMessage("From"),
    "fromAddress" : m7,
    "generateNewAddress" : MessageLookupByLibrary.simpleMessage("Generate new address"),
    "gigaHashPerSecond" : m8,
    "hashListRoot" : MessageLookupByLibrary.simpleMessage("Hash List Root"),
    "hashPerSecond" : m9,
    "hdWallet" : MessageLookupByLibrary.simpleMessage("HD Wallet"),
    "hdWalletAlgorithm" : MessageLookupByLibrary.simpleMessage("PBKDF: 2048 iterations"),
    "height" : MessageLookupByLibrary.simpleMessage("Height"),
    "heightEquals" : m10,
    "hide" : MessageLookupByLibrary.simpleMessage("Hide"),
    "homePage" : m11,
    "hoursDuration" : m12,
    "id" : MessageLookupByLibrary.simpleMessage("Id"),
    "ignore" : MessageLookupByLibrary.simpleMessage("Ignore"),
    "insecureDeviceWarning" : MessageLookupByLibrary.simpleMessage("Insecure Device Warning"),
    "insecureDeviceWarningDescription" : MessageLookupByLibrary.simpleMessage("A rooted or jailbroken device has been detected.\n\nFurther use not recommended."),
    "insufficientFunds" : MessageLookupByLibrary.simpleMessage("Insufficient funds"),
    "invalidAddress" : MessageLookupByLibrary.simpleMessage("Invalid address"),
    "invalidCurrency" : MessageLookupByLibrary.simpleMessage("Invalid currency"),
    "invalidMnemonic" : MessageLookupByLibrary.simpleMessage("Invalid mnemonic"),
    "invalidUrl" : MessageLookupByLibrary.simpleMessage("Invalid URL."),
    "kiloHashPerSecond" : m13,
    "language" : MessageLookupByLibrary.simpleMessage("Language"),
    "latestSeen" : MessageLookupByLibrary.simpleMessage("Latest seen"),
    "license" : MessageLookupByLibrary.simpleMessage("License"),
    "listOfThree" : m14,
    "listOfTwo" : m15,
    "loading" : MessageLookupByLibrary.simpleMessage("Loading..."),
    "localeLanguage" : MessageLookupByLibrary.simpleMessage("English"),
    "matured" : MessageLookupByLibrary.simpleMessage("Matured"),
    "matures" : MessageLookupByLibrary.simpleMessage("Matures"),
    "maturing" : MessageLookupByLibrary.simpleMessage("Maturing"),
    "maturingTransactions" : MessageLookupByLibrary.simpleMessage("Maturing transactions"),
    "maxMemoLength" : MessageLookupByLibrary.simpleMessage("Maximum memo length is 100"),
    "megaHashPerSecond" : m16,
    "memo" : MessageLookupByLibrary.simpleMessage("Memo"),
    "menuOfOne" : m17,
    "menuOfTwo" : m18,
    "minAmount" : m19,
    "minFee" : m20,
    "minutesAndSecondsDuration" : m21,
    "minutesDuration" : m22,
    "name" : MessageLookupByLibrary.simpleMessage("Name"),
    "nameMustBeUnique" : MessageLookupByLibrary.simpleMessage("Name must be unique."),
    "network" : MessageLookupByLibrary.simpleMessage("Network"),
    "networkOffline" : MessageLookupByLibrary.simpleMessage("Network offline"),
    "networkType" : m23,
    "newPeer" : MessageLookupByLibrary.simpleMessage("New Peer"),
    "newWallet" : MessageLookupByLibrary.simpleMessage("New Wallet"),
    "noPrivateKeys" : MessageLookupByLibrary.simpleMessage("No private keys"),
    "noPublicKeys" : MessageLookupByLibrary.simpleMessage("No public keys"),
    "nonce" : MessageLookupByLibrary.simpleMessage("Nonce"),
    "numTransactions" : m24,
    "ok" : MessageLookupByLibrary.simpleMessage("Ok"),
    "password" : MessageLookupByLibrary.simpleMessage("Password"),
    "passwordCantBeEmpty" : MessageLookupByLibrary.simpleMessage("Password can\'t be empty."),
    "passwordsDontMatch" : MessageLookupByLibrary.simpleMessage("Passwords don\'t match."),
    "payTo" : MessageLookupByLibrary.simpleMessage("Pay to"),
    "peers" : MessageLookupByLibrary.simpleMessage("Peers"),
    "pending" : MessageLookupByLibrary.simpleMessage("Pending"),
    "petaHashPerSecond" : m25,
    "previous" : MessageLookupByLibrary.simpleMessage("Previous"),
    "privacyPolicy" : MessageLookupByLibrary.simpleMessage("Privacy Policy"),
    "privateKey" : MessageLookupByLibrary.simpleMessage("Private Key"),
    "privateKeyList" : MessageLookupByLibrary.simpleMessage("Private Key List"),
    "publicKeyList" : MessageLookupByLibrary.simpleMessage("Public Key List"),
    "receive" : MessageLookupByLibrary.simpleMessage("Receive"),
    "recentHistory" : MessageLookupByLibrary.simpleMessage("Recent History"),
    "requireSSLCert" : MessageLookupByLibrary.simpleMessage("Require SSL certificate"),
    "secondsDuration" : m26,
    "seedPhrase" : MessageLookupByLibrary.simpleMessage("Seed phrase"),
    "seedPhraseWarning" : MessageLookupByLibrary.simpleMessage("This seed allows anyone knowing it to spend all the funds from you wallet.  Write it down.  Keep it safe."),
    "send" : MessageLookupByLibrary.simpleMessage("Send"),
    "sendFailed" : MessageLookupByLibrary.simpleMessage("Send failed"),
    "sending" : MessageLookupByLibrary.simpleMessage("Sending..."),
    "sentTransactionId" : m27,
    "settings" : MessageLookupByLibrary.simpleMessage("Settings"),
    "show" : MessageLookupByLibrary.simpleMessage("Show"),
    "showWalletNameInTitle" : MessageLookupByLibrary.simpleMessage("Show wallet name in title"),
    "state" : MessageLookupByLibrary.simpleMessage("State"),
    "support" : MessageLookupByLibrary.simpleMessage("Support"),
    "target" : MessageLookupByLibrary.simpleMessage("Target"),
    "teraHashPerSecond" : m28,
    "theme" : MessageLookupByLibrary.simpleMessage("Theme"),
    "time" : MessageLookupByLibrary.simpleMessage("Time"),
    "tip" : MessageLookupByLibrary.simpleMessage("Tip"),
    "title" : MessageLookupByLibrary.simpleMessage("Cruzall"),
    "to" : MessageLookupByLibrary.simpleMessage("To"),
    "toAddress" : m29,
    "totalBlocksInLastDuration" : m30,
    "transaction" : MessageLookupByLibrary.simpleMessage("Transaction"),
    "transactions" : MessageLookupByLibrary.simpleMessage("Transactions"),
    "unitTestBeforeCreatingWallets" : MessageLookupByLibrary.simpleMessage("Unit test before creating wallets"),
    "unitTestFailure" : MessageLookupByLibrary.simpleMessage("Unit test failure"),
    "unknown" : MessageLookupByLibrary.simpleMessage("Unknown"),
    "unknownAddress" : MessageLookupByLibrary.simpleMessage("Unknown address"),
    "unlock" : MessageLookupByLibrary.simpleMessage("Unlock"),
    "unlockTitle" : MessageLookupByLibrary.simpleMessage("Unlock Cruzall"),
    "url" : MessageLookupByLibrary.simpleMessage("URL"),
    "valueMustBePositive" : MessageLookupByLibrary.simpleMessage("Value must be positive"),
    "verify" : MessageLookupByLibrary.simpleMessage("Verify"),
    "verifyAddressFailed" : m31,
    "verifyKeyPairsEveryLoad" : MessageLookupByLibrary.simpleMessage("Verify key pairs every load"),
    "verifyWalletResults" : m32,
    "verifying" : MessageLookupByLibrary.simpleMessage("Verifying..."),
    "version" : MessageLookupByLibrary.simpleMessage("Version"),
    "warning" : MessageLookupByLibrary.simpleMessage("Warning"),
    "watchOnlyWallet" : MessageLookupByLibrary.simpleMessage("Watch-Only Wallet"),
    "welcomeDesc" : MessageLookupByLibrary.simpleMessage("To begin, create a wallet:"),
    "welcomeTitle" : MessageLookupByLibrary.simpleMessage("Welcome to Cruzall")
  };
}
