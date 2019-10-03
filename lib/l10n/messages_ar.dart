// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
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
  String get localeName => 'ar';

  static m0(address) => "العنوان ${address}";

  static m1(height) => "رصيدك عند ارتفاع الكتلة {@<a>} ${height} {@</a>} هو:";

  static m2(height) => "رصيدك المستحق حسب الارتفاع ${height} هو:";

  static m3(ticker, balance) => "${ticker} + ${balance}";

  static m4(algorithm) => "إنشاء ... ( ${algorithm} )";

  static m5(days) => "${Intl.plural(days, one: 'يوم', other: '${days} أيام')}";

  static m6(exaHashPerSecond) => "${exaHashPerSecond} EH / s";

  static m7(address) => "من: ${address}";

  static m8(gigaHashPerSecond) => "${gigaHashPerSecond} GH / s";

  static m9(hashPerSecond) => "${hashPerSecond} H / s";

  static m10(height) => "ارتفاع = {@<a>} ${height} {@</a>}";

  static m11(product) => "${product} الصفحة الرئيسية";

  static m12(hours) => "${Intl.plural(hours, one: 'ساعة', other: '${hours} ساعات')}";

  static m13(id) => "المعرف: ${id}";

  static m14(kiloHashPerSecond) => "${kiloHashPerSecond} KH / s";

  static m15(item1, item2, item3, item4) => "${item1} ، ${item2} ، ${item3} ، ${item4}";

  static m16(item1, item2, item3) => "${item1} ، ${item2} ، ${item3}";

  static m17(item1, item2) => "${item1} ، ${item2}";

  static m18(cap) => "سقف السوق {@<a>} ${cap} {@</a>}";

  static m19(megaHashPerSecond) => "${megaHashPerSecond} MH / s";

  static m20(item) => "[ {@<a>} ${item} {@</a>} ]";

  static m21(item1, item2) => "[ {@<a1>} ${item1} {@</a1>} ، {@<a2>} ${item2} {@</a2>} ]";

  static m22(amount) => "الحد الأدنى للمبلغ هو ${amount}";

  static m23(fee) => "الحد الأدنى للرسوم هو ${fee}";

  static m24(minutes, seconds) => "${minutes} ${seconds}";

  static m25(minutes) => "${Intl.plural(minutes, one: '${minutes} دقيقة', other: '${minutes} دقيقة')}";

  static m26(type) => "${type} الشبكة";

  static m27(number) => "المعاملات ( ${number} )";

  static m28(petaHashPerSecond) => "${petaHashPerSecond} PH / s";

  static m29(seconds) => "${Intl.plural(seconds, one: '${seconds} ثانية', other: '${seconds} ثانية')}";

  static m30(transactionId) => "تم الإرسال ${transactionId}";

  static m31(teraHashPerSecond) => "${teraHashPerSecond} TH / s";

  static m32(address) => "إلى: ${address}";

  static m33(totalBlocks, duration) => "${totalBlocks} {@<a1>} الكتل {@</a1>} في آخر {@<a2>} ${duration} {@</a2>}";

  static m34(totalBlocks, totalTransactions, duration) => "${totalBlocks} {@<a1>} الكتل {@</a1>} ، ${totalTransactions} المعاملات في {@<a2>} ${duration} {@</a2>}";

  static m35(addressText) => "فشل التحقق: ${addressText}";

  static m36(goodAddresses, totalAddresses, goodTests, totalTests) => "تم ${goodAddresses} التحقق من ${goodAddresses} / ${totalAddresses} و ${goodTests} / ${totalTests}";

  static m37(walletName, accountId, chainIndex) => "${walletName} : الحساب ${accountId} ، العنوان ${chainIndex}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "account" : MessageLookupByLibrary.simpleMessage("الحساب"),
    "accounts" : MessageLookupByLibrary.simpleMessage("حسابات"),
    "activeTransactions" : MessageLookupByLibrary.simpleMessage("المعاملات النشطة"),
    "addWallet" : MessageLookupByLibrary.simpleMessage("أضف محفظة"),
    "address" : MessageLookupByLibrary.simpleMessage("عنوان"),
    "addressMustBeUnique" : MessageLookupByLibrary.simpleMessage("يجب أن يكون العنوان فريدًا."),
    "addressStateOpen" : MessageLookupByLibrary.simpleMessage("افتح"),
    "addressStateReserve" : MessageLookupByLibrary.simpleMessage("الاحتياطي"),
    "addressStateUsed" : MessageLookupByLibrary.simpleMessage("مستخدم"),
    "addressTitle" : m0,
    "addresses" : MessageLookupByLibrary.simpleMessage("عناوين"),
    "amount" : MessageLookupByLibrary.simpleMessage("كمية"),
    "backupKeysWarning" : MessageLookupByLibrary.simpleMessage("يجب عمل نسخ احتياطية من مفاتيحك على وحدة التخزين الخارجية."),
    "balance" : MessageLookupByLibrary.simpleMessage("توازن"),
    "balanceAtHeightIs" : m1,
    "balanceMaturingByHeightIs" : m2,
    "balanceTitle" : m3,
    "block" : MessageLookupByLibrary.simpleMessage("منع"),
    "blocks" : MessageLookupByLibrary.simpleMessage("كتل"),
    "btcTicker" : MessageLookupByLibrary.simpleMessage("BTC"),
    "cancel" : MessageLookupByLibrary.simpleMessage("إلغاء"),
    "cantDeleteOnlyWallet" : MessageLookupByLibrary.simpleMessage("لا يمكن حذف المحفظة الوحيدة."),
    "chainCode" : MessageLookupByLibrary.simpleMessage("كود السلسلة"),
    "chainIndex" : MessageLookupByLibrary.simpleMessage("مؤشر السلسلة"),
    "chainWork" : MessageLookupByLibrary.simpleMessage("سلسلة العمل"),
    "confirmPassword" : MessageLookupByLibrary.simpleMessage("تأكيد كلمة المرور"),
    "confirmations" : MessageLookupByLibrary.simpleMessage("تأكيدات"),
    "connected" : MessageLookupByLibrary.simpleMessage("متصل"),
    "console" : MessageLookupByLibrary.simpleMessage("وحدة التحكم"),
    "contacts" : MessageLookupByLibrary.simpleMessage("جهات الاتصال"),
    "copied" : MessageLookupByLibrary.simpleMessage("نسخ."),
    "copy" : MessageLookupByLibrary.simpleMessage("نسخ"),
    "copyAddresses" : MessageLookupByLibrary.simpleMessage("نسخ العناوين"),
    "copyPublicKeys" : MessageLookupByLibrary.simpleMessage("نسخ المفاتيح العامة"),
    "create" : MessageLookupByLibrary.simpleMessage("خلق"),
    "creating" : MessageLookupByLibrary.simpleMessage("خلق..."),
    "creatingUsingAlgorithm" : m4,
    "cruzTicker" : MessageLookupByLibrary.simpleMessage("CRUZ"),
    "currency" : MessageLookupByLibrary.simpleMessage("دقة"),
    "currentBalanceIs" : MessageLookupByLibrary.simpleMessage("رصيدك الحالي هو:"),
    "dangerZone" : MessageLookupByLibrary.simpleMessage("منطقة الخطر"),
    "date" : MessageLookupByLibrary.simpleMessage("تاريخ"),
    "daysDuration" : m5,
    "debugLog" : MessageLookupByLibrary.simpleMessage("سجل التصحيح"),
    "defaultWalletName" : MessageLookupByLibrary.simpleMessage("محفظتي"),
    "delete" : MessageLookupByLibrary.simpleMessage("حذف"),
    "deletePeer" : MessageLookupByLibrary.simpleMessage("حذف النظير"),
    "deleteThisWallet" : MessageLookupByLibrary.simpleMessage("حذف هذه المحفظة"),
    "deleteWallet" : MessageLookupByLibrary.simpleMessage("حذف المحفظة"),
    "deleteWalletDescription" : MessageLookupByLibrary.simpleMessage("بمجرد حذف محفظة ، لن يكون هناك عودة. يرجى أن تكون متأكدا."),
    "deltaHashPower" : MessageLookupByLibrary.simpleMessage("دلتا هاش باور"),
    "deltaTime" : MessageLookupByLibrary.simpleMessage("دلتا الوقت"),
    "donations" : MessageLookupByLibrary.simpleMessage("التبرعات"),
    "duration" : MessageLookupByLibrary.simpleMessage("المدة الزمنية"),
    "earliestSeen" : MessageLookupByLibrary.simpleMessage("أقرب ينظر"),
    "email" : MessageLookupByLibrary.simpleMessage("البريد الإلكتروني"),
    "encrypt" : MessageLookupByLibrary.simpleMessage("تشفير"),
    "encryption" : MessageLookupByLibrary.simpleMessage("التشفير"),
    "ethTicker" : MessageLookupByLibrary.simpleMessage("ETH"),
    "exaHashPerSecond" : m6,
    "expired" : MessageLookupByLibrary.simpleMessage("منتهية الصلاحية"),
    "expires" : MessageLookupByLibrary.simpleMessage("تنتهي"),
    "externalAddress" : MessageLookupByLibrary.simpleMessage("العنوان الخارجي"),
    "fee" : MessageLookupByLibrary.simpleMessage("رسوم"),
    "from" : MessageLookupByLibrary.simpleMessage("من عند"),
    "fromAddress" : m7,
    "generateNewAddress" : MessageLookupByLibrary.simpleMessage("توليد عنوان جديد"),
    "gigaHashPerSecond" : m8,
    "hashPerSecond" : m9,
    "hashRoot" : MessageLookupByLibrary.simpleMessage("تجزئة الجذر"),
    "hdWallet" : MessageLookupByLibrary.simpleMessage("HD محفظة"),
    "hdWalletAlgorithm" : MessageLookupByLibrary.simpleMessage("PBKDF: 2048 التكرار"),
    "height" : MessageLookupByLibrary.simpleMessage("ارتفاع"),
    "heightEquals" : m10,
    "hide" : MessageLookupByLibrary.simpleMessage("إخفاء"),
    "home" : MessageLookupByLibrary.simpleMessage("الصفحة الرئيسية"),
    "homePage" : m11,
    "hoursDuration" : m12,
    "id" : MessageLookupByLibrary.simpleMessage("هوية شخصية"),
    "ignore" : MessageLookupByLibrary.simpleMessage("تجاهل"),
    "insecureDeviceWarning" : MessageLookupByLibrary.simpleMessage("تحذير جهاز غير آمن"),
    "insecureDeviceWarningDescription" : MessageLookupByLibrary.simpleMessage("تم اكتشاف جهاز تم كسره أو كسره. مزيد من الاستخدام غير مستحسن."),
    "insufficientFunds" : MessageLookupByLibrary.simpleMessage("رصيد غير كاف"),
    "invalidAddress" : MessageLookupByLibrary.simpleMessage("عنوان خاطئ"),
    "invalidCurrency" : MessageLookupByLibrary.simpleMessage("عملة غير صالحة"),
    "invalidJson" : MessageLookupByLibrary.simpleMessage("JSON غير صالح."),
    "invalidMnemonic" : MessageLookupByLibrary.simpleMessage("ذاكري غير صالح"),
    "invalidPrivateKey" : MessageLookupByLibrary.simpleMessage("مفتاح خاص غير صالح."),
    "invalidPublicKey" : MessageLookupByLibrary.simpleMessage("المفتاح العمومي غير صالح."),
    "invalidUrl" : MessageLookupByLibrary.simpleMessage("URL غير صالح."),
    "itemId" : m13,
    "kiloHashPerSecond" : m14,
    "language" : MessageLookupByLibrary.simpleMessage("لغة"),
    "latestSeen" : MessageLookupByLibrary.simpleMessage("شوهد آخر مرة"),
    "license" : MessageLookupByLibrary.simpleMessage("رخصة"),
    "listOfFour" : m15,
    "listOfThree" : m16,
    "listOfTwo" : m17,
    "loading" : MessageLookupByLibrary.simpleMessage("جار التحميل..."),
    "localeLanguage" : MessageLookupByLibrary.simpleMessage("العربية"),
    "marketCap" : m18,
    "matured" : MessageLookupByLibrary.simpleMessage("نضجت"),
    "matures" : MessageLookupByLibrary.simpleMessage("نضوج"),
    "maturing" : MessageLookupByLibrary.simpleMessage("نضوج"),
    "maturingTransactions" : MessageLookupByLibrary.simpleMessage("المعاملات الناضجة"),
    "maxMemoLength" : MessageLookupByLibrary.simpleMessage("الحد الأقصى لطول المذكرة هو 100"),
    "megaHashPerSecond" : m19,
    "memo" : MessageLookupByLibrary.simpleMessage("مذكرة"),
    "menuOfOne" : m20,
    "menuOfTwo" : m21,
    "minAmount" : m22,
    "minFee" : m23,
    "minutesAndSecondsDuration" : m24,
    "minutesDuration" : m25,
    "name" : MessageLookupByLibrary.simpleMessage("اسم"),
    "nameMustBeUnique" : MessageLookupByLibrary.simpleMessage("يجب أن يكون الاسم فريدًا."),
    "network" : MessageLookupByLibrary.simpleMessage("شبكة الاتصال"),
    "networkOffline" : MessageLookupByLibrary.simpleMessage("شبكة حاليا"),
    "networkType" : m26,
    "newContact" : MessageLookupByLibrary.simpleMessage("جهة اتصال جديدة"),
    "newPeer" : MessageLookupByLibrary.simpleMessage("نظير جديد"),
    "newWallet" : MessageLookupByLibrary.simpleMessage("محفظة جديدة"),
    "next" : MessageLookupByLibrary.simpleMessage("التالى"),
    "noPrivateKeys" : MessageLookupByLibrary.simpleMessage("لا مفاتيح خاصة"),
    "noPublicKeys" : MessageLookupByLibrary.simpleMessage("لا مفاتيح عامة"),
    "nonce" : MessageLookupByLibrary.simpleMessage("مناسبة حالية"),
    "numTransactions" : m27,
    "ok" : MessageLookupByLibrary.simpleMessage("حسنا"),
    "password" : MessageLookupByLibrary.simpleMessage("كلمه السر"),
    "passwordCantBeEmpty" : MessageLookupByLibrary.simpleMessage("كلمة المرور لا يمكن أن تكون فارغة."),
    "passwordsDontMatch" : MessageLookupByLibrary.simpleMessage("كلمات المرور غير متطابقة."),
    "paste" : MessageLookupByLibrary.simpleMessage("معجون"),
    "payTo" : MessageLookupByLibrary.simpleMessage("دفع ل"),
    "peers" : MessageLookupByLibrary.simpleMessage("الأقران"),
    "pending" : MessageLookupByLibrary.simpleMessage("قيد الانتظار"),
    "petaHashPerSecond" : m28,
    "previous" : MessageLookupByLibrary.simpleMessage("السابق"),
    "privacyPolicy" : MessageLookupByLibrary.simpleMessage("سياسة خاصة"),
    "privateKey" : MessageLookupByLibrary.simpleMessage("مفتاح سري"),
    "privateKeyList" : MessageLookupByLibrary.simpleMessage("قائمة المفاتيح الخاصة"),
    "publicKeyList" : MessageLookupByLibrary.simpleMessage("قائمة المفاتيح العامة"),
    "receive" : MessageLookupByLibrary.simpleMessage("تسلم"),
    "recentHistory" : MessageLookupByLibrary.simpleMessage("التاريخ الحديث"),
    "requireSSLCert" : MessageLookupByLibrary.simpleMessage("طلب شهادة SSL"),
    "result" : MessageLookupByLibrary.simpleMessage("نتيجة"),
    "search" : MessageLookupByLibrary.simpleMessage("بحث"),
    "secondsDuration" : m29,
    "seedPhrase" : MessageLookupByLibrary.simpleMessage("عبارة البذور"),
    "seedPhraseWarning" : MessageLookupByLibrary.simpleMessage("هذه البذرة تسمح لأي شخص يعرف ذلك بإنفاق كل الأموال منك. اكتبه. احتفظ بها آمنة."),
    "send" : MessageLookupByLibrary.simpleMessage("إرسال"),
    "sendFailed" : MessageLookupByLibrary.simpleMessage("فشل إرسال"),
    "sending" : MessageLookupByLibrary.simpleMessage("إرسال..."),
    "sentTransactionId" : m30,
    "settings" : MessageLookupByLibrary.simpleMessage("الإعدادات"),
    "show" : MessageLookupByLibrary.simpleMessage("تبين"),
    "showWalletNameInTitle" : MessageLookupByLibrary.simpleMessage("إظهار اسم المحفظة في العنوان"),
    "state" : MessageLookupByLibrary.simpleMessage("حالة"),
    "submit" : MessageLookupByLibrary.simpleMessage("تقديم"),
    "support" : MessageLookupByLibrary.simpleMessage("الدعم"),
    "target" : MessageLookupByLibrary.simpleMessage("استهداف"),
    "teraHashPerSecond" : m31,
    "thanksForDonating" : MessageLookupByLibrary.simpleMessage("الحق علي! شكرا المجتمع CRUZ!"),
    "theme" : MessageLookupByLibrary.simpleMessage("موضوع"),
    "time" : MessageLookupByLibrary.simpleMessage("زمن"),
    "tip" : MessageLookupByLibrary.simpleMessage("تلميح"),
    "title" : MessageLookupByLibrary.simpleMessage("Cruzall"),
    "to" : MessageLookupByLibrary.simpleMessage("إلى"),
    "toAddress" : m32,
    "totalBlocksInLastDuration" : m33,
    "totalBlocksTransactionsInLastDuration" : m34,
    "transaction" : MessageLookupByLibrary.simpleMessage("عملية تجارية"),
    "transactions" : MessageLookupByLibrary.simpleMessage("المعاملات"),
    "typingAddressesWarning" : MessageLookupByLibrary.simpleMessage("تحذير: كتابة العناوين باليد أمر خطير وعرضة للخطأ. استخدم دائمًا زر النسخ أو الماسح الضوئي QR."),
    "unableToDecode" : MessageLookupByLibrary.simpleMessage("غير قادر على فك شفرة"),
    "unitTestBeforeCreatingWallets" : MessageLookupByLibrary.simpleMessage("اختبار وحدة قبل إنشاء محافظ"),
    "unitTestFailure" : MessageLookupByLibrary.simpleMessage("فشل اختبار الوحدة"),
    "unknown" : MessageLookupByLibrary.simpleMessage("مجهول"),
    "unknownAddress" : MessageLookupByLibrary.simpleMessage("عنوان غير معروف"),
    "unknownQuery" : MessageLookupByLibrary.simpleMessage("استعلام غير معروف"),
    "unlock" : MessageLookupByLibrary.simpleMessage("الغاء القفل"),
    "unlockTitle" : MessageLookupByLibrary.simpleMessage("فتح كروزل"),
    "url" : MessageLookupByLibrary.simpleMessage("موقع المعلومات العالمي"),
    "valueMustBePositive" : MessageLookupByLibrary.simpleMessage("يجب أن تكون القيمة إيجابية"),
    "verify" : MessageLookupByLibrary.simpleMessage("تحقق"),
    "verifyAddressFailed" : m35,
    "verifyKeyPairsEveryLoad" : MessageLookupByLibrary.simpleMessage("تحقق من أزواج المفاتيح كل حمولة"),
    "verifyWalletResults" : m36,
    "verifying" : MessageLookupByLibrary.simpleMessage("التحقق من ..."),
    "version" : MessageLookupByLibrary.simpleMessage("الإصدار"),
    "walletAccountName" : m37,
    "wallets" : MessageLookupByLibrary.simpleMessage("محافظ"),
    "warning" : MessageLookupByLibrary.simpleMessage("تحذير"),
    "watchOnlyWallet" : MessageLookupByLibrary.simpleMessage("مشاهدة فقط المحفظة"),
    "welcomeDesc" : MessageLookupByLibrary.simpleMessage("للبدء ، أنشئ محفظة:"),
    "welcomeTitle" : MessageLookupByLibrary.simpleMessage("مرحبا بكم في Cruzall")
  };
}
