// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
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
  String get localeName => 'zh';

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

  static m10(height) => "身高= {@<a>} ${height} {@</a>}";

  static m11(product) => "${product}主页";

  static m12(hours) => "${Intl.plural(hours, one: '小时', other: '${hours}小时')}";

  static m13(kiloHashPerSecond) => "${kiloHashPerSecond} KH / s";

  static m14(item1, item2, item3, item4) => "${item1} ， ${item2} ， ${item3} ， ${item4}";

  static m15(item1, item2, item3) => "${item1} ， ${item2} ， ${item3}";

  static m16(item1, item2) => "${item1} ， ${item2}";

  static m17(cap) => "市值{@<a>}${cap}{@</a>}";

  static m18(megaHashPerSecond) => "${megaHashPerSecond} MH / s";

  static m19(item) => "[ {@<a>} ${item} {@</a>} ]";

  static m20(item1, item2) => "[ {@<a1>} ${item1} {@</a1>} ， {@<a2>} ${item2} {@</a2>} ]";

  static m21(amount) => "最低金额为${amount}";

  static m22(fee) => "最低费用为${fee}";

  static m23(minutes, seconds) => "${minutes} ${seconds}";

  static m24(minutes) => "${Intl.plural(minutes, one: '${minutes}分钟', other: '${minutes}分钟')}";

  static m25(type) => "${type}网络";

  static m26(number) => "交易（ ${number} ）";

  static m27(petaHashPerSecond) => "${petaHashPerSecond} PH / s";

  static m28(seconds) => "${Intl.plural(seconds, one: '${seconds}秒', other: '${seconds}秒')}";

  static m29(transactionId) => "已发送${transactionId}";

  static m30(teraHashPerSecond) => "${teraHashPerSecond} TH / s";

  static m31(address) => "要： ${address}";

  static m32(totalBlocks, duration) => "${totalBlocks} {@<a1>}阻止{@</a1>} {@<a2>} ${duration} {@</a2>}";

  static m33(totalBlocks, totalTransactions, duration) => "${totalBlocks} {@<a1>}阻止{@</a1>}, ${totalTransactions}上次 {@<a2>}${duration}{@</a2>}的交易";

  static m34(addressText) => "验证失败： ${addressText}";

  static m35(goodAddresses, totalAddresses, goodTests, totalTests) => "已验证的${goodAddresses} / ${totalAddresses}地址和${goodTests} / ${totalTests}测试成功";

  static m36(walletName, accountId, chainIndex) => "${walletName}：帐户${accountId}，地址${chainIndex}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "account" : MessageLookupByLibrary.simpleMessage("帐户"),
    "accounts" : MessageLookupByLibrary.simpleMessage("帐号"),
    "activeTransactions" : MessageLookupByLibrary.simpleMessage("活跃的交易"),
    "addWallet" : MessageLookupByLibrary.simpleMessage("添加钱包"),
    "address" : MessageLookupByLibrary.simpleMessage("地址"),
    "addressMustBeUnique" : MessageLookupByLibrary.simpleMessage("地址必须是唯一的。"),
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
    "connected" : MessageLookupByLibrary.simpleMessage("连接的"),
    "console" : MessageLookupByLibrary.simpleMessage("安慰"),
    "contacts" : MessageLookupByLibrary.simpleMessage("往来"),
    "copied" : MessageLookupByLibrary.simpleMessage("复制。"),
    "copy" : MessageLookupByLibrary.simpleMessage("复制"),
    "copyAddresses" : MessageLookupByLibrary.simpleMessage("复制地址"),
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
    "donations" : MessageLookupByLibrary.simpleMessage("捐赠"),
    "duration" : MessageLookupByLibrary.simpleMessage("持续时间"),
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
    "hashPerSecond" : m9,
    "hashRoot" : MessageLookupByLibrary.simpleMessage("哈希根"),
    "hdWallet" : MessageLookupByLibrary.simpleMessage("高清钱包"),
    "hdWalletAlgorithm" : MessageLookupByLibrary.simpleMessage("PBKDF：2048次迭代"),
    "height" : MessageLookupByLibrary.simpleMessage("高度"),
    "heightEquals" : m10,
    "hide" : MessageLookupByLibrary.simpleMessage("隐藏"),
    "home" : MessageLookupByLibrary.simpleMessage("家"),
    "homePage" : m11,
    "hoursDuration" : m12,
    "id" : MessageLookupByLibrary.simpleMessage("识别码"),
    "ignore" : MessageLookupByLibrary.simpleMessage("忽视"),
    "insecureDeviceWarning" : MessageLookupByLibrary.simpleMessage("不安全的设备警告"),
    "insecureDeviceWarningDescription" : MessageLookupByLibrary.simpleMessage("已检测到有根或越狱的设备。进一步使用不推荐。"),
    "insufficientFunds" : MessageLookupByLibrary.simpleMessage("不充足的资金"),
    "invalidAddress" : MessageLookupByLibrary.simpleMessage("无效地址"),
    "invalidCurrency" : MessageLookupByLibrary.simpleMessage("货币无效"),
    "invalidJson" : MessageLookupByLibrary.simpleMessage("无效的JSON"),
    "invalidMnemonic" : MessageLookupByLibrary.simpleMessage("无效的助记符"),
    "invalidPrivateKey" : MessageLookupByLibrary.simpleMessage("私钥无效"),
    "invalidPublicKey" : MessageLookupByLibrary.simpleMessage("公钥无效"),
    "invalidUrl" : MessageLookupByLibrary.simpleMessage("无效的网址。"),
    "kiloHashPerSecond" : m13,
    "language" : MessageLookupByLibrary.simpleMessage("语言"),
    "latestSeen" : MessageLookupByLibrary.simpleMessage("最新见过"),
    "license" : MessageLookupByLibrary.simpleMessage("执照"),
    "listOfFour" : m14,
    "listOfThree" : m15,
    "listOfTwo" : m16,
    "loading" : MessageLookupByLibrary.simpleMessage("载入中..."),
    "localeLanguage" : MessageLookupByLibrary.simpleMessage("中文"),
    "marketCap" : m17,
    "matured" : MessageLookupByLibrary.simpleMessage("成熟"),
    "matures" : MessageLookupByLibrary.simpleMessage("成熟"),
    "maturing" : MessageLookupByLibrary.simpleMessage("成熟"),
    "maturingTransactions" : MessageLookupByLibrary.simpleMessage("成熟的交易"),
    "maxMemoLength" : MessageLookupByLibrary.simpleMessage("最大备忘录长度为100"),
    "megaHashPerSecond" : m18,
    "memo" : MessageLookupByLibrary.simpleMessage("备忘录"),
    "menuOfOne" : m19,
    "menuOfTwo" : m20,
    "minAmount" : m21,
    "minFee" : m22,
    "minutesAndSecondsDuration" : m23,
    "minutesDuration" : m24,
    "name" : MessageLookupByLibrary.simpleMessage("名称"),
    "nameMustBeUnique" : MessageLookupByLibrary.simpleMessage("名称必须是唯一的。"),
    "network" : MessageLookupByLibrary.simpleMessage("网络"),
    "networkOffline" : MessageLookupByLibrary.simpleMessage("网络离线"),
    "networkType" : m25,
    "newContact" : MessageLookupByLibrary.simpleMessage("新联系人"),
    "newPeer" : MessageLookupByLibrary.simpleMessage("新同行"),
    "newWallet" : MessageLookupByLibrary.simpleMessage("新款钱包"),
    "next" : MessageLookupByLibrary.simpleMessage("下一个"),
    "noPrivateKeys" : MessageLookupByLibrary.simpleMessage("没有私钥"),
    "noPublicKeys" : MessageLookupByLibrary.simpleMessage("没有公钥"),
    "nonce" : MessageLookupByLibrary.simpleMessage("杜撰"),
    "numTransactions" : m26,
    "ok" : MessageLookupByLibrary.simpleMessage("好"),
    "password" : MessageLookupByLibrary.simpleMessage("密码"),
    "passwordCantBeEmpty" : MessageLookupByLibrary.simpleMessage("密码不能为空。"),
    "passwordsDontMatch" : MessageLookupByLibrary.simpleMessage("密码不匹配。"),
    "paste" : MessageLookupByLibrary.simpleMessage("糊"),
    "payTo" : MessageLookupByLibrary.simpleMessage("支付给"),
    "peers" : MessageLookupByLibrary.simpleMessage("同行"),
    "pending" : MessageLookupByLibrary.simpleMessage("有待"),
    "petaHashPerSecond" : m27,
    "previous" : MessageLookupByLibrary.simpleMessage("以前"),
    "privacyPolicy" : MessageLookupByLibrary.simpleMessage("隐私政策"),
    "privateKey" : MessageLookupByLibrary.simpleMessage("私钥"),
    "privateKeyList" : MessageLookupByLibrary.simpleMessage("私钥列表"),
    "publicKeyList" : MessageLookupByLibrary.simpleMessage("公钥列表"),
    "receive" : MessageLookupByLibrary.simpleMessage("接收"),
    "recentHistory" : MessageLookupByLibrary.simpleMessage("近期历史"),
    "requireSSLCert" : MessageLookupByLibrary.simpleMessage("需要SSL证书"),
    "result" : MessageLookupByLibrary.simpleMessage("结果"),
    "search" : MessageLookupByLibrary.simpleMessage("搜索"),
    "secondsDuration" : m28,
    "seedPhrase" : MessageLookupByLibrary.simpleMessage("种子短语"),
    "seedPhraseWarning" : MessageLookupByLibrary.simpleMessage("这个种子允许任何知道它的人花掉你钱包里的所有资金。写下来。保持安全。"),
    "send" : MessageLookupByLibrary.simpleMessage("发送"),
    "sendFailed" : MessageLookupByLibrary.simpleMessage("发送失败"),
    "sending" : MessageLookupByLibrary.simpleMessage("发送中..."),
    "sentTransactionId" : m29,
    "settings" : MessageLookupByLibrary.simpleMessage("设置"),
    "show" : MessageLookupByLibrary.simpleMessage("节目"),
    "showWalletNameInTitle" : MessageLookupByLibrary.simpleMessage("在标题中显示钱包名称"),
    "state" : MessageLookupByLibrary.simpleMessage("州"),
    "submit" : MessageLookupByLibrary.simpleMessage("提交"),
    "support" : MessageLookupByLibrary.simpleMessage("支持"),
    "target" : MessageLookupByLibrary.simpleMessage("目标"),
    "teraHashPerSecond" : m30,
    "thanksForDonating" : MessageLookupByLibrary.simpleMessage("对吧！ 谢谢CRUZ社区！"),
    "theme" : MessageLookupByLibrary.simpleMessage("主题"),
    "time" : MessageLookupByLibrary.simpleMessage("时间"),
    "tip" : MessageLookupByLibrary.simpleMessage("小费"),
    "title" : MessageLookupByLibrary.simpleMessage("Cruzall"),
    "to" : MessageLookupByLibrary.simpleMessage("至"),
    "toAddress" : m31,
    "totalBlocksInLastDuration" : m32,
    "totalBlocksTransactionsInLastDuration" : m33,
    "transaction" : MessageLookupByLibrary.simpleMessage("交易"),
    "transactions" : MessageLookupByLibrary.simpleMessage("交易"),
    "typingAddressesWarning" : MessageLookupByLibrary.simpleMessage("警告：手动键入地址很危险且容易出错。 始终使用复印按钮或QR扫描仪。"),
    "unitTestBeforeCreatingWallets" : MessageLookupByLibrary.simpleMessage("创建钱包之前的单元测试"),
    "unitTestFailure" : MessageLookupByLibrary.simpleMessage("单元测试失败"),
    "unknown" : MessageLookupByLibrary.simpleMessage("未知"),
    "unknownAddress" : MessageLookupByLibrary.simpleMessage("地址不明"),
    "unknownQuery" : MessageLookupByLibrary.simpleMessage("未知查询"),
    "unlock" : MessageLookupByLibrary.simpleMessage("开锁"),
    "unlockTitle" : MessageLookupByLibrary.simpleMessage("解锁Cruzall"),
    "url" : MessageLookupByLibrary.simpleMessage("网址"),
    "valueMustBePositive" : MessageLookupByLibrary.simpleMessage("价值必须是积极的"),
    "verify" : MessageLookupByLibrary.simpleMessage("校验"),
    "verifyAddressFailed" : m34,
    "verifyKeyPairsEveryLoad" : MessageLookupByLibrary.simpleMessage("验证每次加载的密钥对"),
    "verifyWalletResults" : m35,
    "verifying" : MessageLookupByLibrary.simpleMessage("验证中..."),
    "version" : MessageLookupByLibrary.simpleMessage("版"),
    "walletAccountName" : m36,
    "wallets" : MessageLookupByLibrary.simpleMessage("钱包"),
    "warning" : MessageLookupByLibrary.simpleMessage("警告"),
    "watchOnlyWallet" : MessageLookupByLibrary.simpleMessage("仅限观看的钱包"),
    "welcomeDesc" : MessageLookupByLibrary.simpleMessage("首先，创建一个钱包："),
    "welcomeTitle" : MessageLookupByLibrary.simpleMessage("欢迎来到Cruzall")
  };
}
