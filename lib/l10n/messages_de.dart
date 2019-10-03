// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
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
  String get localeName => 'de';

  static m0(address) => "Adresse ${address}";

  static m1(height) => "Ihr Kontostand in Blockhöhe {@<a>} ${height} {@</a>} beträgt:";

  static m2(height) => "Ihre Waage Reifung von Höhe ${height} ist:";

  static m3(ticker, balance) => "${ticker} + ${balance}";

  static m4(algorithm) => "Erstellen ... ( ${algorithm} )";

  static m5(days) => "${Intl.plural(days, one: 'Tag', other: '${days} Tage')}";

  static m6(exaHashPerSecond) => "${exaHashPerSecond} EH / s";

  static m7(address) => "Von: ${address}";

  static m8(gigaHashPerSecond) => "${gigaHashPerSecond} GH / s";

  static m9(hashPerSecond) => "${hashPerSecond} H / s";

  static m10(height) => "height = {@<a>} ${height} {@</a>}";

  static m11(product) => "${product} Homepage";

  static m12(hours) => "${Intl.plural(hours, one: 'Stunde', other: '${hours} Stunden')}";

  static m13(id) => "Id: ${id}";

  static m14(kiloHashPerSecond) => "${kiloHashPerSecond} KH / s";

  static m15(item1, item2, item3, item4) => "${item1} , ${item2} , ${item3} , ${item4}";

  static m16(item1, item2, item3) => "${item1} , ${item2} , ${item3}";

  static m17(item1, item2) => "${item1} , ${item2}";

  static m18(cap) => "Marktkapitalisierung {@<a>} ${cap} {@</a>}";

  static m19(megaHashPerSecond) => "${megaHashPerSecond} MH / s";

  static m20(item) => "[ {@<a>} ${item} {@</a>} ]";

  static m21(item1, item2) => "[ {@<a1>} ${item1} {@</a1>} , {@<a2>} ${item2} {@</a2>} ]";

  static m22(amount) => "Mindestbetrag ist ${amount}";

  static m23(fee) => "Die Mindestgebühr beträgt ${fee}";

  static m24(minutes, seconds) => "${minutes} ${seconds}";

  static m25(minutes) => "${Intl.plural(minutes, one: '${minutes} Minute', other: '${minutes} Minuten')}";

  static m26(type) => "${type} Netzwerk";

  static m27(number) => "Transaktionen ( ${number} )";

  static m28(petaHashPerSecond) => "${petaHashPerSecond} PH / s";

  static m29(seconds) => "${Intl.plural(seconds, one: '${seconds} second', other: '${seconds} seconds')}";

  static m30(transactionId) => "Gesendet ${transactionId}";

  static m31(teraHashPerSecond) => "${teraHashPerSecond} TH / s";

  static m32(address) => "An: ${address}";

  static m33(totalBlocks, duration) => "${totalBlocks} {@<a1>} blockiert {@</a1>} im letzten {@<a2>} ${duration} {@</a2>}";

  static m34(totalBlocks, totalTransactions, duration) => "${totalBlocks} {@<a1>} blockiert {@</a1>} , ${totalTransactions} Transaktionen in den letzten {@<a2>} ${duration} {@</a2>}";

  static m35(addressText) => "Überprüfung fehlgeschlagen: ${addressText}";

  static m36(goodAddresses, totalAddresses, goodTests, totalTests) => "Überprüfte ${goodAddresses} / ${totalAddresses} und ${goodTests} / ${totalTests} -Tests waren erfolgreich";

  static m37(walletName, accountId, chainIndex) => "${walletName}: Konto ${accountId}, Adresse ${chainIndex}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "account" : MessageLookupByLibrary.simpleMessage("Konto"),
    "accounts" : MessageLookupByLibrary.simpleMessage("Konten"),
    "activeTransactions" : MessageLookupByLibrary.simpleMessage("Aktive Transaktionen"),
    "addWallet" : MessageLookupByLibrary.simpleMessage("Geldbörse hinzufügen"),
    "address" : MessageLookupByLibrary.simpleMessage("Adresse"),
    "addressMustBeUnique" : MessageLookupByLibrary.simpleMessage("Die Adresse muss eindeutig sein."),
    "addressStateOpen" : MessageLookupByLibrary.simpleMessage("öffnen"),
    "addressStateReserve" : MessageLookupByLibrary.simpleMessage("Reservieren"),
    "addressStateUsed" : MessageLookupByLibrary.simpleMessage("gebraucht"),
    "addressTitle" : m0,
    "addresses" : MessageLookupByLibrary.simpleMessage("Adressen"),
    "amount" : MessageLookupByLibrary.simpleMessage("Menge"),
    "backupKeysWarning" : MessageLookupByLibrary.simpleMessage("Ihre Schlüssel müssen auf einem externen Speicher gesichert werden."),
    "balance" : MessageLookupByLibrary.simpleMessage("Balance"),
    "balanceAtHeightIs" : m1,
    "balanceMaturingByHeightIs" : m2,
    "balanceTitle" : m3,
    "block" : MessageLookupByLibrary.simpleMessage("Block"),
    "blocks" : MessageLookupByLibrary.simpleMessage("Blöcke"),
    "btcTicker" : MessageLookupByLibrary.simpleMessage("BTC"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Stornieren"),
    "cantDeleteOnlyWallet" : MessageLookupByLibrary.simpleMessage("Die einzige Brieftasche kann nicht gelöscht werden."),
    "chainCode" : MessageLookupByLibrary.simpleMessage("Chain Code"),
    "chainIndex" : MessageLookupByLibrary.simpleMessage("Kettenindex"),
    "chainWork" : MessageLookupByLibrary.simpleMessage("Kettenarbeit"),
    "confirmPassword" : MessageLookupByLibrary.simpleMessage("Passwort bestätigen"),
    "confirmations" : MessageLookupByLibrary.simpleMessage("Bestätigungen"),
    "connected" : MessageLookupByLibrary.simpleMessage("In Verbindung gebracht"),
    "console" : MessageLookupByLibrary.simpleMessage("Konsole"),
    "contacts" : MessageLookupByLibrary.simpleMessage("Kontakte"),
    "copied" : MessageLookupByLibrary.simpleMessage("Kopiert."),
    "copy" : MessageLookupByLibrary.simpleMessage("Kopieren"),
    "copyAddresses" : MessageLookupByLibrary.simpleMessage("Adressen kopieren"),
    "copyPublicKeys" : MessageLookupByLibrary.simpleMessage("Öffentliche Schlüssel kopieren"),
    "create" : MessageLookupByLibrary.simpleMessage("Erstellen"),
    "creating" : MessageLookupByLibrary.simpleMessage("Erstellen..."),
    "creatingUsingAlgorithm" : m4,
    "cruzTicker" : MessageLookupByLibrary.simpleMessage("CRUZ"),
    "currency" : MessageLookupByLibrary.simpleMessage("Währung"),
    "currentBalanceIs" : MessageLookupByLibrary.simpleMessage("Ihr aktueller Kontostand beträgt:"),
    "dangerZone" : MessageLookupByLibrary.simpleMessage("Gefahrenzone"),
    "date" : MessageLookupByLibrary.simpleMessage("Datum"),
    "daysDuration" : m5,
    "debugLog" : MessageLookupByLibrary.simpleMessage("Austestungsprotokoll"),
    "defaultWalletName" : MessageLookupByLibrary.simpleMessage("Mein Geldbeutel"),
    "delete" : MessageLookupByLibrary.simpleMessage("Löschen"),
    "deletePeer" : MessageLookupByLibrary.simpleMessage("Peer löschen"),
    "deleteThisWallet" : MessageLookupByLibrary.simpleMessage("Löschen Sie diese Brieftasche"),
    "deleteWallet" : MessageLookupByLibrary.simpleMessage("Brieftasche löschen"),
    "deleteWalletDescription" : MessageLookupByLibrary.simpleMessage("Sobald Sie eine Brieftasche gelöscht haben, gibt es kein Zurück mehr. Bitte seien Sie sicher."),
    "deltaHashPower" : MessageLookupByLibrary.simpleMessage("Delta Hash Power"),
    "deltaTime" : MessageLookupByLibrary.simpleMessage("Delta Time"),
    "donations" : MessageLookupByLibrary.simpleMessage("Spenden"),
    "duration" : MessageLookupByLibrary.simpleMessage("Dauer"),
    "earliestSeen" : MessageLookupByLibrary.simpleMessage("Am frühesten gesehen"),
    "email" : MessageLookupByLibrary.simpleMessage("Email"),
    "encrypt" : MessageLookupByLibrary.simpleMessage("Verschlüsseln"),
    "encryption" : MessageLookupByLibrary.simpleMessage("Verschlüsselung"),
    "ethTicker" : MessageLookupByLibrary.simpleMessage("ETH"),
    "exaHashPerSecond" : m6,
    "expired" : MessageLookupByLibrary.simpleMessage("Abgelaufen"),
    "expires" : MessageLookupByLibrary.simpleMessage("Läuft ab"),
    "externalAddress" : MessageLookupByLibrary.simpleMessage("Externe Adresse"),
    "fee" : MessageLookupByLibrary.simpleMessage("Gebühr"),
    "from" : MessageLookupByLibrary.simpleMessage("Von"),
    "fromAddress" : m7,
    "generateNewAddress" : MessageLookupByLibrary.simpleMessage("Neue Adresse generieren"),
    "gigaHashPerSecond" : m8,
    "hashPerSecond" : m9,
    "hashRoot" : MessageLookupByLibrary.simpleMessage("Hash Root"),
    "hdWallet" : MessageLookupByLibrary.simpleMessage("HD Brieftasche"),
    "hdWalletAlgorithm" : MessageLookupByLibrary.simpleMessage("PBKDF: 2048 Iterationen"),
    "height" : MessageLookupByLibrary.simpleMessage("Höhe"),
    "heightEquals" : m10,
    "hide" : MessageLookupByLibrary.simpleMessage("verbergen"),
    "home" : MessageLookupByLibrary.simpleMessage("Zuhause"),
    "homePage" : m11,
    "hoursDuration" : m12,
    "id" : MessageLookupByLibrary.simpleMessage("Ich würde"),
    "ignore" : MessageLookupByLibrary.simpleMessage("Ignorieren"),
    "insecureDeviceWarning" : MessageLookupByLibrary.simpleMessage("Unsichere Gerätewarnung"),
    "insecureDeviceWarningDescription" : MessageLookupByLibrary.simpleMessage("Ein gerootetes Gerät oder ein Gerät mit Jailbreak wurde erkannt. Weitere Verwendung nicht empfohlen."),
    "insufficientFunds" : MessageLookupByLibrary.simpleMessage("Unzureichende Mittel"),
    "invalidAddress" : MessageLookupByLibrary.simpleMessage("Ungültige Adresse"),
    "invalidCurrency" : MessageLookupByLibrary.simpleMessage("Ungültige Währung"),
    "invalidJson" : MessageLookupByLibrary.simpleMessage("Ungültiger JSON."),
    "invalidMnemonic" : MessageLookupByLibrary.simpleMessage("Ungültige Mnemonik"),
    "invalidPrivateKey" : MessageLookupByLibrary.simpleMessage("Ungültiger privater Schlüssel."),
    "invalidPublicKey" : MessageLookupByLibrary.simpleMessage("Ungültiger öffentlicher Schlüssel."),
    "invalidUrl" : MessageLookupByLibrary.simpleMessage("Ungültige URL."),
    "itemId" : m13,
    "kiloHashPerSecond" : m14,
    "language" : MessageLookupByLibrary.simpleMessage("Sprache"),
    "latestSeen" : MessageLookupByLibrary.simpleMessage("Zuletzt gesehen"),
    "license" : MessageLookupByLibrary.simpleMessage("Lizenz"),
    "listOfFour" : m15,
    "listOfThree" : m16,
    "listOfTwo" : m17,
    "loading" : MessageLookupByLibrary.simpleMessage("Wird geladen..."),
    "localeLanguage" : MessageLookupByLibrary.simpleMessage("Deutsch"),
    "marketCap" : m18,
    "matured" : MessageLookupByLibrary.simpleMessage("Gereift"),
    "matures" : MessageLookupByLibrary.simpleMessage("Reift"),
    "maturing" : MessageLookupByLibrary.simpleMessage("Reifung"),
    "maturingTransactions" : MessageLookupByLibrary.simpleMessage("Fällige Transaktionen"),
    "maxMemoLength" : MessageLookupByLibrary.simpleMessage("Die maximale Memolänge beträgt 100"),
    "megaHashPerSecond" : m19,
    "memo" : MessageLookupByLibrary.simpleMessage("Memo"),
    "menuOfOne" : m20,
    "menuOfTwo" : m21,
    "minAmount" : m22,
    "minFee" : m23,
    "minutesAndSecondsDuration" : m24,
    "minutesDuration" : m25,
    "name" : MessageLookupByLibrary.simpleMessage("Name"),
    "nameMustBeUnique" : MessageLookupByLibrary.simpleMessage("Der Name muss eindeutig sein."),
    "network" : MessageLookupByLibrary.simpleMessage("Netzwerk"),
    "networkOffline" : MessageLookupByLibrary.simpleMessage("Netzwerk offline"),
    "networkType" : m26,
    "newContact" : MessageLookupByLibrary.simpleMessage("Neuer Kontakt"),
    "newPeer" : MessageLookupByLibrary.simpleMessage("Neuer Peer"),
    "newWallet" : MessageLookupByLibrary.simpleMessage("Neue Geldbörse"),
    "next" : MessageLookupByLibrary.simpleMessage("Nächster"),
    "noPrivateKeys" : MessageLookupByLibrary.simpleMessage("Keine privaten Schlüssel"),
    "noPublicKeys" : MessageLookupByLibrary.simpleMessage("Keine öffentlichen Schlüssel"),
    "nonce" : MessageLookupByLibrary.simpleMessage("Nonce"),
    "numTransactions" : m27,
    "ok" : MessageLookupByLibrary.simpleMessage("OK"),
    "password" : MessageLookupByLibrary.simpleMessage("Passwort"),
    "passwordCantBeEmpty" : MessageLookupByLibrary.simpleMessage("Das Passwort darf nicht leer sein."),
    "passwordsDontMatch" : MessageLookupByLibrary.simpleMessage("Passwörter stimmen nicht überein."),
    "paste" : MessageLookupByLibrary.simpleMessage("Einfügen"),
    "payTo" : MessageLookupByLibrary.simpleMessage("Zahlen an"),
    "peers" : MessageLookupByLibrary.simpleMessage("Gleichaltrigen"),
    "pending" : MessageLookupByLibrary.simpleMessage("steht aus"),
    "petaHashPerSecond" : m28,
    "previous" : MessageLookupByLibrary.simpleMessage("Bisherige"),
    "privacyPolicy" : MessageLookupByLibrary.simpleMessage("Datenschutz-Bestimmungen"),
    "privateKey" : MessageLookupByLibrary.simpleMessage("Privat Schlüssel"),
    "privateKeyList" : MessageLookupByLibrary.simpleMessage("Private Schlüsselliste"),
    "publicKeyList" : MessageLookupByLibrary.simpleMessage("Öffentliche Schlüsselliste"),
    "receive" : MessageLookupByLibrary.simpleMessage("Erhalten"),
    "recentHistory" : MessageLookupByLibrary.simpleMessage("Jüngste Geschichte"),
    "requireSSLCert" : MessageLookupByLibrary.simpleMessage("SSL-Zertifikat erforderlich"),
    "result" : MessageLookupByLibrary.simpleMessage("Ergebnis"),
    "search" : MessageLookupByLibrary.simpleMessage("Suche"),
    "secondsDuration" : m29,
    "seedPhrase" : MessageLookupByLibrary.simpleMessage("Samenphrase"),
    "seedPhraseWarning" : MessageLookupByLibrary.simpleMessage("Mit dieser Saat kann jeder, der sie kennt, das gesamte Geld Ihrer Brieftasche ausgeben. Schreib es auf. Sicher aufbewahren."),
    "send" : MessageLookupByLibrary.simpleMessage("Senden"),
    "sendFailed" : MessageLookupByLibrary.simpleMessage("Senden fehlgeschlagen"),
    "sending" : MessageLookupByLibrary.simpleMessage("Senden ..."),
    "sentTransactionId" : m30,
    "settings" : MessageLookupByLibrary.simpleMessage("die Einstellungen"),
    "show" : MessageLookupByLibrary.simpleMessage("Show"),
    "showWalletNameInTitle" : MessageLookupByLibrary.simpleMessage("Zeigen Sie den Brieftaschennamen im Titel an"),
    "state" : MessageLookupByLibrary.simpleMessage("Zustand"),
    "submit" : MessageLookupByLibrary.simpleMessage("einreichen"),
    "support" : MessageLookupByLibrary.simpleMessage("Unterstützung"),
    "target" : MessageLookupByLibrary.simpleMessage("Ziel"),
    "teraHashPerSecond" : m31,
    "thanksForDonating" : MessageLookupByLibrary.simpleMessage("Direkt am! Danke CRUZ Community!"),
    "theme" : MessageLookupByLibrary.simpleMessage("Thema"),
    "time" : MessageLookupByLibrary.simpleMessage("Zeit"),
    "tip" : MessageLookupByLibrary.simpleMessage("Spitze"),
    "title" : MessageLookupByLibrary.simpleMessage("Cruzall"),
    "to" : MessageLookupByLibrary.simpleMessage("Zu"),
    "toAddress" : m32,
    "totalBlocksInLastDuration" : m33,
    "totalBlocksTransactionsInLastDuration" : m34,
    "transaction" : MessageLookupByLibrary.simpleMessage("Transaktion"),
    "transactions" : MessageLookupByLibrary.simpleMessage("Transaktionen"),
    "typingAddressesWarning" : MessageLookupByLibrary.simpleMessage("Warnung: Das Eingeben von Adressen von Hand ist gefährlich und fehleranfällig. Verwenden Sie immer die Kopiertaste oder den QR-Scanner."),
    "unableToDecode" : MessageLookupByLibrary.simpleMessage("Kann nicht dekodieren"),
    "unitTestBeforeCreatingWallets" : MessageLookupByLibrary.simpleMessage("Unit-Test vor der Erstellung von Brieftaschen"),
    "unitTestFailure" : MessageLookupByLibrary.simpleMessage("Unit-Test fehlgeschlagen"),
    "unknown" : MessageLookupByLibrary.simpleMessage("unbekannte"),
    "unknownAddress" : MessageLookupByLibrary.simpleMessage("Unbekannte Adresse"),
    "unknownQuery" : MessageLookupByLibrary.simpleMessage("Unbekannte Abfrage"),
    "unlock" : MessageLookupByLibrary.simpleMessage("Freischalten"),
    "unlockTitle" : MessageLookupByLibrary.simpleMessage("Schalte Cruzall frei"),
    "url" : MessageLookupByLibrary.simpleMessage("URL"),
    "valueMustBePositive" : MessageLookupByLibrary.simpleMessage("Wert muss positiv sein"),
    "verify" : MessageLookupByLibrary.simpleMessage("Überprüfen"),
    "verifyAddressFailed" : m35,
    "verifyKeyPairsEveryLoad" : MessageLookupByLibrary.simpleMessage("Überprüfen Sie die Schlüsselpaare bei jedem Laden"),
    "verifyWalletResults" : m36,
    "verifying" : MessageLookupByLibrary.simpleMessage("Überprüfung läuft ..."),
    "version" : MessageLookupByLibrary.simpleMessage("Ausführung"),
    "walletAccountName" : m37,
    "wallets" : MessageLookupByLibrary.simpleMessage("Geldbörsen"),
    "warning" : MessageLookupByLibrary.simpleMessage("Warnung"),
    "watchOnlyWallet" : MessageLookupByLibrary.simpleMessage("Brieftasche nur für Armbanduhren"),
    "welcomeDesc" : MessageLookupByLibrary.simpleMessage("Erstellen Sie zunächst eine Brieftasche:"),
    "welcomeTitle" : MessageLookupByLibrary.simpleMessage("Willkommen in Cruzall")
  };
}
