// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ko locale. All the
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
  String get localeName => 'ko';

  static m0(address) => "주소 ${address}";

  static m1(height) => "블록 높이 {@<a>} ${height} {@</a>} 에서의 잔액은 다음과 같습니다.";

  static m2(height) => "키 ${height} 성숙도 :";

  static m3(ticker, balance) => "${ticker} + ${balance}";

  static m4(algorithm) => "작성 중 ... ( ${algorithm} )";

  static m5(days) => "${Intl.plural(days, one: '일', other: '${days} 일')}";

  static m6(exaHashPerSecond) => "${exaHashPerSecond} EH / s";

  static m7(address) => "보낸 사람 : ${address}";

  static m8(gigaHashPerSecond) => "${gigaHashPerSecond} GH / s";

  static m9(hashPerSecond) => "${hashPerSecond} H / s";

  static m10(height) => "height = {@<a>} ${height} {@</a>}";

  static m11(product) => "${product} 홈 페이지";

  static m12(hours) => "${Intl.plural(hours, one: '시간', other: '${hours} 시간')}";

  static m13(kiloHashPerSecond) => "${kiloHashPerSecond} KH / s";

  static m14(item1, item2, item3, item4) => "${item1} , ${item2} , ${item3} , ${item4}";

  static m15(item1, item2, item3) => "${item1} , ${item2} , ${item3}";

  static m16(item1, item2) => "${item1} , ${item2}";

  static m17(cap) => "시가 총액 {@<a>} ${cap} {@</a>}";

  static m18(megaHashPerSecond) => "${megaHashPerSecond} MH / s";

  static m19(item) => "[ {@<a>} ${item} {@</a>} ]";

  static m20(item1, item2) => "[ {@<a1>} ${item1} {@</a1>} , {@<a2>} ${item2} {@</a2>} ]";

  static m21(amount) => "최소 금액은 ${amount}";

  static m22(fee) => "최소 수수료는 ${fee}";

  static m23(minutes, seconds) => "${minutes} ${seconds}";

  static m24(minutes) => "${Intl.plural(minutes, one: '${minutes} 분', other: '${minutes} 분')}";

  static m25(type) => "${type} 네트워크";

  static m26(number) => "거래 ( ${number} )";

  static m27(petaHashPerSecond) => "${petaHashPerSecond} PH / s";

  static m28(seconds) => "${Intl.plural(seconds, one: '${seconds} 초', other: '${seconds} 초')}";

  static m29(transactionId) => "보낸 ${transactionId}";

  static m30(teraHashPerSecond) => "${teraHashPerSecond} TH / s";

  static m31(address) => "받는 사람 : ${address}";

  static m32(totalBlocks, duration) => "${totalBlocks} {@<a1>} 은 마지막 {@<a2>} ${duration} {@</a2>} 에서 {@</a1>} 을 차단합니다.";

  static m33(totalBlocks, totalTransactions, duration) => "${totalBlocks} {@<a1>} 차단 {@</a1>}, 마지막 {@<a2>} ${duration} {@</a2>}의 ${totalTransactions} 거래";

  static m34(addressText) => "확인 실패 : ${addressText}";

  static m35(goodAddresses, totalAddresses, goodTests, totalTests) => "확인 된 ${goodAddresses} / ${totalAddresses} 주소 및 ${goodTests} / ${totalTests} 테스트 성공";

  static m36(walletName, accountId, chainIndex) => "${walletName} : 계정 ${accountId}, 주소 ${chainIndex}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "account" : MessageLookupByLibrary.simpleMessage("계정"),
    "accounts" : MessageLookupByLibrary.simpleMessage("계정"),
    "activeTransactions" : MessageLookupByLibrary.simpleMessage("활성 거래"),
    "addWallet" : MessageLookupByLibrary.simpleMessage("월렛 추가"),
    "address" : MessageLookupByLibrary.simpleMessage("주소"),
    "addressMustBeUnique" : MessageLookupByLibrary.simpleMessage("주소는 고유해야합니다."),
    "addressStateOpen" : MessageLookupByLibrary.simpleMessage("열다"),
    "addressStateReserve" : MessageLookupByLibrary.simpleMessage("비축"),
    "addressStateUsed" : MessageLookupByLibrary.simpleMessage("익숙한"),
    "addressTitle" : m0,
    "addresses" : MessageLookupByLibrary.simpleMessage("구애"),
    "amount" : MessageLookupByLibrary.simpleMessage("양"),
    "backupKeysWarning" : MessageLookupByLibrary.simpleMessage("키는 외부 저장소에 백업해야합니다."),
    "balance" : MessageLookupByLibrary.simpleMessage("균형"),
    "balanceAtHeightIs" : m1,
    "balanceMaturingByHeightIs" : m2,
    "balanceTitle" : m3,
    "block" : MessageLookupByLibrary.simpleMessage("블록"),
    "blocks" : MessageLookupByLibrary.simpleMessage("블록"),
    "cancel" : MessageLookupByLibrary.simpleMessage("취소"),
    "cantDeleteOnlyWallet" : MessageLookupByLibrary.simpleMessage("지갑 만 삭제할 수 없습니다."),
    "chainCode" : MessageLookupByLibrary.simpleMessage("체인 코드"),
    "chainIndex" : MessageLookupByLibrary.simpleMessage("체인 인덱스"),
    "chainWork" : MessageLookupByLibrary.simpleMessage("체인 작업"),
    "confirmPassword" : MessageLookupByLibrary.simpleMessage("비밀번호 확인"),
    "confirmations" : MessageLookupByLibrary.simpleMessage("확인"),
    "console" : MessageLookupByLibrary.simpleMessage("콘솔"),
    "contacts" : MessageLookupByLibrary.simpleMessage("콘택트 렌즈"),
    "copied" : MessageLookupByLibrary.simpleMessage("복사했습니다."),
    "copy" : MessageLookupByLibrary.simpleMessage("부"),
    "copyPublicKeys" : MessageLookupByLibrary.simpleMessage("공개 키 복사"),
    "create" : MessageLookupByLibrary.simpleMessage("몹시 떠들어 대다"),
    "creating" : MessageLookupByLibrary.simpleMessage("만드는 중 ..."),
    "creatingUsingAlgorithm" : m4,
    "cruzTicker" : MessageLookupByLibrary.simpleMessage("크루즈"),
    "currency" : MessageLookupByLibrary.simpleMessage("통화"),
    "currentBalanceIs" : MessageLookupByLibrary.simpleMessage("현재 잔액은 다음과 같습니다."),
    "dangerZone" : MessageLookupByLibrary.simpleMessage("위험 지대"),
    "date" : MessageLookupByLibrary.simpleMessage("날짜"),
    "daysDuration" : m5,
    "debugLog" : MessageLookupByLibrary.simpleMessage("디버그 로그"),
    "defaultWalletName" : MessageLookupByLibrary.simpleMessage("내 지갑"),
    "delete" : MessageLookupByLibrary.simpleMessage("지우다"),
    "deletePeer" : MessageLookupByLibrary.simpleMessage("동료 삭제"),
    "deleteThisWallet" : MessageLookupByLibrary.simpleMessage("이 지갑을 삭제"),
    "deleteWallet" : MessageLookupByLibrary.simpleMessage("월렛 삭제"),
    "deleteWalletDescription" : MessageLookupByLibrary.simpleMessage("지갑을 삭제하면 되돌아 갈 필요가 없습니다. 확실하십시오."),
    "deltaHashPower" : MessageLookupByLibrary.simpleMessage("델타 해시 파워"),
    "deltaTime" : MessageLookupByLibrary.simpleMessage("델타 시간"),
    "donations" : MessageLookupByLibrary.simpleMessage("기부금"),
    "earliestSeen" : MessageLookupByLibrary.simpleMessage("가장 일찍 본"),
    "email" : MessageLookupByLibrary.simpleMessage("이메일"),
    "encrypt" : MessageLookupByLibrary.simpleMessage("암호화"),
    "encryption" : MessageLookupByLibrary.simpleMessage("암호화"),
    "exaHashPerSecond" : m6,
    "expired" : MessageLookupByLibrary.simpleMessage("만료"),
    "expires" : MessageLookupByLibrary.simpleMessage("만료"),
    "externalAddress" : MessageLookupByLibrary.simpleMessage("외부 주소"),
    "fee" : MessageLookupByLibrary.simpleMessage("보수"),
    "from" : MessageLookupByLibrary.simpleMessage("에서"),
    "fromAddress" : m7,
    "generateNewAddress" : MessageLookupByLibrary.simpleMessage("새 주소 생성"),
    "gigaHashPerSecond" : m8,
    "hashListRoot" : MessageLookupByLibrary.simpleMessage("해시 목록 루트"),
    "hashPerSecond" : m9,
    "hdWallet" : MessageLookupByLibrary.simpleMessage("HD 월렛"),
    "hdWalletAlgorithm" : MessageLookupByLibrary.simpleMessage("PBKDF : 2048 반복"),
    "height" : MessageLookupByLibrary.simpleMessage("신장"),
    "heightEquals" : m10,
    "hide" : MessageLookupByLibrary.simpleMessage("숨는 장소"),
    "homePage" : m11,
    "hoursDuration" : m12,
    "id" : MessageLookupByLibrary.simpleMessage("신분증"),
    "ignore" : MessageLookupByLibrary.simpleMessage("무시"),
    "insecureDeviceWarning" : MessageLookupByLibrary.simpleMessage("안전하지 않은 장치 경고"),
    "insecureDeviceWarningDescription" : MessageLookupByLibrary.simpleMessage("루팅되었거나 탈옥 된 기기가 감지되었습니다. 더 이상 사용하지 않는 것이 좋습니다."),
    "insufficientFunds" : MessageLookupByLibrary.simpleMessage("자금 부족"),
    "invalidAddress" : MessageLookupByLibrary.simpleMessage("잘못된 주소"),
    "invalidCurrency" : MessageLookupByLibrary.simpleMessage("잘못된 통화"),
    "invalidJson" : MessageLookupByLibrary.simpleMessage("잘못된 JSON입니다."),
    "invalidMnemonic" : MessageLookupByLibrary.simpleMessage("잘못된 니모닉"),
    "invalidPrivateKey" : MessageLookupByLibrary.simpleMessage("잘못된 개인 키."),
    "invalidPublicKey" : MessageLookupByLibrary.simpleMessage("잘못된 공개 키."),
    "invalidUrl" : MessageLookupByLibrary.simpleMessage("잘못된 URL."),
    "kiloHashPerSecond" : m13,
    "language" : MessageLookupByLibrary.simpleMessage("언어"),
    "latestSeen" : MessageLookupByLibrary.simpleMessage("최근 본"),
    "license" : MessageLookupByLibrary.simpleMessage("특허"),
    "listOfFour" : m14,
    "listOfThree" : m15,
    "listOfTwo" : m16,
    "loading" : MessageLookupByLibrary.simpleMessage("불러오는 중 ..."),
    "localeLanguage" : MessageLookupByLibrary.simpleMessage("한국어"),
    "marketCap" : m17,
    "matured" : MessageLookupByLibrary.simpleMessage("성숙"),
    "matures" : MessageLookupByLibrary.simpleMessage("성숙하다"),
    "maturing" : MessageLookupByLibrary.simpleMessage("숙성"),
    "maturingTransactions" : MessageLookupByLibrary.simpleMessage("거래 성숙"),
    "maxMemoLength" : MessageLookupByLibrary.simpleMessage("최대 메모 길이는 100입니다"),
    "megaHashPerSecond" : m18,
    "memo" : MessageLookupByLibrary.simpleMessage("메모"),
    "menuOfOne" : m19,
    "menuOfTwo" : m20,
    "minAmount" : m21,
    "minFee" : m22,
    "minutesAndSecondsDuration" : m23,
    "minutesDuration" : m24,
    "name" : MessageLookupByLibrary.simpleMessage("이름"),
    "nameMustBeUnique" : MessageLookupByLibrary.simpleMessage("이름은 고유해야합니다."),
    "network" : MessageLookupByLibrary.simpleMessage("회로망"),
    "networkOffline" : MessageLookupByLibrary.simpleMessage("네트워크 오프라인"),
    "networkType" : m25,
    "newContact" : MessageLookupByLibrary.simpleMessage("새로운 연락처"),
    "newPeer" : MessageLookupByLibrary.simpleMessage("새로운 피어"),
    "newWallet" : MessageLookupByLibrary.simpleMessage("새 월렛"),
    "next" : MessageLookupByLibrary.simpleMessage("다음 것"),
    "noPrivateKeys" : MessageLookupByLibrary.simpleMessage("개인 키가 없습니다"),
    "noPublicKeys" : MessageLookupByLibrary.simpleMessage("공개 키가 없습니다"),
    "nonce" : MessageLookupByLibrary.simpleMessage("목하"),
    "numTransactions" : m26,
    "ok" : MessageLookupByLibrary.simpleMessage("승인"),
    "password" : MessageLookupByLibrary.simpleMessage("암호"),
    "passwordCantBeEmpty" : MessageLookupByLibrary.simpleMessage("비밀번호는 비워 둘 수 없습니다."),
    "passwordsDontMatch" : MessageLookupByLibrary.simpleMessage("비밀번호가 일치하지 않습니다."),
    "paste" : MessageLookupByLibrary.simpleMessage("풀"),
    "payTo" : MessageLookupByLibrary.simpleMessage("에 지불하다"),
    "peers" : MessageLookupByLibrary.simpleMessage("동료"),
    "pending" : MessageLookupByLibrary.simpleMessage("대기 중"),
    "petaHashPerSecond" : m27,
    "previous" : MessageLookupByLibrary.simpleMessage("너무 이른"),
    "privacyPolicy" : MessageLookupByLibrary.simpleMessage("개인 정보 정책"),
    "privateKey" : MessageLookupByLibrary.simpleMessage("개인 키"),
    "privateKeyList" : MessageLookupByLibrary.simpleMessage("개인 키 목록"),
    "publicKeyList" : MessageLookupByLibrary.simpleMessage("공개 키 목록"),
    "receive" : MessageLookupByLibrary.simpleMessage("받다"),
    "recentHistory" : MessageLookupByLibrary.simpleMessage("최근 역사"),
    "requireSSLCert" : MessageLookupByLibrary.simpleMessage("SSL 인증서 필요"),
    "result" : MessageLookupByLibrary.simpleMessage("결과"),
    "search" : MessageLookupByLibrary.simpleMessage("수색"),
    "secondsDuration" : m28,
    "seedPhrase" : MessageLookupByLibrary.simpleMessage("종자 문구"),
    "seedPhraseWarning" : MessageLookupByLibrary.simpleMessage("이 씨앗은 그것을 아는 사람이라면 누구나 당신의 지갑에서 모든 돈을 쓸 수있게합니다. 받아 적어. 안전을 유지해라."),
    "send" : MessageLookupByLibrary.simpleMessage("보내다"),
    "sendFailed" : MessageLookupByLibrary.simpleMessage("전송 실패"),
    "sending" : MessageLookupByLibrary.simpleMessage("배상..."),
    "sentTransactionId" : m29,
    "settings" : MessageLookupByLibrary.simpleMessage("설정"),
    "show" : MessageLookupByLibrary.simpleMessage("보여 주다"),
    "showWalletNameInTitle" : MessageLookupByLibrary.simpleMessage("지갑 이름 표시"),
    "state" : MessageLookupByLibrary.simpleMessage("상태"),
    "support" : MessageLookupByLibrary.simpleMessage("지원하다"),
    "target" : MessageLookupByLibrary.simpleMessage("목표"),
    "teraHashPerSecond" : m30,
    "thanksForDonating" : MessageLookupByLibrary.simpleMessage("바로! 감사합니다 CRUZ 커뮤니티!"),
    "theme" : MessageLookupByLibrary.simpleMessage("테마"),
    "time" : MessageLookupByLibrary.simpleMessage("시각"),
    "tip" : MessageLookupByLibrary.simpleMessage("팁"),
    "title" : MessageLookupByLibrary.simpleMessage("Cruzall"),
    "to" : MessageLookupByLibrary.simpleMessage("에"),
    "toAddress" : m31,
    "totalBlocksInLastDuration" : m32,
    "totalBlocksTransactionsInLastDuration" : m33,
    "transaction" : MessageLookupByLibrary.simpleMessage("트랜잭션"),
    "transactions" : MessageLookupByLibrary.simpleMessage("업무"),
    "typingAddressesWarning" : MessageLookupByLibrary.simpleMessage("경고 : 직접 손으로 주소를 입력하면 위험하고 오류가 발생하기 쉽습니다. 항상 복사 버튼 또는 QR 스캐너를 사용하십시오."),
    "unitTestBeforeCreatingWallets" : MessageLookupByLibrary.simpleMessage("지갑을 만들기 전에 단위 테스트"),
    "unitTestFailure" : MessageLookupByLibrary.simpleMessage("단위 테스트 실패"),
    "unknown" : MessageLookupByLibrary.simpleMessage("알 수 없는"),
    "unknownAddress" : MessageLookupByLibrary.simpleMessage("알 수없는 주소"),
    "unknownQuery" : MessageLookupByLibrary.simpleMessage("알 수없는 검색어"),
    "unlock" : MessageLookupByLibrary.simpleMessage("터놓다"),
    "unlockTitle" : MessageLookupByLibrary.simpleMessage("Cruzall 잠금 해제"),
    "url" : MessageLookupByLibrary.simpleMessage("URL"),
    "valueMustBePositive" : MessageLookupByLibrary.simpleMessage("값은 양수 여야합니다"),
    "verify" : MessageLookupByLibrary.simpleMessage("확인"),
    "verifyAddressFailed" : m34,
    "verifyKeyPairsEveryLoad" : MessageLookupByLibrary.simpleMessage("부하마다 키 페어 확인"),
    "verifyWalletResults" : m35,
    "verifying" : MessageLookupByLibrary.simpleMessage("확인 중 ..."),
    "version" : MessageLookupByLibrary.simpleMessage("번역"),
    "walletAccountName" : m36,
    "warning" : MessageLookupByLibrary.simpleMessage("경고"),
    "watchOnlyWallet" : MessageLookupByLibrary.simpleMessage("시계 전용 지갑"),
    "welcomeDesc" : MessageLookupByLibrary.simpleMessage("시작하려면 지갑을 만드십시오."),
    "welcomeTitle" : MessageLookupByLibrary.simpleMessage("Cruzall에 오신 것을 환영합니다")
  };
}
