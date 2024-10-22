// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ms locale. All the
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
  String get localeName => 'ms';

  static m0(address) => "Alamat ${address}";

  static m1(height) => "Baki anda pada ketinggian blok {@<a>} ${height} {@</a>} ialah:";

  static m2(height) => "Baki anda yang matang dengan ketinggian ${height} ialah:";

  static m3(ticker, balance) => "${ticker} + ${balance}";

  static m4(algorithm) => "Mencipta ... ( ${algorithm} )";

  static m5(days) => "${Intl.plural(days, one: 'hari', other: '${days}')}";

  static m6(exaHashPerSecond) => "${exaHashPerSecond} EH / s";

  static m7(address) => "Dari: ${address}";

  static m8(gigaHashPerSecond) => "${gigaHashPerSecond} GH / s";

  static m9(hashPerSecond) => "${hashPerSecond} H / s";

  static m10(height) => "ketinggian = {@<a>} ${height} {@</a>}";

  static m11(product) => "${product} Halaman Utama";

  static m12(hours) => "${Intl.plural(hours, one: 'jam', other: '${hours}')}";

  static m13(id) => "Id: ${id}";

  static m14(kiloHashPerSecond) => "${kiloHashPerSecond} KH / s";

  static m15(item1, item2, item3, item4) => "${item1} , ${item2} , ${item3} , ${item4}";

  static m16(item1, item2, item3) => "${item1} , ${item2} , ${item3}";

  static m17(item1, item2) => "${item1} , ${item2}";

  static m18(cap) => "Cap pasaran {@<a>} ${cap} {@</a>}";

  static m19(megaHashPerSecond) => "${megaHashPerSecond} MH / s";

  static m20(item) => "[ {@<a>} ${item} {@</a>} ]";

  static m21(item1, item2) => "[ {@<a1>} ${item1} {@</a1>} , {@<a2>} ${item2} {@</a2>} ]";

  static m22(amount) => "Jumlah minimum adalah ${amount}";

  static m23(fee) => "Yuran minimum adalah ${fee}";

  static m24(minutes, seconds) => "${minutes} ${seconds}";

  static m25(minutes) => "${Intl.plural(minutes, one: '${minutes}', other: '${minutes} minit')}";

  static m26(type) => "${type} Rangkaian";

  static m27(number) => "Transaksi ( ${number} )";

  static m28(petaHashPerSecond) => "${petaHashPerSecond} PH / s";

  static m29(seconds) => "${Intl.plural(seconds, one: '${seconds} kedua', other: '${seconds} saat')}";

  static m30(transactionId) => "Dihantar ${transactionId}";

  static m31(teraHashPerSecond) => "${teraHashPerSecond} TH / s";

  static m32(address) => "Kepada: ${address}";

  static m33(totalBlocks, duration) => "${totalBlocks} {@<a1>} blok {@</a1>} dalam {@<a2>} ${duration} {@</a2>}";

  static m34(totalBlocks, totalTransactions, duration) => "${totalBlocks} {@<a1>} blok {@</a1>} , ${totalTransactions} urus niaga pada {@<a2>} ${duration} {@</a2>}";

  static m35(addressText) => "pengesahan gagal: ${addressText}";

  static m36(goodAddresses, totalAddresses, goodTests, totalTests) => "Alamat disahkan ${goodAddresses} / ${totalAddresses} dan ${goodTests} / ${totalTests} berjaya";

  static m37(walletName, accountId, chainIndex) => "${walletName}: Akaun ${accountId}, Alamat ${chainIndex}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "account" : MessageLookupByLibrary.simpleMessage("Akaun"),
    "accounts" : MessageLookupByLibrary.simpleMessage("Akaun"),
    "activeTransactions" : MessageLookupByLibrary.simpleMessage("Urus niaga aktif"),
    "addWallet" : MessageLookupByLibrary.simpleMessage("Tambah Wallet"),
    "address" : MessageLookupByLibrary.simpleMessage("Alamat"),
    "addressMustBeUnique" : MessageLookupByLibrary.simpleMessage("Alamat mestilah unik."),
    "addressStateOpen" : MessageLookupByLibrary.simpleMessage("buka"),
    "addressStateReserve" : MessageLookupByLibrary.simpleMessage("rizab"),
    "addressStateUsed" : MessageLookupByLibrary.simpleMessage("digunakan"),
    "addressTitle" : m0,
    "addresses" : MessageLookupByLibrary.simpleMessage("Alamat"),
    "amount" : MessageLookupByLibrary.simpleMessage("Jumlah"),
    "backupKeysWarning" : MessageLookupByLibrary.simpleMessage("Kekunci anda mesti disokong pada storan luaran."),
    "balance" : MessageLookupByLibrary.simpleMessage("Seimbang"),
    "balanceAtHeightIs" : m1,
    "balanceMaturingByHeightIs" : m2,
    "balanceTitle" : m3,
    "block" : MessageLookupByLibrary.simpleMessage("Blok"),
    "blocks" : MessageLookupByLibrary.simpleMessage("Blok"),
    "btcTicker" : MessageLookupByLibrary.simpleMessage("BTC"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Batalkan"),
    "cantDeleteOnlyWallet" : MessageLookupByLibrary.simpleMessage("Tidak dapat memadamkan dompet sahaja."),
    "chainCode" : MessageLookupByLibrary.simpleMessage("Kod Rantaian"),
    "chainIndex" : MessageLookupByLibrary.simpleMessage("Indeks Rantaian"),
    "chainWork" : MessageLookupByLibrary.simpleMessage("Rantaian Kerja"),
    "confirmPassword" : MessageLookupByLibrary.simpleMessage("Sahkan Kata Laluan"),
    "confirmations" : MessageLookupByLibrary.simpleMessage("Pengesahan"),
    "connected" : MessageLookupByLibrary.simpleMessage("Disambungkan"),
    "console" : MessageLookupByLibrary.simpleMessage("Konsol"),
    "contacts" : MessageLookupByLibrary.simpleMessage("Kenalan"),
    "copied" : MessageLookupByLibrary.simpleMessage("Disalin."),
    "copy" : MessageLookupByLibrary.simpleMessage("Salinan"),
    "copyAddresses" : MessageLookupByLibrary.simpleMessage("Salin Alamat"),
    "copyPublicKeys" : MessageLookupByLibrary.simpleMessage("Salin Kunci Awam"),
    "create" : MessageLookupByLibrary.simpleMessage("Buat"),
    "creating" : MessageLookupByLibrary.simpleMessage("Mencipta ..."),
    "creatingUsingAlgorithm" : m4,
    "cruzTicker" : MessageLookupByLibrary.simpleMessage("CRUZ"),
    "currency" : MessageLookupByLibrary.simpleMessage("Mata wang"),
    "currentBalanceIs" : MessageLookupByLibrary.simpleMessage("Baki semasa anda ialah:"),
    "dangerZone" : MessageLookupByLibrary.simpleMessage("Zon Bahaya"),
    "date" : MessageLookupByLibrary.simpleMessage("Tarikh"),
    "daysDuration" : m5,
    "debugLog" : MessageLookupByLibrary.simpleMessage("Log Debug"),
    "defaultWalletName" : MessageLookupByLibrary.simpleMessage("Dompet saya"),
    "delete" : MessageLookupByLibrary.simpleMessage("Padam"),
    "deletePeer" : MessageLookupByLibrary.simpleMessage("Padamkan Peer"),
    "deleteThisWallet" : MessageLookupByLibrary.simpleMessage("Padamkan dompet ini"),
    "deleteWallet" : MessageLookupByLibrary.simpleMessage("Padamkan Wallet"),
    "deleteWalletDescription" : MessageLookupByLibrary.simpleMessage("Sebaik sahaja anda memadamkan dompet, tidak akan kembali. Sila pastikan."),
    "deltaHashPower" : MessageLookupByLibrary.simpleMessage("Delta Hash Power"),
    "deltaTime" : MessageLookupByLibrary.simpleMessage("Masa Delta"),
    "donations" : MessageLookupByLibrary.simpleMessage("Sumbangan"),
    "duration" : MessageLookupByLibrary.simpleMessage("Tempoh"),
    "earliestSeen" : MessageLookupByLibrary.simpleMessage("Terkini Dilihat"),
    "email" : MessageLookupByLibrary.simpleMessage("E-mel"),
    "encrypt" : MessageLookupByLibrary.simpleMessage("Menyulitkan"),
    "encryption" : MessageLookupByLibrary.simpleMessage("Penyulitan"),
    "ethTicker" : MessageLookupByLibrary.simpleMessage("ETH"),
    "exaHashPerSecond" : m6,
    "expired" : MessageLookupByLibrary.simpleMessage("Tamat tempoh"),
    "expires" : MessageLookupByLibrary.simpleMessage("Tamat tempoh"),
    "externalAddress" : MessageLookupByLibrary.simpleMessage("Alamat Luaran"),
    "fee" : MessageLookupByLibrary.simpleMessage("Bayaran"),
    "from" : MessageLookupByLibrary.simpleMessage("Dari"),
    "fromAddress" : m7,
    "generateNewAddress" : MessageLookupByLibrary.simpleMessage("Buat alamat baru"),
    "gigaHashPerSecond" : m8,
    "hashPerSecond" : m9,
    "hashRoot" : MessageLookupByLibrary.simpleMessage("Hash Root"),
    "hdWallet" : MessageLookupByLibrary.simpleMessage("HD Wallet"),
    "hdWalletAlgorithm" : MessageLookupByLibrary.simpleMessage("PBKDF: 2048 lelaran"),
    "height" : MessageLookupByLibrary.simpleMessage("Ketinggian"),
    "heightEquals" : m10,
    "hide" : MessageLookupByLibrary.simpleMessage("Sembunyikan"),
    "home" : MessageLookupByLibrary.simpleMessage("Rumah"),
    "homePage" : m11,
    "hoursDuration" : m12,
    "id" : MessageLookupByLibrary.simpleMessage("ID"),
    "ignore" : MessageLookupByLibrary.simpleMessage("Abai"),
    "insecureDeviceWarning" : MessageLookupByLibrary.simpleMessage("Amaran Peranti Tidak Sesuai"),
    "insecureDeviceWarningDescription" : MessageLookupByLibrary.simpleMessage("Peranti berakar atau jailbroken telah dikesan. Penggunaan lanjut tidak disyorkan."),
    "insufficientFunds" : MessageLookupByLibrary.simpleMessage("Kekurangan dana"),
    "invalidAddress" : MessageLookupByLibrary.simpleMessage("Alamat tidak sah"),
    "invalidCurrency" : MessageLookupByLibrary.simpleMessage("Mata wang tidak sah"),
    "invalidJson" : MessageLookupByLibrary.simpleMessage("JSON tidak sah."),
    "invalidMnemonic" : MessageLookupByLibrary.simpleMessage("Mnemonik tidak sah"),
    "invalidPrivateKey" : MessageLookupByLibrary.simpleMessage("Kunci peribadi tidak sah."),
    "invalidPublicKey" : MessageLookupByLibrary.simpleMessage("Kunci awam tidak sah."),
    "invalidUrl" : MessageLookupByLibrary.simpleMessage("URL tidak sah."),
    "itemId" : m13,
    "kiloHashPerSecond" : m14,
    "language" : MessageLookupByLibrary.simpleMessage("Bahasa"),
    "latestSeen" : MessageLookupByLibrary.simpleMessage("Terkini dilihat"),
    "license" : MessageLookupByLibrary.simpleMessage("Lesen"),
    "listOfFour" : m15,
    "listOfThree" : m16,
    "listOfTwo" : m17,
    "loading" : MessageLookupByLibrary.simpleMessage("Memuatkan ..."),
    "localeLanguage" : MessageLookupByLibrary.simpleMessage("Bahasa Melayu"),
    "marketCap" : m18,
    "matured" : MessageLookupByLibrary.simpleMessage("Matang"),
    "matures" : MessageLookupByLibrary.simpleMessage("Matang"),
    "maturing" : MessageLookupByLibrary.simpleMessage("Matang"),
    "maturingTransactions" : MessageLookupByLibrary.simpleMessage("Urusniaga matang"),
    "maxMemoLength" : MessageLookupByLibrary.simpleMessage("Panjang memo maksimum ialah 100"),
    "megaHashPerSecond" : m19,
    "memo" : MessageLookupByLibrary.simpleMessage("Memo"),
    "menuOfOne" : m20,
    "menuOfTwo" : m21,
    "minAmount" : m22,
    "minFee" : m23,
    "minutesAndSecondsDuration" : m24,
    "minutesDuration" : m25,
    "name" : MessageLookupByLibrary.simpleMessage("Nama"),
    "nameMustBeUnique" : MessageLookupByLibrary.simpleMessage("Nama mestilah unik."),
    "network" : MessageLookupByLibrary.simpleMessage("Rangkaian"),
    "networkOffline" : MessageLookupByLibrary.simpleMessage("Rangkaian di luar talian"),
    "networkType" : m26,
    "newContact" : MessageLookupByLibrary.simpleMessage("Kenalan baru"),
    "newPeer" : MessageLookupByLibrary.simpleMessage("Peer Baru"),
    "newWallet" : MessageLookupByLibrary.simpleMessage("Wallet Baru"),
    "next" : MessageLookupByLibrary.simpleMessage("Seterusnya"),
    "noPrivateKeys" : MessageLookupByLibrary.simpleMessage("Tiada kunci persendirian"),
    "noPublicKeys" : MessageLookupByLibrary.simpleMessage("Tiada kunci awam"),
    "nonce" : MessageLookupByLibrary.simpleMessage("Nonce"),
    "numTransactions" : m27,
    "ok" : MessageLookupByLibrary.simpleMessage("Okey"),
    "password" : MessageLookupByLibrary.simpleMessage("Kata laluan"),
    "passwordCantBeEmpty" : MessageLookupByLibrary.simpleMessage("Kata laluan tidak boleh kosong."),
    "passwordsDontMatch" : MessageLookupByLibrary.simpleMessage("Kata laluan tidak sepadan."),
    "paste" : MessageLookupByLibrary.simpleMessage("Tampal"),
    "payTo" : MessageLookupByLibrary.simpleMessage("Bayar kepada"),
    "peers" : MessageLookupByLibrary.simpleMessage("Rakan sebaya"),
    "pending" : MessageLookupByLibrary.simpleMessage("Yang belum selesai"),
    "petaHashPerSecond" : m28,
    "previous" : MessageLookupByLibrary.simpleMessage("Sebelum ini"),
    "privacyPolicy" : MessageLookupByLibrary.simpleMessage("Dasar Privasi"),
    "privateKey" : MessageLookupByLibrary.simpleMessage("Kunci Persendirian"),
    "privateKeyList" : MessageLookupByLibrary.simpleMessage("Senarai Kunci Persendirian"),
    "publicKeyList" : MessageLookupByLibrary.simpleMessage("Senarai Utama Awam"),
    "receive" : MessageLookupByLibrary.simpleMessage("Terima"),
    "recentHistory" : MessageLookupByLibrary.simpleMessage("Sejarah Terkini"),
    "requireSSLCert" : MessageLookupByLibrary.simpleMessage("Memerlukan sijil SSL"),
    "result" : MessageLookupByLibrary.simpleMessage("Keputusan"),
    "search" : MessageLookupByLibrary.simpleMessage("Carian"),
    "secondsDuration" : m29,
    "seedPhrase" : MessageLookupByLibrary.simpleMessage("Frasa benih"),
    "seedPhraseWarning" : MessageLookupByLibrary.simpleMessage("Benih ini membolehkan sesiapa yang mengetahui bahawa ia membelanjakan semua dana dari dompet anda. Tuliskannya. Pastikan ia selamat."),
    "send" : MessageLookupByLibrary.simpleMessage("Hantar"),
    "sendFailed" : MessageLookupByLibrary.simpleMessage("Hantar gagal"),
    "sending" : MessageLookupByLibrary.simpleMessage("Menghantar ..."),
    "sentTransactionId" : m30,
    "settings" : MessageLookupByLibrary.simpleMessage("Tetapan"),
    "show" : MessageLookupByLibrary.simpleMessage("Tunjukkan"),
    "showWalletNameInTitle" : MessageLookupByLibrary.simpleMessage("Paparkan nama dompet dalam tajuk"),
    "state" : MessageLookupByLibrary.simpleMessage("Negeri"),
    "submit" : MessageLookupByLibrary.simpleMessage("Hantar"),
    "support" : MessageLookupByLibrary.simpleMessage("Sokongan"),
    "target" : MessageLookupByLibrary.simpleMessage("Sasaran"),
    "teraHashPerSecond" : m31,
    "thanksForDonating" : MessageLookupByLibrary.simpleMessage("Betul! Terima kasih komuniti CRUZ!"),
    "theme" : MessageLookupByLibrary.simpleMessage("Tema"),
    "time" : MessageLookupByLibrary.simpleMessage("Masa"),
    "tip" : MessageLookupByLibrary.simpleMessage("Petua"),
    "title" : MessageLookupByLibrary.simpleMessage("Cruzall"),
    "to" : MessageLookupByLibrary.simpleMessage("Untuk"),
    "toAddress" : m32,
    "totalBlocksInLastDuration" : m33,
    "totalBlocksTransactionsInLastDuration" : m34,
    "transaction" : MessageLookupByLibrary.simpleMessage("Transaksi"),
    "transactions" : MessageLookupByLibrary.simpleMessage("Urus niaga"),
    "typingAddressesWarning" : MessageLookupByLibrary.simpleMessage("Amaran: Mengetik alamat dengan tangan adalah berbahaya dan rawan ralat. Sentiasa gunakan butang salin atau pengimbas QR."),
    "unableToDecode" : MessageLookupByLibrary.simpleMessage("Tidak dapat menyahkod"),
    "unitTestBeforeCreatingWallets" : MessageLookupByLibrary.simpleMessage("Ujian unit sebelum membuat dompet"),
    "unitTestFailure" : MessageLookupByLibrary.simpleMessage("Kegagalan ujian unit"),
    "unknown" : MessageLookupByLibrary.simpleMessage("Tidak diketahui"),
    "unknownAddress" : MessageLookupByLibrary.simpleMessage("Alamat tidak diketahui"),
    "unknownQuery" : MessageLookupByLibrary.simpleMessage("Pertanyaan tidak diketahui"),
    "unlock" : MessageLookupByLibrary.simpleMessage("Buka kunci"),
    "unlockTitle" : MessageLookupByLibrary.simpleMessage("Buka kunci Cruzall"),
    "url" : MessageLookupByLibrary.simpleMessage("URL"),
    "valueMustBePositive" : MessageLookupByLibrary.simpleMessage("Nilai mestilah positif"),
    "verify" : MessageLookupByLibrary.simpleMessage("Sahkan"),
    "verifyAddressFailed" : m35,
    "verifyKeyPairsEveryLoad" : MessageLookupByLibrary.simpleMessage("Sahkan pasangan kunci setiap beban"),
    "verifyWalletResults" : m36,
    "verifying" : MessageLookupByLibrary.simpleMessage("Mengesahkan ..."),
    "version" : MessageLookupByLibrary.simpleMessage("Versi"),
    "walletAccountName" : m37,
    "wallets" : MessageLookupByLibrary.simpleMessage("Dompet"),
    "warning" : MessageLookupByLibrary.simpleMessage("Amaran"),
    "watchOnlyWallet" : MessageLookupByLibrary.simpleMessage("Wallet Hanya Tonton"),
    "welcomeDesc" : MessageLookupByLibrary.simpleMessage("Untuk memulakan, buat dompet:"),
    "welcomeTitle" : MessageLookupByLibrary.simpleMessage("Selamat datang ke Cruzall")
  };
}
