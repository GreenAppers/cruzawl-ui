// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ja locale. All the
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
  String get localeName => 'ja';

  static m0(address) => "アドレス${address}";

  static m1(height) => "ブロックの高さ{@<a>} ${height} {@</a>}での残高は次のとおりです。";

  static m2(height) => "高さ${height}成熟するバランスは次のとおりです。";

  static m3(ticker, balance) => "${ticker} + ${balance}";

  static m4(algorithm) => "作成しています...（ ${algorithm} ）";

  static m5(days) => "${Intl.plural(days, one: '日', other: '${days}日')}";

  static m6(exaHashPerSecond) => "${exaHashPerSecond} EH / s";

  static m7(address) => "From： ${address}";

  static m8(gigaHashPerSecond) => "${gigaHashPerSecond} GH / s";

  static m9(hashPerSecond) => "${hashPerSecond} H / s";

  static m10(height) => "height = {@<a>} ${height} {@</a>}";

  static m11(product) => "${product}ホームページ";

  static m12(hours) => "${Intl.plural(hours, one: '時', other: '${hours}時間')}";

  static m13(kiloHashPerSecond) => "${kiloHashPerSecond} KH / s";

  static m14(item1, item2, item3, item4) => "${item1} 、 ${item2} 、 ${item3} 、 ${item4}";

  static m15(item1, item2, item3) => "${item1} 、 ${item2} 、 ${item3}";

  static m16(item1, item2) => "${item1} 、 ${item2}";

  static m17(cap) => "時価総額{@<a>} ${cap} {@</a>}";

  static m18(megaHashPerSecond) => "${megaHashPerSecond} MH / s";

  static m19(item) => "[ {@<a>} ${item} {@</a>} ]";

  static m20(item1, item2) => "[ {@<a1>} ${item1} {@</a1>} 、 {@<a2>} ${item2} {@</a2>} ]";

  static m21(amount) => "最小金額は${amount}";

  static m22(fee) => "最低料金は${fee}";

  static m23(minutes, seconds) => "${minutes} ${seconds}";

  static m24(minutes) => "${Intl.plural(minutes, one: '${minutes}分', other: '${minutes}分')}";

  static m25(type) => "${type}ネットワーク";

  static m26(number) => "トランザクション（ ${number} ）";

  static m27(petaHashPerSecond) => "${petaHashPerSecond} PH / s";

  static m28(seconds) => "${Intl.plural(seconds, one: '${seconds}秒', other: '${seconds}秒')}";

  static m29(transactionId) => "${transactionId}送信しました";

  static m30(teraHashPerSecond) => "${teraHashPerSecond} TH / s";

  static m31(address) => "宛先： ${address}";

  static m32(totalBlocks, duration) => "${totalBlocks} {@<a1>}ブロック{@</a1>}最後の{@<a2>} ${duration} {@</a2>}";

  static m33(totalBlocks, totalTransactions, duration) => "${totalBlocks} {@<a1>}blocks{@</a1>}、最後の{@<a2>} ${duration} {@</a2>}の${totalTransactions}トランザクション";

  static m34(addressText) => "検証に失敗しました： ${addressText}";

  static m35(goodAddresses, totalAddresses, goodTests, totalTests) => "検証済みの${goodAddresses} / ${totalAddresses}アドレスと${goodTests} / ${totalTests}テストが成功しました";

  static m36(walletName, accountId, chainIndex) => "${walletName}：アカウント${accountId}、アドレス${chainIndex}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "account" : MessageLookupByLibrary.simpleMessage("アカウント"),
    "accounts" : MessageLookupByLibrary.simpleMessage("アカウント"),
    "activeTransactions" : MessageLookupByLibrary.simpleMessage("アクティブなトランザクション"),
    "addWallet" : MessageLookupByLibrary.simpleMessage("ウォレットを追加"),
    "address" : MessageLookupByLibrary.simpleMessage("住所"),
    "addressMustBeUnique" : MessageLookupByLibrary.simpleMessage("アドレスは一意でなければなりません。"),
    "addressStateOpen" : MessageLookupByLibrary.simpleMessage("開いた"),
    "addressStateReserve" : MessageLookupByLibrary.simpleMessage("予備"),
    "addressStateUsed" : MessageLookupByLibrary.simpleMessage("中古"),
    "addressTitle" : m0,
    "addresses" : MessageLookupByLibrary.simpleMessage("住所"),
    "amount" : MessageLookupByLibrary.simpleMessage("量"),
    "backupKeysWarning" : MessageLookupByLibrary.simpleMessage("キーは外部ストレージにバックアップする必要があります。"),
    "balance" : MessageLookupByLibrary.simpleMessage("バランス"),
    "balanceAtHeightIs" : m1,
    "balanceMaturingByHeightIs" : m2,
    "balanceTitle" : m3,
    "block" : MessageLookupByLibrary.simpleMessage("ブロック"),
    "blocks" : MessageLookupByLibrary.simpleMessage("ブロック"),
    "cancel" : MessageLookupByLibrary.simpleMessage("キャンセル"),
    "cantDeleteOnlyWallet" : MessageLookupByLibrary.simpleMessage("唯一のウォレットを削除することはできません。"),
    "chainCode" : MessageLookupByLibrary.simpleMessage("チェーンコード"),
    "chainIndex" : MessageLookupByLibrary.simpleMessage("チェーンインデックス"),
    "chainWork" : MessageLookupByLibrary.simpleMessage("チェーンワーク"),
    "confirmPassword" : MessageLookupByLibrary.simpleMessage("パスワードを認証する"),
    "confirmations" : MessageLookupByLibrary.simpleMessage("確認"),
    "connected" : MessageLookupByLibrary.simpleMessage("接続済み"),
    "console" : MessageLookupByLibrary.simpleMessage("コンソール"),
    "contacts" : MessageLookupByLibrary.simpleMessage("連絡先"),
    "copied" : MessageLookupByLibrary.simpleMessage("コピーしました。"),
    "copy" : MessageLookupByLibrary.simpleMessage("コピー"),
    "copyAddresses" : MessageLookupByLibrary.simpleMessage("住所のコピー"),
    "copyPublicKeys" : MessageLookupByLibrary.simpleMessage("公開鍵をコピーする"),
    "create" : MessageLookupByLibrary.simpleMessage("作成する"),
    "creating" : MessageLookupByLibrary.simpleMessage("作成..."),
    "creatingUsingAlgorithm" : m4,
    "cruzTicker" : MessageLookupByLibrary.simpleMessage("クルス"),
    "currency" : MessageLookupByLibrary.simpleMessage("通貨"),
    "currentBalanceIs" : MessageLookupByLibrary.simpleMessage("現在の残高は次のとおりです。"),
    "dangerZone" : MessageLookupByLibrary.simpleMessage("危険区域"),
    "date" : MessageLookupByLibrary.simpleMessage("日付"),
    "daysDuration" : m5,
    "debugLog" : MessageLookupByLibrary.simpleMessage("デバッグログ"),
    "defaultWalletName" : MessageLookupByLibrary.simpleMessage("私の財布"),
    "delete" : MessageLookupByLibrary.simpleMessage("削除する"),
    "deletePeer" : MessageLookupByLibrary.simpleMessage("ピアを削除"),
    "deleteThisWallet" : MessageLookupByLibrary.simpleMessage("このウォレットを削除"),
    "deleteWallet" : MessageLookupByLibrary.simpleMessage("ウォレットを削除"),
    "deleteWalletDescription" : MessageLookupByLibrary.simpleMessage("ウォレットを削除すると、元に戻すことはできません。確実にしてください。"),
    "deltaHashPower" : MessageLookupByLibrary.simpleMessage("デルタハッシュパワー"),
    "deltaTime" : MessageLookupByLibrary.simpleMessage("デルタ時間"),
    "donations" : MessageLookupByLibrary.simpleMessage("寄付"),
    "duration" : MessageLookupByLibrary.simpleMessage("期間"),
    "earliestSeen" : MessageLookupByLibrary.simpleMessage("最古"),
    "email" : MessageLookupByLibrary.simpleMessage("Eメール"),
    "encrypt" : MessageLookupByLibrary.simpleMessage("暗号化"),
    "encryption" : MessageLookupByLibrary.simpleMessage("暗号化"),
    "exaHashPerSecond" : m6,
    "expired" : MessageLookupByLibrary.simpleMessage("期限切れ"),
    "expires" : MessageLookupByLibrary.simpleMessage("期限切れ"),
    "externalAddress" : MessageLookupByLibrary.simpleMessage("外部住所"),
    "fee" : MessageLookupByLibrary.simpleMessage("費用"),
    "from" : MessageLookupByLibrary.simpleMessage("から"),
    "fromAddress" : m7,
    "generateNewAddress" : MessageLookupByLibrary.simpleMessage("新しい住所を生成"),
    "gigaHashPerSecond" : m8,
    "hashPerSecond" : m9,
    "hashRoot" : MessageLookupByLibrary.simpleMessage("ハッシュルート"),
    "hdWallet" : MessageLookupByLibrary.simpleMessage("HDウォレット"),
    "hdWalletAlgorithm" : MessageLookupByLibrary.simpleMessage("PBKDF：2048反復"),
    "height" : MessageLookupByLibrary.simpleMessage("高さ"),
    "heightEquals" : m10,
    "hide" : MessageLookupByLibrary.simpleMessage("隠す"),
    "home" : MessageLookupByLibrary.simpleMessage("ホーム"),
    "homePage" : m11,
    "hoursDuration" : m12,
    "id" : MessageLookupByLibrary.simpleMessage("Id"),
    "ignore" : MessageLookupByLibrary.simpleMessage("無視する"),
    "insecureDeviceWarning" : MessageLookupByLibrary.simpleMessage("安全でないデバイスの警告"),
    "insecureDeviceWarningDescription" : MessageLookupByLibrary.simpleMessage("根ざしたデバイスまたはジェイルブレイクされたデバイスが検出されました。それ以上の使用は推奨されません。"),
    "insufficientFunds" : MessageLookupByLibrary.simpleMessage("残高不足"),
    "invalidAddress" : MessageLookupByLibrary.simpleMessage("無効なアドレス"),
    "invalidCurrency" : MessageLookupByLibrary.simpleMessage("通貨が無効です"),
    "invalidJson" : MessageLookupByLibrary.simpleMessage("無効なJSON。"),
    "invalidMnemonic" : MessageLookupByLibrary.simpleMessage("無効なニーモニック"),
    "invalidPrivateKey" : MessageLookupByLibrary.simpleMessage("秘密鍵が無効です。"),
    "invalidPublicKey" : MessageLookupByLibrary.simpleMessage("公開鍵が無効です。"),
    "invalidUrl" : MessageLookupByLibrary.simpleMessage("無効なURL。"),
    "kiloHashPerSecond" : m13,
    "language" : MessageLookupByLibrary.simpleMessage("言語"),
    "latestSeen" : MessageLookupByLibrary.simpleMessage("最新の見た"),
    "license" : MessageLookupByLibrary.simpleMessage("ライセンス"),
    "listOfFour" : m14,
    "listOfThree" : m15,
    "listOfTwo" : m16,
    "loading" : MessageLookupByLibrary.simpleMessage("読み込み中..."),
    "localeLanguage" : MessageLookupByLibrary.simpleMessage("日本語"),
    "marketCap" : m17,
    "matured" : MessageLookupByLibrary.simpleMessage("成熟した"),
    "matures" : MessageLookupByLibrary.simpleMessage("成熟"),
    "maturing" : MessageLookupByLibrary.simpleMessage("熟成"),
    "maturingTransactions" : MessageLookupByLibrary.simpleMessage("トランザクションの成熟"),
    "maxMemoLength" : MessageLookupByLibrary.simpleMessage("最大メモ長は100です"),
    "megaHashPerSecond" : m18,
    "memo" : MessageLookupByLibrary.simpleMessage("メモ"),
    "menuOfOne" : m19,
    "menuOfTwo" : m20,
    "minAmount" : m21,
    "minFee" : m22,
    "minutesAndSecondsDuration" : m23,
    "minutesDuration" : m24,
    "name" : MessageLookupByLibrary.simpleMessage("名"),
    "nameMustBeUnique" : MessageLookupByLibrary.simpleMessage("名前は一意である必要があります。"),
    "network" : MessageLookupByLibrary.simpleMessage("ネットワーク"),
    "networkOffline" : MessageLookupByLibrary.simpleMessage("ネットワークオフライン"),
    "networkType" : m25,
    "newContact" : MessageLookupByLibrary.simpleMessage("新しい連絡先"),
    "newPeer" : MessageLookupByLibrary.simpleMessage("ニューピア"),
    "newWallet" : MessageLookupByLibrary.simpleMessage("新しいウォレット"),
    "next" : MessageLookupByLibrary.simpleMessage("次"),
    "noPrivateKeys" : MessageLookupByLibrary.simpleMessage("秘密鍵なし"),
    "noPublicKeys" : MessageLookupByLibrary.simpleMessage("公開鍵なし"),
    "nonce" : MessageLookupByLibrary.simpleMessage("ノンス"),
    "numTransactions" : m26,
    "ok" : MessageLookupByLibrary.simpleMessage("OK"),
    "password" : MessageLookupByLibrary.simpleMessage("パスワード"),
    "passwordCantBeEmpty" : MessageLookupByLibrary.simpleMessage("パスワードを空にすることはできません。"),
    "passwordsDontMatch" : MessageLookupByLibrary.simpleMessage("パスワードが一致しません。"),
    "paste" : MessageLookupByLibrary.simpleMessage("ペースト"),
    "payTo" : MessageLookupByLibrary.simpleMessage("に支払います"),
    "peers" : MessageLookupByLibrary.simpleMessage("仲間"),
    "pending" : MessageLookupByLibrary.simpleMessage("保留中"),
    "petaHashPerSecond" : m27,
    "previous" : MessageLookupByLibrary.simpleMessage("前"),
    "privacyPolicy" : MessageLookupByLibrary.simpleMessage("個人情報保護方針"),
    "privateKey" : MessageLookupByLibrary.simpleMessage("秘密鍵"),
    "privateKeyList" : MessageLookupByLibrary.simpleMessage("秘密鍵リスト"),
    "publicKeyList" : MessageLookupByLibrary.simpleMessage("公開鍵リスト"),
    "receive" : MessageLookupByLibrary.simpleMessage("受け取る"),
    "recentHistory" : MessageLookupByLibrary.simpleMessage("近年の歴史"),
    "requireSSLCert" : MessageLookupByLibrary.simpleMessage("SSL証明書が必要"),
    "result" : MessageLookupByLibrary.simpleMessage("結果"),
    "search" : MessageLookupByLibrary.simpleMessage("サーチ"),
    "secondsDuration" : m28,
    "seedPhrase" : MessageLookupByLibrary.simpleMessage("シードフレーズ"),
    "seedPhraseWarning" : MessageLookupByLibrary.simpleMessage("このシードにより、それを知っている誰でもあなたの財布からのすべての資金を使うことができます。それを書き留め。安全保持。"),
    "send" : MessageLookupByLibrary.simpleMessage("送る"),
    "sendFailed" : MessageLookupByLibrary.simpleMessage("送信に失敗しました"),
    "sending" : MessageLookupByLibrary.simpleMessage("送信..."),
    "sentTransactionId" : m29,
    "settings" : MessageLookupByLibrary.simpleMessage("設定"),
    "show" : MessageLookupByLibrary.simpleMessage("ショー"),
    "showWalletNameInTitle" : MessageLookupByLibrary.simpleMessage("タイトルにウォレット名を表示"),
    "state" : MessageLookupByLibrary.simpleMessage("状態"),
    "submit" : MessageLookupByLibrary.simpleMessage("提出する"),
    "support" : MessageLookupByLibrary.simpleMessage("サポート"),
    "target" : MessageLookupByLibrary.simpleMessage("ターゲット"),
    "teraHashPerSecond" : m30,
    "thanksForDonating" : MessageLookupByLibrary.simpleMessage("右に！ CRUZコミュニティに感謝します！"),
    "theme" : MessageLookupByLibrary.simpleMessage("テーマ"),
    "time" : MessageLookupByLibrary.simpleMessage("時間"),
    "tip" : MessageLookupByLibrary.simpleMessage("先端"),
    "title" : MessageLookupByLibrary.simpleMessage("クルザール"),
    "to" : MessageLookupByLibrary.simpleMessage("に"),
    "toAddress" : m31,
    "totalBlocksInLastDuration" : m32,
    "totalBlocksTransactionsInLastDuration" : m33,
    "transaction" : MessageLookupByLibrary.simpleMessage("トランザクション"),
    "transactions" : MessageLookupByLibrary.simpleMessage("取引"),
    "typingAddressesWarning" : MessageLookupByLibrary.simpleMessage("警告：手動でアドレスを入力することは危険であり、エラーが発生しやすくなります。 常にコピーボタンまたはQRスキャナーを使用してください。"),
    "unitTestBeforeCreatingWallets" : MessageLookupByLibrary.simpleMessage("ウォレットを作成する前の単体テスト"),
    "unitTestFailure" : MessageLookupByLibrary.simpleMessage("単体テストの失敗"),
    "unknown" : MessageLookupByLibrary.simpleMessage("道の"),
    "unknownAddress" : MessageLookupByLibrary.simpleMessage("不明な住所"),
    "unknownQuery" : MessageLookupByLibrary.simpleMessage("不明なクエリ"),
    "unlock" : MessageLookupByLibrary.simpleMessage("ロック解除"),
    "unlockTitle" : MessageLookupByLibrary.simpleMessage("Cruzallのロックを解除"),
    "url" : MessageLookupByLibrary.simpleMessage("URL"),
    "valueMustBePositive" : MessageLookupByLibrary.simpleMessage("値は正でなければなりません"),
    "verify" : MessageLookupByLibrary.simpleMessage("確認する"),
    "verifyAddressFailed" : m34,
    "verifyKeyPairsEveryLoad" : MessageLookupByLibrary.simpleMessage("ロードごとにキーペアを確認する"),
    "verifyWalletResults" : m35,
    "verifying" : MessageLookupByLibrary.simpleMessage("確認しています..."),
    "version" : MessageLookupByLibrary.simpleMessage("バージョン"),
    "walletAccountName" : m36,
    "wallets" : MessageLookupByLibrary.simpleMessage("財布"),
    "warning" : MessageLookupByLibrary.simpleMessage("警告"),
    "watchOnlyWallet" : MessageLookupByLibrary.simpleMessage("時計専用ウォレット"),
    "welcomeDesc" : MessageLookupByLibrary.simpleMessage("開始するには、ウォレットを作成します。"),
    "welcomeTitle" : MessageLookupByLibrary.simpleMessage("クルザールへようこそ")
  };
}
