// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a id locale. All the
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
  String get localeName => 'id';

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

  static m13(id) => "ID: ${id}";

  static m14(kiloHashPerSecond) => "${kiloHashPerSecond} KH / s";

  static m15(item1, item2, item3, item4) => "${item1} , ${item2} , ${item3} , ${item4}";

  static m16(item1, item2, item3) => "${item1} , ${item2} , ${item3}";

  static m17(item1, item2) => "${item1} , ${item2}";

  static m18(cap) => "Kapitalisasi pasar {@<a>} ${cap} {@</a>}";

  static m19(megaHashPerSecond) => "${megaHashPerSecond} MH / s";

  static m20(item) => "[ {@<a>} ${item} {@</a>} ]";

  static m21(item1, item2) => "[ {@<a1>} ${item1} {@</a1>} , {@<a2>} ${item2} {@</a2>} ]";

  static m22(amount) => "Jumlah minimum adalah ${amount}";

  static m23(fee) => "Biaya minimum adalah ${fee}";

  static m24(minutes, seconds) => "${minutes} ${seconds}";

  static m25(minutes) => "${Intl.plural(minutes, one: '${minutes} menit', other: '${minutes} menit')}";

  static m26(type) => "${type} Jaringan";

  static m27(number) => "Transaksi ( ${number} )";

  static m28(petaHashPerSecond) => "${petaHashPerSecond} PH / s";

  static m29(seconds) => "${Intl.plural(seconds, one: '${seconds} detik', other: '${seconds} detik')}";

  static m30(transactionId) => "Terkirim ${transactionId}";

  static m31(teraHashPerSecond) => "${teraHashPerSecond} TH / s";

  static m32(address) => "Kepada: ${address}";

  static m33(totalBlocks, duration) => "${totalBlocks} {@<a1>} memblokir {@</a1>} di {@<a2>} ${duration} {@</a2>}";

  static m34(totalBlocks, totalTransactions, duration) => "${totalBlocks} {@<a1>} memblokir {@</a1>} , ${totalTransactions} transaksi dalam {@<a2>} ${duration} {@</a2>}";

  static m35(addressText) => "verifikasi gagal: ${addressText}";

  static m36(goodAddresses, totalAddresses, goodTests, totalTests) => "${goodAddresses} / ${totalAddresses} dan ${goodTests} / ${totalTests} tes berhasil";

  static m37(walletName, accountId, chainIndex) => "${walletName}: Akun ${accountId}, Alamat ${chainIndex}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "account" : MessageLookupByLibrary.simpleMessage("Rekening"),
    "accounts" : MessageLookupByLibrary.simpleMessage("Akun"),
    "activeTransactions" : MessageLookupByLibrary.simpleMessage("Transaksi aktif"),
    "addWallet" : MessageLookupByLibrary.simpleMessage("Tambahkan Dompet"),
    "address" : MessageLookupByLibrary.simpleMessage("Alamat"),
    "addressMustBeUnique" : MessageLookupByLibrary.simpleMessage("Alamat harus unik."),
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
    "btcTicker" : MessageLookupByLibrary.simpleMessage("BTC"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Membatalkan"),
    "cantDeleteOnlyWallet" : MessageLookupByLibrary.simpleMessage("Tidak dapat menghapus satu-satunya dompet."),
    "chainCode" : MessageLookupByLibrary.simpleMessage("Kode Rantai"),
    "chainIndex" : MessageLookupByLibrary.simpleMessage("Indeks Rantai"),
    "chainWork" : MessageLookupByLibrary.simpleMessage("Pekerjaan Rantai"),
    "confirmPassword" : MessageLookupByLibrary.simpleMessage("konfirmasi sandi"),
    "confirmations" : MessageLookupByLibrary.simpleMessage("Konfirmasi"),
    "connected" : MessageLookupByLibrary.simpleMessage("Terhubung"),
    "console" : MessageLookupByLibrary.simpleMessage("Menghibur"),
    "contacts" : MessageLookupByLibrary.simpleMessage("Kontak"),
    "copied" : MessageLookupByLibrary.simpleMessage("Disalin."),
    "copy" : MessageLookupByLibrary.simpleMessage("Salinan"),
    "copyAddresses" : MessageLookupByLibrary.simpleMessage("Salin Alamat"),
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
    "duration" : MessageLookupByLibrary.simpleMessage("Durasi"),
    "earliestSeen" : MessageLookupByLibrary.simpleMessage("Terlihat Terlama"),
    "email" : MessageLookupByLibrary.simpleMessage("E-mail"),
    "encrypt" : MessageLookupByLibrary.simpleMessage("Enkripsi"),
    "encryption" : MessageLookupByLibrary.simpleMessage("Enkripsi"),
    "ethTicker" : MessageLookupByLibrary.simpleMessage("ETH"),
    "exaHashPerSecond" : m6,
    "expired" : MessageLookupByLibrary.simpleMessage("Kedaluwarsa"),
    "expires" : MessageLookupByLibrary.simpleMessage("Kedaluwarsa"),
    "externalAddress" : MessageLookupByLibrary.simpleMessage("Alamat Eksternal"),
    "fee" : MessageLookupByLibrary.simpleMessage("Biaya"),
    "from" : MessageLookupByLibrary.simpleMessage("Dari"),
    "fromAddress" : m7,
    "generateNewAddress" : MessageLookupByLibrary.simpleMessage("Hasilkan alamat baru"),
    "gigaHashPerSecond" : m8,
    "hashPerSecond" : m9,
    "hashRoot" : MessageLookupByLibrary.simpleMessage("Hash Root"),
    "hdWallet" : MessageLookupByLibrary.simpleMessage("Dompet HD"),
    "hdWalletAlgorithm" : MessageLookupByLibrary.simpleMessage("PBKDF: 2048 iterasi"),
    "height" : MessageLookupByLibrary.simpleMessage("Tinggi"),
    "heightEquals" : m10,
    "hide" : MessageLookupByLibrary.simpleMessage("Menyembunyikan"),
    "home" : MessageLookupByLibrary.simpleMessage("Rumah"),
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
    "itemId" : m13,
    "kiloHashPerSecond" : m14,
    "language" : MessageLookupByLibrary.simpleMessage("Bahasa"),
    "latestSeen" : MessageLookupByLibrary.simpleMessage("Terbaru terlihat"),
    "license" : MessageLookupByLibrary.simpleMessage("Lisensi"),
    "listOfFour" : m15,
    "listOfThree" : m16,
    "listOfTwo" : m17,
    "loading" : MessageLookupByLibrary.simpleMessage("Pemuatan..."),
    "localeLanguage" : MessageLookupByLibrary.simpleMessage("Bahasa Indonesia"),
    "marketCap" : m18,
    "matured" : MessageLookupByLibrary.simpleMessage("Jatuh tempo"),
    "matures" : MessageLookupByLibrary.simpleMessage("Jatuh tempo"),
    "maturing" : MessageLookupByLibrary.simpleMessage("Jatuh tempo"),
    "maturingTransactions" : MessageLookupByLibrary.simpleMessage("Transaksi jatuh tempo"),
    "maxMemoLength" : MessageLookupByLibrary.simpleMessage("Panjang memo maksimum adalah 100"),
    "megaHashPerSecond" : m19,
    "memo" : MessageLookupByLibrary.simpleMessage("Memo"),
    "menuOfOne" : m20,
    "menuOfTwo" : m21,
    "minAmount" : m22,
    "minFee" : m23,
    "minutesAndSecondsDuration" : m24,
    "minutesDuration" : m25,
    "name" : MessageLookupByLibrary.simpleMessage("Nama"),
    "nameMustBeUnique" : MessageLookupByLibrary.simpleMessage("Nama harus unik."),
    "network" : MessageLookupByLibrary.simpleMessage("Jaringan"),
    "networkOffline" : MessageLookupByLibrary.simpleMessage("Jaringan offline"),
    "networkType" : m26,
    "newContact" : MessageLookupByLibrary.simpleMessage("Kontak baru"),
    "newPeer" : MessageLookupByLibrary.simpleMessage("Rekan Baru"),
    "newWallet" : MessageLookupByLibrary.simpleMessage("Dompet Baru"),
    "next" : MessageLookupByLibrary.simpleMessage("Berikutnya"),
    "noPrivateKeys" : MessageLookupByLibrary.simpleMessage("Tidak ada kunci pribadi"),
    "noPublicKeys" : MessageLookupByLibrary.simpleMessage("Tidak ada kunci publik"),
    "nonce" : MessageLookupByLibrary.simpleMessage("Nonce"),
    "numTransactions" : m27,
    "ok" : MessageLookupByLibrary.simpleMessage("Baik"),
    "password" : MessageLookupByLibrary.simpleMessage("Kata sandi"),
    "passwordCantBeEmpty" : MessageLookupByLibrary.simpleMessage("Kata sandi tidak boleh kosong."),
    "passwordsDontMatch" : MessageLookupByLibrary.simpleMessage("Kata sandi tidak cocok."),
    "paste" : MessageLookupByLibrary.simpleMessage("Pasta"),
    "payTo" : MessageLookupByLibrary.simpleMessage("Membayar"),
    "peers" : MessageLookupByLibrary.simpleMessage("Teman sebaya"),
    "pending" : MessageLookupByLibrary.simpleMessage("Tertunda"),
    "petaHashPerSecond" : m28,
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
    "secondsDuration" : m29,
    "seedPhrase" : MessageLookupByLibrary.simpleMessage("Frase benih"),
    "seedPhraseWarning" : MessageLookupByLibrary.simpleMessage("Benih ini memungkinkan siapa pun yang mengetahui untuk menghabiskan semua dana dari dompet Anda. Tuliskan. Jaga agar tetap aman."),
    "send" : MessageLookupByLibrary.simpleMessage("Kirim"),
    "sendFailed" : MessageLookupByLibrary.simpleMessage("Pengiriman gagal"),
    "sending" : MessageLookupByLibrary.simpleMessage("Mengirim ..."),
    "sentTransactionId" : m30,
    "settings" : MessageLookupByLibrary.simpleMessage("Pengaturan"),
    "show" : MessageLookupByLibrary.simpleMessage("Menunjukkan"),
    "showWalletNameInTitle" : MessageLookupByLibrary.simpleMessage("Tampilkan nama dompet dalam judul"),
    "state" : MessageLookupByLibrary.simpleMessage("Negara"),
    "submit" : MessageLookupByLibrary.simpleMessage("Kirimkan"),
    "support" : MessageLookupByLibrary.simpleMessage("Mendukung"),
    "target" : MessageLookupByLibrary.simpleMessage("Target"),
    "teraHashPerSecond" : m31,
    "thanksForDonating" : MessageLookupByLibrary.simpleMessage("Tepat! Terima kasih komunitas CRUZ!"),
    "theme" : MessageLookupByLibrary.simpleMessage("Tema"),
    "time" : MessageLookupByLibrary.simpleMessage("Waktu"),
    "tip" : MessageLookupByLibrary.simpleMessage("Tip"),
    "title" : MessageLookupByLibrary.simpleMessage("Cruzall"),
    "to" : MessageLookupByLibrary.simpleMessage("Untuk"),
    "toAddress" : m32,
    "totalBlocksInLastDuration" : m33,
    "totalBlocksTransactionsInLastDuration" : m34,
    "transaction" : MessageLookupByLibrary.simpleMessage("Transaksi"),
    "transactions" : MessageLookupByLibrary.simpleMessage("Transaksi"),
    "typingAddressesWarning" : MessageLookupByLibrary.simpleMessage("Peringatan: Mengetik alamat dengan tangan berbahaya dan rentan kesalahan. Selalu gunakan tombol salin atau pemindai QR."),
    "unableToDecode" : MessageLookupByLibrary.simpleMessage("Tidak dapat memecahkan kode"),
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
    "verifyAddressFailed" : m35,
    "verifyKeyPairsEveryLoad" : MessageLookupByLibrary.simpleMessage("Verifikasi pasangan kunci setiap beban"),
    "verifyWalletResults" : m36,
    "verifying" : MessageLookupByLibrary.simpleMessage("Memverifikasi ..."),
    "version" : MessageLookupByLibrary.simpleMessage("Versi"),
    "walletAccountName" : m37,
    "wallets" : MessageLookupByLibrary.simpleMessage("Dompet"),
    "warning" : MessageLookupByLibrary.simpleMessage("Peringatan"),
    "watchOnlyWallet" : MessageLookupByLibrary.simpleMessage("Dompet Khusus Jam Tangan"),
    "welcomeDesc" : MessageLookupByLibrary.simpleMessage("Untuk memulai, buat dompet:"),
    "welcomeTitle" : MessageLookupByLibrary.simpleMessage("Selamat datang di Cruzall")
  };
}
