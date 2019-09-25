// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a he locale. All the
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
  String get localeName => 'he';

  static m0(address) => "כתובת ${address}";

  static m1(height) => "היתרה שלך בגובה הבלוק {@<a>} ${height} {@</a>} היא:";

  static m2(height) => "היתרה שלך שמתבגרת לפי גובה ${height} היא:";

  static m3(ticker, balance) => "${ticker} + ${balance}";

  static m4(algorithm) => "יוצר ... ( ${algorithm} )";

  static m5(days) => "${Intl.plural(days, one: 'יום', other: '${days} ימים')}";

  static m6(exaHashPerSecond) => "${exaHashPerSecond} EH / s";

  static m7(address) => "מאת: ${address}";

  static m8(gigaHashPerSecond) => "${gigaHashPerSecond} GH / s";

  static m9(hashPerSecond) => "${hashPerSecond} H / s";

  static m10(height) => "גובה = {@<a>} ${height} {@</a>}";

  static m11(product) => "${product} דף הבית";

  static m12(hours) => "${Intl.plural(hours, one: 'שעה', other: '${hours} שעות')}";

  static m13(kiloHashPerSecond) => "${kiloHashPerSecond} KH / s";

  static m14(item1, item2, item3, item4) => "${item1} , ${item2} , ${item3} , ${item4}";

  static m15(item1, item2, item3) => "${item1} , ${item2} , ${item3}";

  static m16(item1, item2) => "${item1} , ${item2}";

  static m17(cap) => "שווי שוק {@<a>} ${cap} {@</a>}";

  static m18(megaHashPerSecond) => "${megaHashPerSecond} MH / s";

  static m19(item) => "[ {@<a>} ${item} {@</a>} ]";

  static m20(item1, item2) => "[ {@<a1>} ${item1} {@</a1>} , {@<a2>} ${item2} {@</a2>} ]";

  static m21(amount) => "הסכום המינימלי הוא ${amount}";

  static m22(fee) => "עמלה מינימלית היא ${fee}";

  static m23(minutes, seconds) => "${minutes} ${seconds}";

  static m24(minutes) => "${Intl.plural(minutes, one: '${minutes} דקה', other: '${minutes} דקות')}";

  static m25(type) => "${type} רשת";

  static m26(number) => "עסקאות ( ${number} )";

  static m27(petaHashPerSecond) => "${petaHashPerSecond} PH / s";

  static m28(seconds) => "${Intl.plural(seconds, one: '${seconds} שניה', other: '${seconds} שניות')}";

  static m29(transactionId) => "נשלח ${transactionId}";

  static m30(teraHashPerSecond) => "${teraHashPerSecond} TH / s";

  static m31(address) => "אל: ${address}";

  static m32(totalBlocks, duration) => "${totalBlocks} {@<a1>} חוסם {@</a1>} {@<a2>} ${duration} {@</a2>}";

  static m33(totalBlocks, totalTransactions, duration) => "${totalBlocks} {@<a1>} חוסם {@</a1>} , ${totalTransactions} עסקאות ב {@<a2>} ${duration} {@</a2>}";

  static m34(addressText) => "האימות נכשל: ${addressText}";

  static m35(goodAddresses, totalAddresses, goodTests, totalTests) => "דילים ${goodAddresses} / ${totalAddresses} כתובות ${goodTests} / ${totalTests} מבחנים הצליח";

  static m36(walletName, accountId, chainIndex) => "${walletName} : חשבון ${accountId} , כתובת ${chainIndex}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "account" : MessageLookupByLibrary.simpleMessage("חשבון"),
    "accounts" : MessageLookupByLibrary.simpleMessage("חשבונות"),
    "activeTransactions" : MessageLookupByLibrary.simpleMessage("עסקאות אקטיביות"),
    "addWallet" : MessageLookupByLibrary.simpleMessage("הוסף ארנק"),
    "address" : MessageLookupByLibrary.simpleMessage("כתובת"),
    "addressMustBeUnique" : MessageLookupByLibrary.simpleMessage("הכתובת חייבת להיות ייחודית."),
    "addressStateOpen" : MessageLookupByLibrary.simpleMessage("פתוח"),
    "addressStateReserve" : MessageLookupByLibrary.simpleMessage("מילואים"),
    "addressStateUsed" : MessageLookupByLibrary.simpleMessage("בשימוש"),
    "addressTitle" : m0,
    "addresses" : MessageLookupByLibrary.simpleMessage("כתובות"),
    "amount" : MessageLookupByLibrary.simpleMessage("כמות"),
    "backupKeysWarning" : MessageLookupByLibrary.simpleMessage("יש לגבות את המפתחות שלך באחסון חיצוני."),
    "balance" : MessageLookupByLibrary.simpleMessage("איזון"),
    "balanceAtHeightIs" : m1,
    "balanceMaturingByHeightIs" : m2,
    "balanceTitle" : m3,
    "block" : MessageLookupByLibrary.simpleMessage("חסום"),
    "blocks" : MessageLookupByLibrary.simpleMessage("חסימות"),
    "cancel" : MessageLookupByLibrary.simpleMessage("בטל"),
    "cantDeleteOnlyWallet" : MessageLookupByLibrary.simpleMessage("לא ניתן למחוק את הארנק היחיד."),
    "chainCode" : MessageLookupByLibrary.simpleMessage("קוד שרשרת"),
    "chainIndex" : MessageLookupByLibrary.simpleMessage("מדד שרשרת"),
    "chainWork" : MessageLookupByLibrary.simpleMessage("עבודת שרשרת"),
    "confirmPassword" : MessageLookupByLibrary.simpleMessage("אשר סיסמה"),
    "confirmations" : MessageLookupByLibrary.simpleMessage("אישורים"),
    "connected" : MessageLookupByLibrary.simpleMessage("מחובר"),
    "console" : MessageLookupByLibrary.simpleMessage("קונסולה"),
    "contacts" : MessageLookupByLibrary.simpleMessage("אנשי קשר"),
    "copied" : MessageLookupByLibrary.simpleMessage("הועתק."),
    "copy" : MessageLookupByLibrary.simpleMessage("עותק"),
    "copyPublicKeys" : MessageLookupByLibrary.simpleMessage("העתק מפתחות ציבוריים"),
    "create" : MessageLookupByLibrary.simpleMessage("צור"),
    "creating" : MessageLookupByLibrary.simpleMessage("יוצר ..."),
    "creatingUsingAlgorithm" : m4,
    "cruzTicker" : MessageLookupByLibrary.simpleMessage("CRUZ"),
    "currency" : MessageLookupByLibrary.simpleMessage("מטבע"),
    "currentBalanceIs" : MessageLookupByLibrary.simpleMessage("היתרה הנוכחית שלך היא:"),
    "dangerZone" : MessageLookupByLibrary.simpleMessage("אזור סכנה"),
    "date" : MessageLookupByLibrary.simpleMessage("תאריך"),
    "daysDuration" : m5,
    "debugLog" : MessageLookupByLibrary.simpleMessage("יומן באגים"),
    "defaultWalletName" : MessageLookupByLibrary.simpleMessage("הארנק שלי"),
    "delete" : MessageLookupByLibrary.simpleMessage("מחק"),
    "deletePeer" : MessageLookupByLibrary.simpleMessage("מחק את עמית"),
    "deleteThisWallet" : MessageLookupByLibrary.simpleMessage("מחק את הארנק הזה"),
    "deleteWallet" : MessageLookupByLibrary.simpleMessage("מחק את הארנק"),
    "deleteWalletDescription" : MessageLookupByLibrary.simpleMessage("ברגע שאתה מוחק ארנק, אין חזרה. אנא וודאו."),
    "deltaHashPower" : MessageLookupByLibrary.simpleMessage("כוח הדלתא האש"),
    "deltaTime" : MessageLookupByLibrary.simpleMessage("זמן דלתא"),
    "donations" : MessageLookupByLibrary.simpleMessage("תרומות"),
    "duration" : MessageLookupByLibrary.simpleMessage("משך הזמן"),
    "earliestSeen" : MessageLookupByLibrary.simpleMessage("נראה הכי מוקדם"),
    "email" : MessageLookupByLibrary.simpleMessage("אימייל"),
    "encrypt" : MessageLookupByLibrary.simpleMessage("הצפן"),
    "encryption" : MessageLookupByLibrary.simpleMessage("הצפנה"),
    "exaHashPerSecond" : m6,
    "expired" : MessageLookupByLibrary.simpleMessage("לא בתוקף"),
    "expires" : MessageLookupByLibrary.simpleMessage("פג תוקף"),
    "externalAddress" : MessageLookupByLibrary.simpleMessage("כתובת חיצונית"),
    "fee" : MessageLookupByLibrary.simpleMessage("תשלום"),
    "from" : MessageLookupByLibrary.simpleMessage("מ"),
    "fromAddress" : m7,
    "generateNewAddress" : MessageLookupByLibrary.simpleMessage("צור כתובת חדשה"),
    "gigaHashPerSecond" : m8,
    "hashListRoot" : MessageLookupByLibrary.simpleMessage("רשימת השורש"),
    "hashPerSecond" : m9,
    "hdWallet" : MessageLookupByLibrary.simpleMessage("ארנק HD"),
    "hdWalletAlgorithm" : MessageLookupByLibrary.simpleMessage("PBKDF: איטרציות של 2048"),
    "height" : MessageLookupByLibrary.simpleMessage("גובה"),
    "heightEquals" : m10,
    "hide" : MessageLookupByLibrary.simpleMessage("להתחבא"),
    "home" : MessageLookupByLibrary.simpleMessage("בית"),
    "homePage" : m11,
    "hoursDuration" : m12,
    "id" : MessageLookupByLibrary.simpleMessage("מזהה"),
    "ignore" : MessageLookupByLibrary.simpleMessage("להתעלם"),
    "insecureDeviceWarning" : MessageLookupByLibrary.simpleMessage("אזהרת מכשירים לא בטוחים"),
    "insecureDeviceWarningDescription" : MessageLookupByLibrary.simpleMessage("התגלה התקן מושרש או שבור בכלא. שימוש נוסף אינו מומלץ."),
    "insufficientFunds" : MessageLookupByLibrary.simpleMessage("אין די כספים"),
    "invalidAddress" : MessageLookupByLibrary.simpleMessage("כתובת לא חוקית"),
    "invalidCurrency" : MessageLookupByLibrary.simpleMessage("מטבע לא חוקי"),
    "invalidJson" : MessageLookupByLibrary.simpleMessage("JSON לא חוקי."),
    "invalidMnemonic" : MessageLookupByLibrary.simpleMessage("ממנומוני לא חוקי"),
    "invalidPrivateKey" : MessageLookupByLibrary.simpleMessage("מפתח פרטי לא חוקי."),
    "invalidPublicKey" : MessageLookupByLibrary.simpleMessage("מפתח ציבורי לא חוקי."),
    "invalidUrl" : MessageLookupByLibrary.simpleMessage("כתובת אתר לא חוקית."),
    "kiloHashPerSecond" : m13,
    "language" : MessageLookupByLibrary.simpleMessage("שפה"),
    "latestSeen" : MessageLookupByLibrary.simpleMessage("נראה לאחרונה"),
    "license" : MessageLookupByLibrary.simpleMessage("רישיון"),
    "listOfFour" : m14,
    "listOfThree" : m15,
    "listOfTwo" : m16,
    "loading" : MessageLookupByLibrary.simpleMessage("טוען..."),
    "localeLanguage" : MessageLookupByLibrary.simpleMessage("עברית"),
    "marketCap" : m17,
    "matured" : MessageLookupByLibrary.simpleMessage("התבגר"),
    "matures" : MessageLookupByLibrary.simpleMessage("מתבגר"),
    "maturing" : MessageLookupByLibrary.simpleMessage("התבגרות"),
    "maturingTransactions" : MessageLookupByLibrary.simpleMessage("עסקאות לפדיון"),
    "maxMemoLength" : MessageLookupByLibrary.simpleMessage("אורך התזכר המרבי הוא 100"),
    "megaHashPerSecond" : m18,
    "memo" : MessageLookupByLibrary.simpleMessage("תזכיר"),
    "menuOfOne" : m19,
    "menuOfTwo" : m20,
    "minAmount" : m21,
    "minFee" : m22,
    "minutesAndSecondsDuration" : m23,
    "minutesDuration" : m24,
    "name" : MessageLookupByLibrary.simpleMessage("שם"),
    "nameMustBeUnique" : MessageLookupByLibrary.simpleMessage("השם חייב להיות ייחודי."),
    "network" : MessageLookupByLibrary.simpleMessage("רשת"),
    "networkOffline" : MessageLookupByLibrary.simpleMessage("רשת במצב לא מקוון"),
    "networkType" : m25,
    "newContact" : MessageLookupByLibrary.simpleMessage("איש קשר חדש"),
    "newPeer" : MessageLookupByLibrary.simpleMessage("פרי חדש"),
    "newWallet" : MessageLookupByLibrary.simpleMessage("ארנק חדש"),
    "next" : MessageLookupByLibrary.simpleMessage("הבא"),
    "noPrivateKeys" : MessageLookupByLibrary.simpleMessage("אין מפתחות פרטיים"),
    "noPublicKeys" : MessageLookupByLibrary.simpleMessage("אין מפתחות ציבוריים"),
    "nonce" : MessageLookupByLibrary.simpleMessage("נון"),
    "numTransactions" : m26,
    "ok" : MessageLookupByLibrary.simpleMessage("בסדר"),
    "password" : MessageLookupByLibrary.simpleMessage("סיסמה"),
    "passwordCantBeEmpty" : MessageLookupByLibrary.simpleMessage("הסיסמה לא יכולה להיות ריקה."),
    "passwordsDontMatch" : MessageLookupByLibrary.simpleMessage("סיסמאות אינן תואמות."),
    "paste" : MessageLookupByLibrary.simpleMessage("הדבק"),
    "payTo" : MessageLookupByLibrary.simpleMessage("לשלם ל"),
    "peers" : MessageLookupByLibrary.simpleMessage("עמיתים"),
    "pending" : MessageLookupByLibrary.simpleMessage("ממתין ל"),
    "petaHashPerSecond" : m27,
    "previous" : MessageLookupByLibrary.simpleMessage("קודם"),
    "privacyPolicy" : MessageLookupByLibrary.simpleMessage("מדיניות פרטיות"),
    "privateKey" : MessageLookupByLibrary.simpleMessage("מפתח פרטי"),
    "privateKeyList" : MessageLookupByLibrary.simpleMessage("רשימת מפתחות פרטית"),
    "publicKeyList" : MessageLookupByLibrary.simpleMessage("רשימת מפתחות ציבורית"),
    "receive" : MessageLookupByLibrary.simpleMessage("לקבל"),
    "recentHistory" : MessageLookupByLibrary.simpleMessage("היסטוריה אחרונה"),
    "requireSSLCert" : MessageLookupByLibrary.simpleMessage("דרוש אישור SSL"),
    "result" : MessageLookupByLibrary.simpleMessage("תוצאה"),
    "search" : MessageLookupByLibrary.simpleMessage("לחפש"),
    "secondsDuration" : m28,
    "seedPhrase" : MessageLookupByLibrary.simpleMessage("ביטוי זרע"),
    "seedPhraseWarning" : MessageLookupByLibrary.simpleMessage("זרע זה מאפשר לכל מי שיודע אותו להוציא את כל הכספים מהארנק שלך. תרשום את זה. שמור על זה בטוח."),
    "send" : MessageLookupByLibrary.simpleMessage("שלח"),
    "sendFailed" : MessageLookupByLibrary.simpleMessage("שליחה נכשלה"),
    "sending" : MessageLookupByLibrary.simpleMessage("שולח ..."),
    "sentTransactionId" : m29,
    "settings" : MessageLookupByLibrary.simpleMessage("הגדרות"),
    "show" : MessageLookupByLibrary.simpleMessage("הופעה"),
    "showWalletNameInTitle" : MessageLookupByLibrary.simpleMessage("הצג את שם הארנק בכותרת"),
    "state" : MessageLookupByLibrary.simpleMessage("מדינה"),
    "submit" : MessageLookupByLibrary.simpleMessage("שלח"),
    "support" : MessageLookupByLibrary.simpleMessage("תמיכה"),
    "target" : MessageLookupByLibrary.simpleMessage("יעד"),
    "teraHashPerSecond" : m30,
    "thanksForDonating" : MessageLookupByLibrary.simpleMessage("ממש ב! תודה קהילת CRUZ!"),
    "theme" : MessageLookupByLibrary.simpleMessage("נושא"),
    "time" : MessageLookupByLibrary.simpleMessage("זמן"),
    "tip" : MessageLookupByLibrary.simpleMessage("טיפ"),
    "title" : MessageLookupByLibrary.simpleMessage("קרוזל"),
    "to" : MessageLookupByLibrary.simpleMessage("ל"),
    "toAddress" : m31,
    "totalBlocksInLastDuration" : m32,
    "totalBlocksTransactionsInLastDuration" : m33,
    "transaction" : MessageLookupByLibrary.simpleMessage("עסקה"),
    "transactions" : MessageLookupByLibrary.simpleMessage("עסקאות"),
    "typingAddressesWarning" : MessageLookupByLibrary.simpleMessage("אזהרה: הקלדת כתובות ביד מסוכנת ונוטה לשגיאה. השתמש תמיד בכפתור ההעתקה או בסורק ה- QR."),
    "unitTestBeforeCreatingWallets" : MessageLookupByLibrary.simpleMessage("מבחן יחידה לפני יצירת ארנקים"),
    "unitTestFailure" : MessageLookupByLibrary.simpleMessage("כשל במבחן היחידה"),
    "unknown" : MessageLookupByLibrary.simpleMessage("לא ידוע"),
    "unknownAddress" : MessageLookupByLibrary.simpleMessage("כתובת לא ידועה"),
    "unknownQuery" : MessageLookupByLibrary.simpleMessage("שאילתה לא ידועה"),
    "unlock" : MessageLookupByLibrary.simpleMessage("לבטל נעילה"),
    "unlockTitle" : MessageLookupByLibrary.simpleMessage("בטל את נעילת קרוזל"),
    "url" : MessageLookupByLibrary.simpleMessage("כתובת אתר"),
    "valueMustBePositive" : MessageLookupByLibrary.simpleMessage("הערך חייב להיות חיובי"),
    "verify" : MessageLookupByLibrary.simpleMessage("תאשר"),
    "verifyAddressFailed" : m34,
    "verifyKeyPairsEveryLoad" : MessageLookupByLibrary.simpleMessage("אמת את צמדי המפתח בכל עומס"),
    "verifyWalletResults" : m35,
    "verifying" : MessageLookupByLibrary.simpleMessage("מאמת ..."),
    "version" : MessageLookupByLibrary.simpleMessage("גרסה"),
    "walletAccountName" : m36,
    "wallets" : MessageLookupByLibrary.simpleMessage("ארנקים"),
    "warning" : MessageLookupByLibrary.simpleMessage("אזהרה"),
    "watchOnlyWallet" : MessageLookupByLibrary.simpleMessage("ארנק לצפייה בלבד"),
    "welcomeDesc" : MessageLookupByLibrary.simpleMessage("כדי להתחיל, צור ארנק:"),
    "welcomeTitle" : MessageLookupByLibrary.simpleMessage("ברוך הבא לקרוזאל")
  };
}
