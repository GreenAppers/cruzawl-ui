// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a id locale. All the
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
  get localeName => 'id';

  static m0(address) => "Alamat ${address}";

  static m1(height) => "Saldo Anda pada ketinggian blok {@<a>} ${height} {@</a>} adalah:";

  static m2(height) => "Saldo Anda jatuh tempo berdasarkan tinggi ${height} adalah:";

  static m3(ticker, balance) => "${ticker} + ${balance}";

  static m4(algorithm) => "Membuat ... ( ${algorithm} )";

  static m5(days) => "${Intl.plural(days, one: 'hari', other: '${days} hari')}";

  static m6(exaHashPerSecond) => "${exaHashPerSecond} EH / s";

  static m7(address) => "Dari: ${address}";

  static m8(gigaHashPerSecond) => "${gigaHashPerSecond} GH / s";

  static m9(hashPerSecond) => "${hashPerSecond} H / s";

  static m10(height) => "tinggi = {@<a>} ${height} {@</a>}";

  static m11(product) => "${product} Halaman Depan";

  static m12(hours) => "${Intl.plural(hours, one: 'jam', other: '${hours} jam')}";

  static m13(kiloHashPerSecond) => "${kiloHashPerSecond} KH / s";

  static m14(item1, item2, item3, item4) => "${item1} , ${item2} , ${item3} , ${item4}";

  static m15(item1, item2, item3) => "${item1} , ${item2} , ${item3}";

  static m16(item1, item2) => "${item1} , ${item2}";

  static m17(cap) => "Kapitalisasi pasar {@<a>} ${cap} {@</a>}";

  static m18(megaHashPerSecond) => "${megaHashPerSecond} MH / s";

  static m19(item) => "[ {@<a>} ${item} {@</a>} ]";

  static m20(item1, item2) => "[ {@<a1>} ${item1} {@</a1>} , {@<a2>} ${item2} {@</a2>} ]";

  static m21(amount) => "Jumlah minimum adalah ${amount}";

  static m22(fee) => "Biaya minimum adalah ${fee}";

  static m23(minutes, seconds) => "${minutes} ${seconds}";

  static m24(minutes) => "${Intl.plural(minutes, one: '${minutes} menit', other: '${minutes} menit')}";

  static m25(type) => "${type} Jaringan";

  static m26(number) => "Transaksi ( ${number} )";

  static m27(petaHashPerSecond) => "${petaHashPerSecond} PH / s";

  static m28(seconds) => "${Intl.plural(seconds, one: '${seconds} detik', other: '${seconds} detik')}";

  static m29(transactionId) => "Terkirim ${transactionId}";

  static m30(teraHashPerSecond) => "${teraHashPerSecond} TH / s";

  static m31(address) => "Kepada: ${address}";

  static m32(totalBlocks, duration) => "${totalBlocks} {@<a1>} memblokir {@</a1>} di {@<a2>} ${duration} {@</a2>}";

  static m33(totalBlocks, totalTransactions, duration) => "${totalBlocks} {@<a1>} memblokir {@</a1>} , ${totalTransactions} transaksi dalam {@<a2>} ${duration} {@</a2>}";

  static m34(addressText) => "verifikasi gagal: ${addressText}";

  static m35(goodAddresses, totalAddresses, goodTests, totalTests) => "${goodAddresses} / ${totalAddresses} dan ${goodTests} / ${totalTests} tes berhasil";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "account" : MessageLookupByLibrary.simpleMessage("Rekening"),
    "accounts" : MessageLookupByLibrary.simpleMessage("Akun"),
    "activeTransactions" : MessageLookupByLibrary.simpleMessage("Transaksi aktif"),
    "addWallet" : MessageLookupByLibrary.simpleMessage("Tambahkan Dompet"),
    "address" : MessageLookupByLibrary.simpleMessage("Alamat"),
    "addressStateOpen" : MessageLookupByLibrary.simpleMessage("Buka"),
    "addressStateReserve" : MessageLookupByLibrary.simpleMessage("cadangan"),
    "addressStateUsed" : MessageLookupByLibrary.simpleMessage("bekas"),
    "addressTitle" : m0,
    "addresses" : MessageLookupByLibrary.simpleMessage("Alamat"),
    "amount" : MessageLookupByLibrary.simpleMessage("Jumlah"),
    "backupKeysWarning" : MessageLookupByLibrary.simpleMessage("Kunci Anda harus dicadangkan di penyimpanan eksternal."),
    "balance" : MessageLookupByLibrary.simpleMessage("Keseimbangan"),
    "balanceAtHeightIs" : m1,
    "balanceMaturingByHeightIs" : m2,
    "balanceTitle" : m3,
    "block" : MessageLookupByLibrary.simpleMessage("Blok"),
    "blocks" : MessageLookupByLibrary.simpleMessage("Blok"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Membatalkan"),
    "cantDeleteOnlyWallet" : MessageLookupByLibrary.simpleMessage("Tidak dapat menghapus satu-satunya dompet."),
    "chainCode" : MessageLookupByLibrary.simpleMessage("Kode Rantai"),
    "chainIndex" : MessageLookupByLibrary.simpleMessage("Indeks Rantai"),
    "chainWork" : MessageLookupByLibrary.simpleMessage("Pekerjaan Rantai"),
    "confirmPassword" : MessageLookupByLibrary.simpleMessage("konfirmasi sandi"),
    "confirmations" : MessageLookupByLibrary.simpleMessage("Konfirmasi"),
    "console" : MessageLookupByLibrary.simpleMessage("Menghibur"),
    "copied" : MessageLookupByLibrary.simpleMessage("Disalin."),
    "copy" : MessageLookupByLibrary.simpleMessage("Salinan"),
    "copyPublicKeys" : MessageLookupByLibrary.simpleMessage("Salin Kunci Publik"),
    "create" : MessageLookupByLibrary.simpleMessage("Membuat"),
    "creating" : MessageLookupByLibrary.simpleMessage("Menciptakan ..."),
    "creatingUsingAlgorithm" : m4,
    "cruzTicker" : MessageLookupByLibrary.simpleMessage("CRUZ"),
    "currency" : MessageLookupByLibrary.simpleMessage("Mata uang"),
    "currentBalanceIs" : MessageLookupByLibrary.simpleMessage("Saldo Anda saat ini adalah:"),
    "dangerZone" : MessageLookupByLibrary.simpleMessage("Zona Bahaya"),
    "date" : MessageLookupByLibrary.simpleMessage("Tanggal"),
    "daysDuration" : m5,
    "debugLog" : MessageLookupByLibrary.simpleMessage("Debug Log"),
    "defaultWalletName" : MessageLookupByLibrary.simpleMessage("Dompetku"),
    "delete" : MessageLookupByLibrary.simpleMessage("Menghapus"),
    "deletePeer" : MessageLookupByLibrary.simpleMessage("Hapus Peer"),
    "deleteThisWallet" : MessageLookupByLibrary.simpleMessage("Hapus dompet ini"),
    "deleteWallet" : MessageLookupByLibrary.simpleMessage("Hapus Dompet"),
    "deleteWalletDescription" : MessageLookupByLibrary.simpleMessage("Setelah Anda menghapus dompet, tidak ada jalan untuk kembali. Harap pastikan."),
    "deltaHashPower" : MessageLookupByLibrary.simpleMessage("Delta Hash Power"),
    "deltaTime" : MessageLookupByLibrary.simpleMessage("Waktu Delta"),
    "donations" : MessageLookupByLibrary.simpleMessage("Sumbangan"),
    "earliestSeen" : MessageLookupByLibrary.simpleMessage("Terlihat Terlama"),
    "email" : MessageLookupByLibrary.simpleMessage("E-mail"),
    "encrypt" : MessageLookupByLibrary.simpleMessage("Enkripsi"),
    "encryption" : MessageLookupByLibrary.simpleMessage("Enkripsi"),
    "exaHashPerSecond" : m6,
    "expired" : MessageLookupByLibrary.simpleMessage("Kedaluwarsa"),
    "expires" : MessageLookupByLibrary.simpleMessage("Kedaluwarsa"),
    "externalAddress" : MessageLookupByLibrary.simpleMessage("Alamat Eksternal"),
    "fee" : MessageLookupByLibrary.simpleMessage("Biaya"),
    "from" : MessageLookupByLibrary.simpleMessage("Dari"),
    "fromAddress" : m7,
    "generateNewAddress" : MessageLookupByLibrary.simpleMessage("Hasilkan alamat baru"),
    "gigaHashPerSecond" : m8,
    "hashListRoot" : MessageLookupByLibrary.simpleMessage("Root Daftar Hash"),
    "hashPerSecond" : m9,
    "hdWallet" : MessageLookupByLibrary.simpleMessage("Dompet HD"),
    "hdWalletAlgorithm" : MessageLookupByLibrary.simpleMessage("PBKDF: 2048 iterasi"),
    "height" : MessageLookupByLibrary.simpleMessage("Tinggi"),
    "heightEquals" : m10,
    "hide" : MessageLookupByLibrary.simpleMessage("Menyembunyikan"),
    "homePage" : m11,
    "hoursDuration" : m12,
    "id" : MessageLookupByLibrary.simpleMessage("Id"),
    "ignore" : MessageLookupByLibrary.simpleMessage("Mengabaikan"),
    "insecureDeviceWarning" : MessageLookupByLibrary.simpleMessage("Peringatan Perangkat Tidak Aman"),
    "insecureDeviceWarningDescription" : MessageLookupByLibrary.simpleMessage("Perangkat yang di-root atau di-jailbreak telah terdeteksi. Penggunaan lebih lanjut tidak disarankan."),
    "insufficientFunds" : MessageLookupByLibrary.simpleMessage("Dana tidak mencukupi"),
    "invalidAddress" : MessageLookupByLibrary.simpleMessage("Alamat tidak valid"),
    "invalidCurrency" : MessageLookupByLibrary.simpleMessage("Mata uang tidak valid"),
    "invalidJson" : MessageLookupByLibrary.simpleMessage("JSON tidak valid."),
    "invalidMnemonic" : MessageLookupByLibrary.simpleMessage("Mnemonik tidak valid"),
    "invalidPrivateKey" : MessageLookupByLibrary.simpleMessage("Kunci pribadi tidak valid."),
    "invalidPublicKey" : MessageLookupByLibrary.simpleMessage("Kunci publik tidak valid."),
    "invalidUrl" : MessageLookupByLibrary.simpleMessage("URL tidak valid."),
    "kiloHashPerSecond" : m13,
    "language" : MessageLookupByLibrary.simpleMessage("Bahasa"),
    "latestSeen" : MessageLookupByLibrary.simpleMessage("Terbaru terlihat"),
    "license" : MessageLookupByLibrary.simpleMessage("Lisensi"),
    "listOfFour" : m14,
    "listOfThree" : m15,
    "listOfTwo" : m16,
    "loading" : MessageLookupByLibrary.simpleMessage("Pemuatan..."),
    "localeLanguage" : MessageLookupByLibrary.simpleMessage("Bahasa Indonesia"),
    "marketCap" : m17,
    "matured" : MessageLookupByLibrary.simpleMessage("Jatuh tempo"),
    "matures" : MessageLookupByLibrary.simpleMessage("Jatuh tempo"),
    "maturing" : MessageLookupByLibrary.simpleMessage("Jatuh tempo"),
    "maturingTransactions" : MessageLookupByLibrary.simpleMessage("Transaksi jatuh tempo"),
    "maxMemoLength" : MessageLookupByLibrary.simpleMessage("Panjang memo maksimum adalah 100"),
    "megaHashPerSecond" : m18,
    "memo" : MessageLookupByLibrary.simpleMessage("Memo"),
    "menuOfOne" : m19,
    "menuOfTwo" : m20,
    "minAmount" : m21,
    "minFee" : m22,
    "minutesAndSecondsDuration" : m23,
    "minutesDuration" : m24,
    "name" : MessageLookupByLibrary.simpleMessage("Nama"),
    "nameMustBeUnique" : MessageLookupByLibrary.simpleMessage("Nama harus unik."),
    "network" : MessageLookupByLibrary.simpleMessage("Jaringan"),
    "networkOffline" : MessageLookupByLibrary.simpleMessage("Jaringan offline"),
    "networkType" : m25,
    "newPeer" : MessageLookupByLibrary.simpleMessage("Rekan Baru"),
    "newWallet" : MessageLookupByLibrary.simpleMessage("Dompet Baru"),
    "next" : MessageLookupByLibrary.simpleMessage("Berikutnya"),
    "noPrivateKeys" : MessageLookupByLibrary.simpleMessage("Tidak ada kunci pribadi"),
    "noPublicKeys" : MessageLookupByLibrary.simpleMessage("Tidak ada kunci publik"),
    "nonce" : MessageLookupByLibrary.simpleMessage("Nonce"),
    "numTransactions" : m26,
    "ok" : MessageLookupByLibrary.simpleMessage("Baik"),
    "password" : MessageLookupByLibrary.simpleMessage("Kata sandi"),
    "passwordCantBeEmpty" : MessageLookupByLibrary.simpleMessage("Kata sandi tidak boleh kosong."),
    "passwordsDontMatch" : MessageLookupByLibrary.simpleMessage("Kata sandi tidak cocok."),
    "paste" : MessageLookupByLibrary.simpleMessage("Pasta"),
    "payTo" : MessageLookupByLibrary.simpleMessage("Membayar"),
    "peers" : MessageLookupByLibrary.simpleMessage("Teman sebaya"),
    "pending" : MessageLookupByLibrary.simpleMessage("Tertunda"),
    "petaHashPerSecond" : m27,
    "previous" : MessageLookupByLibrary.simpleMessage("Sebelumnya"),
    "privacyPolicy" : MessageLookupByLibrary.simpleMessage("Rahasia pribadi"),
    "privateKey" : MessageLookupByLibrary.simpleMessage("Kunci Pribadi"),
    "privateKeyList" : MessageLookupByLibrary.simpleMessage("Daftar Kunci Pribadi"),
    "publicKeyList" : MessageLookupByLibrary.simpleMessage("Daftar Kunci Publik"),
    "receive" : MessageLookupByLibrary.simpleMessage("Menerima"),
    "recentHistory" : MessageLookupByLibrary.simpleMessage("Sejarah Terbaru"),
    "requireSSLCert" : MessageLookupByLibrary.simpleMessage("Membutuhkan sertifikat SSL"),
    "result" : MessageLookupByLibrary.simpleMessage("Hasil"),
    "search" : MessageLookupByLibrary.simpleMessage("Pencarian"),
    "secondsDuration" : m28,
    "seedPhrase" : MessageLookupByLibrary.simpleMessage("Frase benih"),
    "seedPhraseWarning" : MessageLookupByLibrary.simpleMessage("Benih ini memungkinkan siapa pun yang mengetahui untuk menghabiskan semua dana dari dompet Anda. Tuliskan. Jaga agar tetap aman."),
    "send" : MessageLookupByLibrary.simpleMessage("Kirim"),
    "sendFailed" : MessageLookupByLibrary.simpleMessage("Pengiriman gagal"),
    "sending" : MessageLookupByLibrary.simpleMessage("Mengirim ..."),
    "sentTransactionId" : m29,
    "settings" : MessageLookupByLibrary.simpleMessage("Pengaturan"),
    "show" : MessageLookupByLibrary.simpleMessage("Menunjukkan"),
    "showWalletNameInTitle" : MessageLookupByLibrary.simpleMessage("Tampilkan nama dompet dalam judul"),
    "state" : MessageLookupByLibrary.simpleMessage("Negara"),
    "support" : MessageLookupByLibrary.simpleMessage("Mendukung"),
    "target" : MessageLookupByLibrary.simpleMessage("Target"),
    "teraHashPerSecond" : m30,
    "thanksForDonating" : MessageLookupByLibrary.simpleMessage("Tepat! Terima kasih komunitas CRUZ!"),
    "theme" : MessageLookupByLibrary.simpleMessage("Tema"),
    "time" : MessageLookupByLibrary.simpleMessage("Waktu"),
    "tip" : MessageLookupByLibrary.simpleMessage("Tip"),
    "title" : MessageLookupByLibrary.simpleMessage("Cruzall"),
    "to" : MessageLookupByLibrary.simpleMessage("Untuk"),
    "toAddress" : m31,
    "totalBlocksInLastDuration" : m32,
    "totalBlocksTransactionsInLastDuration" : m33,
    "transaction" : MessageLookupByLibrary.simpleMessage("Transaksi"),
    "transactions" : MessageLookupByLibrary.simpleMessage("Transaksi"),
    "unitTestBeforeCreatingWallets" : MessageLookupByLibrary.simpleMessage("Uji unit sebelum membuat dompet"),
    "unitTestFailure" : MessageLookupByLibrary.simpleMessage("Kegagalan uji unit"),
    "unknown" : MessageLookupByLibrary.simpleMessage("Tidak dikenal"),
    "unknownAddress" : MessageLookupByLibrary.simpleMessage("Alamat tidak dikenal"),
    "unknownQuery" : MessageLookupByLibrary.simpleMessage("Kueri tidak dikenal"),
    "unlock" : MessageLookupByLibrary.simpleMessage("Membuka kunci"),
    "unlockTitle" : MessageLookupByLibrary.simpleMessage("Buka Cruzall"),
    "url" : MessageLookupByLibrary.simpleMessage("URL"),
    "valueMustBePositive" : MessageLookupByLibrary.simpleMessage("Nilai harus positif"),
    "verify" : MessageLookupByLibrary.simpleMessage("Memeriksa"),
    "verifyAddressFailed" : m34,
    "verifyKeyPairsEveryLoad" : MessageLookupByLibrary.simpleMessage("Verifikasi pasangan kunci setiap beban"),
    "verifyWalletResults" : m35,
    "verifying" : MessageLookupByLibrary.simpleMessage("Memverifikasi ..."),
    "version" : MessageLookupByLibrary.simpleMessage("Versi"),
    "warning" : MessageLookupByLibrary.simpleMessage("Peringatan"),
    "watchOnlyWallet" : MessageLookupByLibrary.simpleMessage("Dompet Khusus Jam Tangan"),
    "welcomeDesc" : MessageLookupByLibrary.simpleMessage("Untuk memulai, buat dompet:"),
    "welcomeTitle" : MessageLookupByLibrary.simpleMessage("Selamat datang di Cruzall")
  };
}
