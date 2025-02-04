// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a cs locale. All the
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
  String get localeName => 'cs';

  static m0(address) => "Adresa ${address}";

  static m1(height) => "Váš zůstatek ve výšce bloku {@<a>} ${height} {@</a>} je:";

  static m2(height) => "Váš zůstatek zrající podle výšky ${height} je:";

  static m3(ticker, balance) => "${ticker} + ${balance}";

  static m4(algorithm) => "Vytváření ... ( ${algorithm} )";

  static m5(days) => "${Intl.plural(days, one: 'den', other: '${days} days')}";

  static m6(exaHashPerSecond) => "${exaHashPerSecond} EH / s";

  static m7(address) => "Od: ${address}";

  static m8(gigaHashPerSecond) => "${gigaHashPerSecond} GH / s";

  static m9(hashPerSecond) => "${hashPerSecond} H / s";

  static m10(height) => "height = {@<a>} ${height} {@</a>}";

  static m11(product) => "${product} Domovská stránka";

  static m12(hours) => "${Intl.plural(hours, one: 'hodina', other: '${hours} hodiny')}";

  static m13(id) => "Id: ${id}";

  static m14(kiloHashPerSecond) => "${kiloHashPerSecond} KH / s";

  static m15(item1, item2, item3, item4) => "${item1} , ${item2} , ${item3} , ${item4}";

  static m16(item1, item2, item3) => "${item1} , ${item2} , ${item3}";

  static m17(item1, item2) => "${item1} , ${item2}";

  static m18(cap) => "Market cap {@<a>} ${cap} {@</a>}";

  static m19(megaHashPerSecond) => "${megaHashPerSecond} MH / s";

  static m20(item) => "[ {@<a>} ${item} {@</a>} ]";

  static m21(item1, item2) => "[ {@<a1>} ${item1} {@</a1>} , {@<a2>} ${item2} {@</a2>} ]";

  static m22(amount) => "Minimální částka je ${amount}";

  static m23(fee) => "Minimální poplatek je ${fee}";

  static m24(minutes, seconds) => "${minutes} ${seconds}";

  static m25(minutes) => "${Intl.plural(minutes, one: '${minutes} minuta', other: '${minutes} minut')}";

  static m26(type) => "${type} Síť";

  static m27(number) => "Transakce ( ${number} )";

  static m28(petaHashPerSecond) => "${petaHashPerSecond} PH / s";

  static m29(seconds) => "${Intl.plural(seconds, one: '${seconds} sekunda', other: '${seconds} sekund')}";

  static m30(transactionId) => "Odesláno ${transactionId}";

  static m31(teraHashPerSecond) => "${teraHashPerSecond} TH / s";

  static m32(address) => "Komu: ${address}";

  static m33(totalBlocks, duration) => "${totalBlocks} {@<a1>} blokuje {@</a1>} za posledních {@<a2>} ${duration} {@</a2>}";

  static m34(totalBlocks, totalTransactions, duration) => "${totalBlocks} {@<a1>} blokuje {@</a1>} , ${totalTransactions} transakce za posledních {@<a2>} ${duration} {@</a2>}";

  static m35(addressText) => "ověření se nezdařilo: ${addressText}";

  static m36(goodAddresses, totalAddresses, goodTests, totalTests) => "Ověřené ${goodAddresses} / ${totalAddresses} adresy a ${goodTests} / ${totalTests} testy byly úspěšné";

  static m37(walletName, accountId, chainIndex) => "${walletName}: Účet ${accountId}, adresa ${chainIndex}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "account" : MessageLookupByLibrary.simpleMessage("Účet"),
    "accounts" : MessageLookupByLibrary.simpleMessage("Účty"),
    "activeTransactions" : MessageLookupByLibrary.simpleMessage("Aktivní transakce"),
    "addWallet" : MessageLookupByLibrary.simpleMessage("Přidat peněženku"),
    "address" : MessageLookupByLibrary.simpleMessage("Adresa"),
    "addressMustBeUnique" : MessageLookupByLibrary.simpleMessage("Adresa musí být jedinečná."),
    "addressStateOpen" : MessageLookupByLibrary.simpleMessage("otevřeno"),
    "addressStateReserve" : MessageLookupByLibrary.simpleMessage("rezervovat"),
    "addressStateUsed" : MessageLookupByLibrary.simpleMessage("použitý"),
    "addressTitle" : m0,
    "addresses" : MessageLookupByLibrary.simpleMessage("Adresy"),
    "amount" : MessageLookupByLibrary.simpleMessage("Množství"),
    "backupKeysWarning" : MessageLookupByLibrary.simpleMessage("Vaše klíče musí být zálohovány na externí úložiště."),
    "balance" : MessageLookupByLibrary.simpleMessage("Zůstatek"),
    "balanceAtHeightIs" : m1,
    "balanceMaturingByHeightIs" : m2,
    "balanceTitle" : m3,
    "block" : MessageLookupByLibrary.simpleMessage("Blok"),
    "blocks" : MessageLookupByLibrary.simpleMessage("Bloky"),
    "btcTicker" : MessageLookupByLibrary.simpleMessage("BTC"),
    "cancel" : MessageLookupByLibrary.simpleMessage("zrušení"),
    "cantDeleteOnlyWallet" : MessageLookupByLibrary.simpleMessage("Nelze smazat pouze peněženku."),
    "chainCode" : MessageLookupByLibrary.simpleMessage("Řetězový kód"),
    "chainIndex" : MessageLookupByLibrary.simpleMessage("Index řetězu"),
    "chainWork" : MessageLookupByLibrary.simpleMessage("Řetězová práce"),
    "confirmPassword" : MessageLookupByLibrary.simpleMessage("Potvrďte heslo"),
    "confirmations" : MessageLookupByLibrary.simpleMessage("Potvrzení"),
    "connected" : MessageLookupByLibrary.simpleMessage("Připojeno"),
    "console" : MessageLookupByLibrary.simpleMessage("Utěšit"),
    "contacts" : MessageLookupByLibrary.simpleMessage("Kontakty"),
    "copied" : MessageLookupByLibrary.simpleMessage("Zkopírováno."),
    "copy" : MessageLookupByLibrary.simpleMessage("kopírovat"),
    "copyAddresses" : MessageLookupByLibrary.simpleMessage("Kopírovat adresy"),
    "copyPublicKeys" : MessageLookupByLibrary.simpleMessage("Kopírování veřejných klíčů"),
    "create" : MessageLookupByLibrary.simpleMessage("Vytvořit"),
    "creating" : MessageLookupByLibrary.simpleMessage("Vytváření ..."),
    "creatingUsingAlgorithm" : m4,
    "cruzTicker" : MessageLookupByLibrary.simpleMessage("CRUZ"),
    "currency" : MessageLookupByLibrary.simpleMessage("Měna"),
    "currentBalanceIs" : MessageLookupByLibrary.simpleMessage("Váš aktuální zůstatek je:"),
    "dangerZone" : MessageLookupByLibrary.simpleMessage("Nebezpečná zóna"),
    "date" : MessageLookupByLibrary.simpleMessage("datum"),
    "daysDuration" : m5,
    "debugLog" : MessageLookupByLibrary.simpleMessage("Ladicí deník"),
    "defaultWalletName" : MessageLookupByLibrary.simpleMessage("Moje peněženka"),
    "delete" : MessageLookupByLibrary.simpleMessage("Odstranit"),
    "deletePeer" : MessageLookupByLibrary.simpleMessage("Odstranit Peer"),
    "deleteThisWallet" : MessageLookupByLibrary.simpleMessage("Odstranit tuto peněženku"),
    "deleteWallet" : MessageLookupByLibrary.simpleMessage("Smazat Peněženku"),
    "deleteWalletDescription" : MessageLookupByLibrary.simpleMessage("Jakmile odstraníte peněženku, už se nebudete moci vrátit. Buďte si jisti."),
    "deltaHashPower" : MessageLookupByLibrary.simpleMessage("Delta Hash Power"),
    "deltaTime" : MessageLookupByLibrary.simpleMessage("Delta čas"),
    "donations" : MessageLookupByLibrary.simpleMessage("Dary"),
    "duration" : MessageLookupByLibrary.simpleMessage("Doba trvání"),
    "earliestSeen" : MessageLookupByLibrary.simpleMessage("Nejstarší při pohledu"),
    "email" : MessageLookupByLibrary.simpleMessage("E-mailem"),
    "encrypt" : MessageLookupByLibrary.simpleMessage("Šifrovat"),
    "encryption" : MessageLookupByLibrary.simpleMessage("Šifrování"),
    "ethTicker" : MessageLookupByLibrary.simpleMessage("ETH"),
    "exaHashPerSecond" : m6,
    "expired" : MessageLookupByLibrary.simpleMessage("Platnost vypršela"),
    "expires" : MessageLookupByLibrary.simpleMessage("Platnost vyprší"),
    "externalAddress" : MessageLookupByLibrary.simpleMessage("Externí adresa"),
    "fee" : MessageLookupByLibrary.simpleMessage("Poplatek"),
    "from" : MessageLookupByLibrary.simpleMessage("Z"),
    "fromAddress" : m7,
    "generateNewAddress" : MessageLookupByLibrary.simpleMessage("Vygenerujte novou adresu"),
    "gigaHashPerSecond" : m8,
    "hashPerSecond" : m9,
    "hashRoot" : MessageLookupByLibrary.simpleMessage("Hash Root"),
    "hdWallet" : MessageLookupByLibrary.simpleMessage("HD peněženka"),
    "hdWalletAlgorithm" : MessageLookupByLibrary.simpleMessage("PBKDF: 2048 iterací"),
    "height" : MessageLookupByLibrary.simpleMessage("Výška"),
    "heightEquals" : m10,
    "hide" : MessageLookupByLibrary.simpleMessage("Skrýt"),
    "home" : MessageLookupByLibrary.simpleMessage("Domov"),
    "homePage" : m11,
    "hoursDuration" : m12,
    "id" : MessageLookupByLibrary.simpleMessage("Id"),
    "ignore" : MessageLookupByLibrary.simpleMessage("Ignorovat"),
    "insecureDeviceWarning" : MessageLookupByLibrary.simpleMessage("Upozornění na nezabezpečené zařízení"),
    "insecureDeviceWarningDescription" : MessageLookupByLibrary.simpleMessage("Bylo detekováno zakořeněné nebo jailbroken zařízení. Další použití se nedoporučuje."),
    "insufficientFunds" : MessageLookupByLibrary.simpleMessage("Nedostatečné finanční prostředky"),
    "invalidAddress" : MessageLookupByLibrary.simpleMessage("Neplatná adresa"),
    "invalidCurrency" : MessageLookupByLibrary.simpleMessage("Neplatná měna"),
    "invalidJson" : MessageLookupByLibrary.simpleMessage("Neplatný JSON."),
    "invalidMnemonic" : MessageLookupByLibrary.simpleMessage("Neplatná mnemotechnická pomůcka"),
    "invalidPrivateKey" : MessageLookupByLibrary.simpleMessage("Neplatný soukromý klíč."),
    "invalidPublicKey" : MessageLookupByLibrary.simpleMessage("Neplatný veřejný klíč."),
    "invalidUrl" : MessageLookupByLibrary.simpleMessage("Neplatná URL adresa."),
    "itemId" : m13,
    "kiloHashPerSecond" : m14,
    "language" : MessageLookupByLibrary.simpleMessage("Jazyk"),
    "latestSeen" : MessageLookupByLibrary.simpleMessage("Naposledy viděno"),
    "license" : MessageLookupByLibrary.simpleMessage("Licence"),
    "listOfFour" : m15,
    "listOfThree" : m16,
    "listOfTwo" : m17,
    "loading" : MessageLookupByLibrary.simpleMessage("Načítání..."),
    "localeLanguage" : MessageLookupByLibrary.simpleMessage("Čeština"),
    "marketCap" : m18,
    "matured" : MessageLookupByLibrary.simpleMessage("Vyzrálé"),
    "matures" : MessageLookupByLibrary.simpleMessage("Zraje"),
    "maturing" : MessageLookupByLibrary.simpleMessage("Zrání"),
    "maturingTransactions" : MessageLookupByLibrary.simpleMessage("Splatné transakce"),
    "maxMemoLength" : MessageLookupByLibrary.simpleMessage("Maximální délka poznámky je 100"),
    "megaHashPerSecond" : m19,
    "memo" : MessageLookupByLibrary.simpleMessage("Memorandum"),
    "menuOfOne" : m20,
    "menuOfTwo" : m21,
    "minAmount" : m22,
    "minFee" : m23,
    "minutesAndSecondsDuration" : m24,
    "minutesDuration" : m25,
    "name" : MessageLookupByLibrary.simpleMessage("název"),
    "nameMustBeUnique" : MessageLookupByLibrary.simpleMessage("Název musí být jedinečný."),
    "network" : MessageLookupByLibrary.simpleMessage("Síť"),
    "networkOffline" : MessageLookupByLibrary.simpleMessage("Síť offline"),
    "networkType" : m26,
    "newContact" : MessageLookupByLibrary.simpleMessage("Nový kontakt"),
    "newPeer" : MessageLookupByLibrary.simpleMessage("New Peer"),
    "newWallet" : MessageLookupByLibrary.simpleMessage("Nová peněženka"),
    "next" : MessageLookupByLibrary.simpleMessage("další"),
    "noPrivateKeys" : MessageLookupByLibrary.simpleMessage("Žádné soukromé klíče"),
    "noPublicKeys" : MessageLookupByLibrary.simpleMessage("Žádné veřejné klíče"),
    "nonce" : MessageLookupByLibrary.simpleMessage("Nonce"),
    "numTransactions" : m27,
    "ok" : MessageLookupByLibrary.simpleMessage("OK"),
    "password" : MessageLookupByLibrary.simpleMessage("Heslo"),
    "passwordCantBeEmpty" : MessageLookupByLibrary.simpleMessage("Heslo nemůže být prázdné."),
    "passwordsDontMatch" : MessageLookupByLibrary.simpleMessage("Hesla se neshodují."),
    "paste" : MessageLookupByLibrary.simpleMessage("Vložit"),
    "payTo" : MessageLookupByLibrary.simpleMessage("Zaplatit"),
    "peers" : MessageLookupByLibrary.simpleMessage("Vrstevníci"),
    "pending" : MessageLookupByLibrary.simpleMessage("čekající"),
    "petaHashPerSecond" : m28,
    "previous" : MessageLookupByLibrary.simpleMessage("Předchozí"),
    "privacyPolicy" : MessageLookupByLibrary.simpleMessage("Zásady ochrany osobních údajů"),
    "privateKey" : MessageLookupByLibrary.simpleMessage("Soukromý klíč"),
    "privateKeyList" : MessageLookupByLibrary.simpleMessage("Seznam soukromých klíčů"),
    "publicKeyList" : MessageLookupByLibrary.simpleMessage("Seznam veřejných klíčů"),
    "receive" : MessageLookupByLibrary.simpleMessage("Dostávat"),
    "recentHistory" : MessageLookupByLibrary.simpleMessage("Nedávná historie"),
    "requireSSLCert" : MessageLookupByLibrary.simpleMessage("Vyžadovat certifikát SSL"),
    "result" : MessageLookupByLibrary.simpleMessage("Výsledek"),
    "search" : MessageLookupByLibrary.simpleMessage("Vyhledávání"),
    "secondsDuration" : m29,
    "seedPhrase" : MessageLookupByLibrary.simpleMessage("Semenná fráze"),
    "seedPhraseWarning" : MessageLookupByLibrary.simpleMessage("Toto semeno umožňuje komukoli, kdo to ví, utratit všechny finanční prostředky z vaší peněženky. Napište to. Udržuj v bezpečí."),
    "send" : MessageLookupByLibrary.simpleMessage("Poslat"),
    "sendFailed" : MessageLookupByLibrary.simpleMessage("Odeslání se nezdařilo"),
    "sending" : MessageLookupByLibrary.simpleMessage("Odesílání ..."),
    "sentTransactionId" : m30,
    "settings" : MessageLookupByLibrary.simpleMessage("Nastavení"),
    "show" : MessageLookupByLibrary.simpleMessage("Show"),
    "showWalletNameInTitle" : MessageLookupByLibrary.simpleMessage("Zobrazit název peněženky v názvu"),
    "state" : MessageLookupByLibrary.simpleMessage("Stát"),
    "submit" : MessageLookupByLibrary.simpleMessage("Předložit"),
    "support" : MessageLookupByLibrary.simpleMessage("Podpěra, podpora"),
    "target" : MessageLookupByLibrary.simpleMessage("cílová"),
    "teraHashPerSecond" : m31,
    "thanksForDonating" : MessageLookupByLibrary.simpleMessage("Hned! Díky komunitě CRUZ!"),
    "theme" : MessageLookupByLibrary.simpleMessage("Téma"),
    "time" : MessageLookupByLibrary.simpleMessage("Čas"),
    "tip" : MessageLookupByLibrary.simpleMessage("Tip"),
    "title" : MessageLookupByLibrary.simpleMessage("Cruzall"),
    "to" : MessageLookupByLibrary.simpleMessage("Na"),
    "toAddress" : m32,
    "totalBlocksInLastDuration" : m33,
    "totalBlocksTransactionsInLastDuration" : m34,
    "transaction" : MessageLookupByLibrary.simpleMessage("Transakce"),
    "transactions" : MessageLookupByLibrary.simpleMessage("Transakce"),
    "typingAddressesWarning" : MessageLookupByLibrary.simpleMessage("Upozornění: Ruční psaní adres je nebezpečné a náchylné k chybám. Vždy používejte tlačítko kopírování nebo QR skener."),
    "unableToDecode" : MessageLookupByLibrary.simpleMessage("Nelze dekódovat"),
    "unitTestBeforeCreatingWallets" : MessageLookupByLibrary.simpleMessage("Test jednotky před vytvořením peněženky"),
    "unitTestFailure" : MessageLookupByLibrary.simpleMessage("Selhání testu jednotky"),
    "unknown" : MessageLookupByLibrary.simpleMessage("Neznámý"),
    "unknownAddress" : MessageLookupByLibrary.simpleMessage("Neznámá adresa"),
    "unknownQuery" : MessageLookupByLibrary.simpleMessage("Neznámý dotaz"),
    "unlock" : MessageLookupByLibrary.simpleMessage("Odemknout"),
    "unlockTitle" : MessageLookupByLibrary.simpleMessage("Odemkněte Cruzall"),
    "url" : MessageLookupByLibrary.simpleMessage("URL"),
    "valueMustBePositive" : MessageLookupByLibrary.simpleMessage("Hodnota musí být kladná"),
    "verify" : MessageLookupByLibrary.simpleMessage("Ověřte"),
    "verifyAddressFailed" : m35,
    "verifyKeyPairsEveryLoad" : MessageLookupByLibrary.simpleMessage("Ověřte dvojice klíčů při každém načtení"),
    "verifyWalletResults" : m36,
    "verifying" : MessageLookupByLibrary.simpleMessage("Ověření ..."),
    "version" : MessageLookupByLibrary.simpleMessage("Verze"),
    "walletAccountName" : m37,
    "wallets" : MessageLookupByLibrary.simpleMessage("Peněženky"),
    "warning" : MessageLookupByLibrary.simpleMessage("Varování"),
    "watchOnlyWallet" : MessageLookupByLibrary.simpleMessage("Peněženka pouze pro sledování"),
    "welcomeDesc" : MessageLookupByLibrary.simpleMessage("Nejprve vytvořte peněženku:"),
    "welcomeTitle" : MessageLookupByLibrary.simpleMessage("Vítejte v destinaci Cruzall")
  };
}
