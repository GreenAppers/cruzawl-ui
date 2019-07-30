// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
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
  get localeName => 'zh';

  static m0(address) => "地址${address}";

  static m1(height) => "块高{@<a>} ${height} {@</a>}余额为：";

  static m2(height) => "您通过身高${height}成熟的平衡是：";

  static m3(ticker, balance) => "${ticker} + ${balance}";

  static m4(algorithm) => "创建...（ ${algorithm} ）";

  static m5(days) => "${Intl.plural(days, one: '天', other: '${days}天')}";

  static m6(exaHashPerSecond) => "${exaHashPerSecond} EH / s";

  static m7(address) => "来自： ${address}";

  static m8(gigaHashPerSecond) => "${gigaHashPerSecond} GH / s";

  static m9(hashPerSecond) => "${hashPerSecond} H / s";

  static m10(height) => "身高= {@<a>} ${height} {@</a>} ";

  static m11(product) => "${product}主页";

  static m12(hours) => "${Intl.plural(hours, one: '小时', other: '${hours}小时')}";

  static m13(kiloHashPerSecond) => "${kiloHashPerSecond} KH / s";

  static m14(item1, item2, item3) => "${item1} ， ${item2} ， ${item3}";

  static m15(item1, item2) => "${item1} ， ${item2}";

  static m16(megaHashPerSecond) => "${megaHashPerSecond} MH / s";

  static m17(item) => "[ {@<a>} ${item} {@</a>} ]";

  static m18(item1, item2) => "[ {@<a1>} ${item1} {@</a1>} ， {@<a2>} ${item2} {@</a2>} ]";

  static m19(amount) => "最低金额为${amount}";

  static m20(fee) => "最低费用为${fee}";

  static m21(minutes, seconds) => "${minutes} ${seconds}";

  static m22(minutes) => "${Intl.plural(minutes, one: '分钟', other: '${minutes}分钟')}";

  static m23(type) => "${type}网络";

  static m24(number) => "交易（ ${number} ）";

  static m25(petaHashPerSecond) => "${petaHashPerSecond} PH / s";

  static m26(seconds) => "${Intl.plural(seconds, one: '第二', other: '${seconds}秒')}";

  static m27(transactionId) => "已发送${transactionId}";

  static m28(teraHashPerSecond) => "${teraHashPerSecond} TH / s";

  static m29(address) => "要： ${address}";

  static m30(totalBlocks, duration) => "${totalBlocks} {@<a1>}阻止{@</a1>} {@<a2>} ${duration} {@</a2>}";

  static m31(addressText) => "验证失败： ${addressText}";

  static m32(goodAddresses, totalAddresses, goodTests, totalTests) => "已验证的${goodAddresses} / ${totalAddresses}地址和${goodTests} / ${totalTests}测试成功";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "account" : MessageLookupByLibrary.simpleMessage("帐户"),
    "accounts" : MessageLookupByLibrary.simpleMessage("帐号"),
    "activeTransactions" : MessageLookupByLibrary.simpleMessage("活跃的交易"),
    "addWallet" : MessageLookupByLibrary.simpleMessage("添加钱包"),
    "address" : MessageLookupByLibrary.simpleMessage("地址"),
    "addressStateOpen" : MessageLookupByLibrary.simpleMessage("打开"),
    "addressStateReserve" : MessageLookupByLibrary.simpleMessage("保留"),
    "addressStateUsed" : MessageLookupByLibrary.simpleMessage("用过的"),
    "addressTitle" : m0,
    "addresses" : MessageLookupByLibrary.simpleMessage("地址"),
    "amount" : MessageLookupByLibrary.simpleMessage("量"),
    "backupKeysWarning" : MessageLookupByLibrary.simpleMessage("您的密钥必须备份在外部存储上。"),
    "balance" : MessageLookupByLibrary.simpleMessage("平衡"),
    "balanceAtHeightIs" : m1,
    "balanceMaturingByHeightIs" : m2,
    "balanceTitle" : m3,
    "block" : MessageLookupByLibrary.simpleMessage("块"),
    "blocks" : MessageLookupByLibrary.simpleMessage("块"),
    "cancel" : MessageLookupByLibrary.simpleMessage("取消"),
    "cantDeleteOnlyWallet" : MessageLookupByLibrary.simpleMessage("无法删除唯一的钱包。"),
    "chainCode" : MessageLookupByLibrary.simpleMessage("链码"),
    "chainIndex" : MessageLookupByLibrary.simpleMessage("连锁指数"),
    "chainWork" : MessageLookupByLibrary.simpleMessage("连锁工作"),
    "confirmPassword" : MessageLookupByLibrary.simpleMessage("确认密码"),
    "confirmations" : MessageLookupByLibrary.simpleMessage("确认"),
    "copied" : MessageLookupByLibrary.simpleMessage("复制。"),
    "copy" : MessageLookupByLibrary.simpleMessage("复制"),
    "copyPublicKeys" : MessageLookupByLibrary.simpleMessage("复制公钥"),
    "create" : MessageLookupByLibrary.simpleMessage("创建"),
    "creating" : MessageLookupByLibrary.simpleMessage("创建..."),
    "creatingUsingAlgorithm" : m4,
    "cruzTicker" : MessageLookupByLibrary.simpleMessage("CRUZ"),
    "currency" : MessageLookupByLibrary.simpleMessage("货币"),
    "currentBalanceIs" : MessageLookupByLibrary.simpleMessage("您目前的余额是："),
    "dangerZone" : MessageLookupByLibrary.simpleMessage("危险区"),
    "date" : MessageLookupByLibrary.simpleMessage("日期"),
    "daysDuration" : m5,
    "debugLog" : MessageLookupByLibrary.simpleMessage("调试日志"),
    "defaultWalletName" : MessageLookupByLibrary.simpleMessage("我的钱包"),
    "delete" : MessageLookupByLibrary.simpleMessage("删除"),
    "deletePeer" : MessageLookupByLibrary.simpleMessage("删除对等"),
    "deleteThisWallet" : MessageLookupByLibrary.simpleMessage("删除这个钱包"),
    "deleteWallet" : MessageLookupByLibrary.simpleMessage("删除电子钱包"),
    "deleteWalletDescription" : MessageLookupByLibrary.simpleMessage("删除钱包后，就不会再回头了。请确定。"),
    "deltaHashPower" : MessageLookupByLibrary.simpleMessage("哈希权力"),
    "deltaTime" : MessageLookupByLibrary.simpleMessage("达美时间"),
    "earliestSeen" : MessageLookupByLibrary.simpleMessage("最早见过"),
    "email" : MessageLookupByLibrary.simpleMessage("电子邮件"),
    "encrypt" : MessageLookupByLibrary.simpleMessage("加密"),
    "encryption" : MessageLookupByLibrary.simpleMessage("加密"),
    "exaHashPerSecond" : m6,
    "expired" : MessageLookupByLibrary.simpleMessage("过期"),
    "expires" : MessageLookupByLibrary.simpleMessage("过期"),
    "externalAddress" : MessageLookupByLibrary.simpleMessage("外部地址"),
    "fee" : MessageLookupByLibrary.simpleMessage("费用"),
    "from" : MessageLookupByLibrary.simpleMessage("从"),
    "fromAddress" : m7,
    "generateNewAddress" : MessageLookupByLibrary.simpleMessage("生成新地址"),
    "gigaHashPerSecond" : m8,
    "hashListRoot" : MessageLookupByLibrary.simpleMessage("哈希列表根"),
    "hashPerSecond" : m9,
    "hdWallet" : MessageLookupByLibrary.simpleMessage("高清钱包"),
    "hdWalletAlgorithm" : MessageLookupByLibrary.simpleMessage("PBKDF：2048次迭代"),
    "height" : MessageLookupByLibrary.simpleMessage("高度"),
    "heightEquals" : m10,
    "hide" : MessageLookupByLibrary.simpleMessage("隐藏"),
    "homePage" : m11,
    "hoursDuration" : m12,
    "id" : MessageLookupByLibrary.simpleMessage("识别码"),
    "ignore" : MessageLookupByLibrary.simpleMessage("忽视"),
    "insecureDeviceWarning" : MessageLookupByLibrary.simpleMessage("不安全的设备警告"),
    "insecureDeviceWarningDescription" : MessageLookupByLibrary.simpleMessage("已检测到有根或越狱的设备。进一步使用不推荐。"),
    "insufficientFunds" : MessageLookupByLibrary.simpleMessage("不充足的资金"),
    "invalidAddress" : MessageLookupByLibrary.simpleMessage("无效地址"),
    "invalidCurrency" : MessageLookupByLibrary.simpleMessage("货币无效"),
    "invalidMnemonic" : MessageLookupByLibrary.simpleMessage("无效的助记符"),
    "invalidUrl" : MessageLookupByLibrary.simpleMessage("无效的网址。"),
    "kiloHashPerSecond" : m13,
    "language" : MessageLookupByLibrary.simpleMessage("语言"),
    "latestSeen" : MessageLookupByLibrary.simpleMessage("最新见过"),
    "license" : MessageLookupByLibrary.simpleMessage("执照"),
    "listOfThree" : m14,
    "listOfTwo" : m15,
    "loading" : MessageLookupByLibrary.simpleMessage("载入中..."),
    "localeLanguage" : MessageLookupByLibrary.simpleMessage("中文"),
    "matured" : MessageLookupByLibrary.simpleMessage("成熟"),
    "matures" : MessageLookupByLibrary.simpleMessage("成熟"),
    "maturing" : MessageLookupByLibrary.simpleMessage("成熟"),
    "maturingTransactions" : MessageLookupByLibrary.simpleMessage("成熟的交易"),
    "maxMemoLength" : MessageLookupByLibrary.simpleMessage("最大备忘录长度为100"),
    "megaHashPerSecond" : m16,
    "memo" : MessageLookupByLibrary.simpleMessage("备忘录"),
    "menuOfOne" : m17,
    "menuOfTwo" : m18,
    "minAmount" : m19,
    "minFee" : m20,
    "minutesAndSecondsDuration" : m21,
    "minutesDuration" : m22,
    "name" : MessageLookupByLibrary.simpleMessage("名称"),
    "nameMustBeUnique" : MessageLookupByLibrary.simpleMessage("名称必须是唯一的。"),
    "network" : MessageLookupByLibrary.simpleMessage("网络"),
    "networkOffline" : MessageLookupByLibrary.simpleMessage("网络离线"),
    "networkType" : m23,
    "newPeer" : MessageLookupByLibrary.simpleMessage("新同行"),
    "newWallet" : MessageLookupByLibrary.simpleMessage("新款钱包"),
    "noPrivateKeys" : MessageLookupByLibrary.simpleMessage("没有私钥"),
    "noPublicKeys" : MessageLookupByLibrary.simpleMessage("没有公钥"),
    "nonce" : MessageLookupByLibrary.simpleMessage("杜撰"),
    "numTransactions" : m24,
    "ok" : MessageLookupByLibrary.simpleMessage("好"),
    "password" : MessageLookupByLibrary.simpleMessage("密码"),
    "passwordCantBeEmpty" : MessageLookupByLibrary.simpleMessage("密码不能为空。"),
    "passwordsDontMatch" : MessageLookupByLibrary.simpleMessage("密码不匹配。"),
    "payTo" : MessageLookupByLibrary.simpleMessage("支付给"),
    "peers" : MessageLookupByLibrary.simpleMessage("同行"),
    "petaHashPerSecond" : m25,
    "previous" : MessageLookupByLibrary.simpleMessage("以前"),
    "privacyPolicy" : MessageLookupByLibrary.simpleMessage("隐私政策"),
    "privateKey" : MessageLookupByLibrary.simpleMessage("私钥"),
    "privateKeyList" : MessageLookupByLibrary.simpleMessage("私钥列表"),
    "publicKeyList" : MessageLookupByLibrary.simpleMessage("公钥列表"),
    "receive" : MessageLookupByLibrary.simpleMessage("接收"),
    "recentHistory" : MessageLookupByLibrary.simpleMessage("近期历史"),
    "requireSSLCert" : MessageLookupByLibrary.simpleMessage("需要SSL证书"),
    "secondsDuration" : m26,
    "seedPhrase" : MessageLookupByLibrary.simpleMessage("种子短语"),
    "seedPhraseWarning" : MessageLookupByLibrary.simpleMessage("这个种子允许任何知道它的人花掉你钱包里的所有资金。写下来。保持安全。"),
    "send" : MessageLookupByLibrary.simpleMessage("发送"),
    "sendFailed" : MessageLookupByLibrary.simpleMessage("发送失败"),
    "sending" : MessageLookupByLibrary.simpleMessage("发送中..."),
    "sentTransactionId" : m27,
    "settings" : MessageLookupByLibrary.simpleMessage("设置"),
    "show" : MessageLookupByLibrary.simpleMessage("节目"),
    "showWalletNameInTitle" : MessageLookupByLibrary.simpleMessage("在标题中显示钱包名称"),
    "state" : MessageLookupByLibrary.simpleMessage("州"),
    "support" : MessageLookupByLibrary.simpleMessage("支持"),
    "target" : MessageLookupByLibrary.simpleMessage("目标"),
    "teraHashPerSecond" : m28,
    "theme" : MessageLookupByLibrary.simpleMessage("主题"),
    "time" : MessageLookupByLibrary.simpleMessage("时间"),
    "tip" : MessageLookupByLibrary.simpleMessage("小费"),
    "title" : MessageLookupByLibrary.simpleMessage("Cruzall"),
    "to" : MessageLookupByLibrary.simpleMessage("至"),
    "toAddress" : m29,
    "totalBlocksInLastDuration" : m30,
    "transaction" : MessageLookupByLibrary.simpleMessage("交易"),
    "transactions" : MessageLookupByLibrary.simpleMessage("交易"),
    "unitTestBeforeCreatingWallets" : MessageLookupByLibrary.simpleMessage("创建钱包之前的单元测试"),
    "unitTestFailure" : MessageLookupByLibrary.simpleMessage("单元测试失败"),
    "unknown" : MessageLookupByLibrary.simpleMessage("未知"),
    "unknownAddress" : MessageLookupByLibrary.simpleMessage("地址不明"),
    "unlock" : MessageLookupByLibrary.simpleMessage("开锁"),
    "unlockTitle" : MessageLookupByLibrary.simpleMessage("解锁Cruzall"),
    "url" : MessageLookupByLibrary.simpleMessage("网址"),
    "valueMustBePositive" : MessageLookupByLibrary.simpleMessage("价值必须是积极的"),
    "verify" : MessageLookupByLibrary.simpleMessage("校验"),
    "verifyAddressFailed" : m31,
    "verifyKeyPairsEveryLoad" : MessageLookupByLibrary.simpleMessage("验证每次加载的密钥对"),
    "verifyWalletResults" : m32,
    "verifying" : MessageLookupByLibrary.simpleMessage("验证中..."),
    "version" : MessageLookupByLibrary.simpleMessage("版"),
    "warning" : MessageLookupByLibrary.simpleMessage("警告"),
    "watchOnlyWallet" : MessageLookupByLibrary.simpleMessage("仅限观看的钱包"),
    "welcomeDesc" : MessageLookupByLibrary.simpleMessage("首先，创建一个钱包："),
    "welcomeTitle" : MessageLookupByLibrary.simpleMessage("欢迎来到Cruzall")
  };
}
