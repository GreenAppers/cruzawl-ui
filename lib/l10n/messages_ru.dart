// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
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
  get localeName => 'ru';

  static m0(address) => "Адрес ${address}";

  static m1(height) => "Ваш баланс на высоте блока {@<a>} ${height} {@</a>} :";

  static m2(height) => "Ваш баланс созревания по высоте ${height} является:";

  static m3(ticker, balance) => "${ticker} + ${balance}";

  static m4(algorithm) => "Создание ... ( ${algorithm} )";

  static m5(days) => "${Intl.plural(days, one: 'день', other: '${days} дней')}";

  static m6(exaHashPerSecond) => "${exaHashPerSecond} EH / s";

  static m7(address) => "От: ${address}";

  static m8(gigaHashPerSecond) => "${gigaHashPerSecond} GH / s";

  static m9(gigaValue) => "${gigaValue} B";

  static m10(hashPerSecond) => "${hashPerSecond} H / s";

  static m11(height) => "высота = {@<a>} ${height} {@</a>}";

  static m12(product) => "${product} Домашняя страница";

  static m13(hours) => "${Intl.plural(hours, one: 'час', other: '${hours} часов')}";

  static m14(kiloHashPerSecond) => "${kiloHashPerSecond} KH / s";

  static m15(kiloValue) => "${kiloValue} K";

  static m16(item1, item2, item3, item4) => "${item1} , ${item2} , ${item3} , ${item4}";

  static m17(item1, item2, item3) => "${item1} , ${item2} , ${item3}";

  static m18(item1, item2) => "${item1} , ${item2}";

  static m19(cap) => "Рыночная капитализация {@<a>} ${cap} {@</a>}";

  static m20(megaHashPerSecond) => "${megaHashPerSecond} MH / s";

  static m21(megaValue) => "${megaValue} M";

  static m22(item) => "[ {@<a>} ${item} {@</a>} ]";

  static m23(item1, item2) => "[ {@<a1>} ${item1} {@</a1>} , {@<a2>} ${item2} {@</a2>} ]";

  static m24(amount) => "Минимальная сумма ${amount}";

  static m25(fee) => "Минимальная плата ${fee}";

  static m26(minutes, seconds) => "${minutes} ${seconds}";

  static m27(minutes) => "${Intl.plural(minutes, one: '${minutes} минуты', other: '${minutes} минуты')}";

  static m28(type) => "${type} Сеть";

  static m29(number) => "Транзакции ( ${number} )";

  static m30(petaHashPerSecond) => "${petaHashPerSecond} PH / s";

  static m31(value) => "${value}";

  static m32(seconds) => "${Intl.plural(seconds, one: '${seconds} секунд', other: '${seconds} секунд')}";

  static m33(transactionId) => "Отправлено ${transactionId}";

  static m34(teraHashPerSecond) => "${teraHashPerSecond} TH / s";

  static m35(teraValue) => "${teraValue} T";

  static m36(address) => "Кому: ${address}";

  static m37(totalBlocks, duration) => "${totalBlocks} {@<a1>} блоков {@</a1>} за последние {@<a2>} ${duration} {@</a2>}";

  static m38(addressText) => "не удалось проверить: ${addressText}";

  static m39(goodAddresses, totalAddresses, goodTests, totalTests) => "Проверенные ${goodAddresses} / ${totalAddresses} и ${goodTests} / ${totalTests} успешно";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "account" : MessageLookupByLibrary.simpleMessage("учетная запись"),
    "accounts" : MessageLookupByLibrary.simpleMessage("Счета"),
    "activeTransactions" : MessageLookupByLibrary.simpleMessage("Активные транзакции"),
    "addWallet" : MessageLookupByLibrary.simpleMessage("Добавить кошелек"),
    "address" : MessageLookupByLibrary.simpleMessage("Адрес"),
    "addressStateOpen" : MessageLookupByLibrary.simpleMessage("открыть"),
    "addressStateReserve" : MessageLookupByLibrary.simpleMessage("резерв"),
    "addressStateUsed" : MessageLookupByLibrary.simpleMessage("используемый"),
    "addressTitle" : m0,
    "addresses" : MessageLookupByLibrary.simpleMessage("Адреса"),
    "amount" : MessageLookupByLibrary.simpleMessage("Количество"),
    "backupKeysWarning" : MessageLookupByLibrary.simpleMessage("Ваши ключи должны быть сохранены на внешнем хранилище."),
    "balance" : MessageLookupByLibrary.simpleMessage("Остаток средств"),
    "balanceAtHeightIs" : m1,
    "balanceMaturingByHeightIs" : m2,
    "balanceTitle" : m3,
    "block" : MessageLookupByLibrary.simpleMessage("блок"),
    "blocks" : MessageLookupByLibrary.simpleMessage("Блоки"),
    "cancel" : MessageLookupByLibrary.simpleMessage("отменить"),
    "cantDeleteOnlyWallet" : MessageLookupByLibrary.simpleMessage("Не могу удалить единственный кошелек."),
    "chainCode" : MessageLookupByLibrary.simpleMessage("Цепной код"),
    "chainIndex" : MessageLookupByLibrary.simpleMessage("Индекс цепи"),
    "chainWork" : MessageLookupByLibrary.simpleMessage("Цепная работа"),
    "confirmPassword" : MessageLookupByLibrary.simpleMessage("Подтвердите Пароль"),
    "confirmations" : MessageLookupByLibrary.simpleMessage("Подтверждения"),
    "console" : MessageLookupByLibrary.simpleMessage("Приставка"),
    "copied" : MessageLookupByLibrary.simpleMessage("Скопировано."),
    "copy" : MessageLookupByLibrary.simpleMessage("копия"),
    "copyPublicKeys" : MessageLookupByLibrary.simpleMessage("Копировать открытые ключи"),
    "create" : MessageLookupByLibrary.simpleMessage("Создайте"),
    "creating" : MessageLookupByLibrary.simpleMessage("Создание ..."),
    "creatingUsingAlgorithm" : m4,
    "cruzTicker" : MessageLookupByLibrary.simpleMessage("CRUZ"),
    "currency" : MessageLookupByLibrary.simpleMessage("валюта"),
    "currentBalanceIs" : MessageLookupByLibrary.simpleMessage("Ваш текущий баланс:"),
    "dangerZone" : MessageLookupByLibrary.simpleMessage("Опасная зона"),
    "date" : MessageLookupByLibrary.simpleMessage("Дата"),
    "daysDuration" : m5,
    "debugLog" : MessageLookupByLibrary.simpleMessage("Журнал отладки"),
    "defaultWalletName" : MessageLookupByLibrary.simpleMessage("Мой бумажник"),
    "delete" : MessageLookupByLibrary.simpleMessage("удалять"),
    "deletePeer" : MessageLookupByLibrary.simpleMessage("Удалить Peer"),
    "deleteThisWallet" : MessageLookupByLibrary.simpleMessage("Удалить этот кошелек"),
    "deleteWallet" : MessageLookupByLibrary.simpleMessage("Удалить кошелек"),
    "deleteWalletDescription" : MessageLookupByLibrary.simpleMessage("Как только вы удалите кошелек, пути назад уже не будет. Пожалуйста, будьте уверены."),
    "deltaHashPower" : MessageLookupByLibrary.simpleMessage("Delta Hash Power"),
    "deltaTime" : MessageLookupByLibrary.simpleMessage("Delta Time"),
    "donations" : MessageLookupByLibrary.simpleMessage("Пожертвования"),
    "earliestSeen" : MessageLookupByLibrary.simpleMessage("Самое раннее увиденное"),
    "email" : MessageLookupByLibrary.simpleMessage("Эл. адрес"),
    "encrypt" : MessageLookupByLibrary.simpleMessage("шифровать"),
    "encryption" : MessageLookupByLibrary.simpleMessage("шифрование"),
    "exaHashPerSecond" : m6,
    "expired" : MessageLookupByLibrary.simpleMessage("Истекший"),
    "expires" : MessageLookupByLibrary.simpleMessage("Истекает"),
    "externalAddress" : MessageLookupByLibrary.simpleMessage("Внешний адрес"),
    "fee" : MessageLookupByLibrary.simpleMessage("плата"),
    "from" : MessageLookupByLibrary.simpleMessage("От"),
    "fromAddress" : m7,
    "generateNewAddress" : MessageLookupByLibrary.simpleMessage("Создать новый адрес"),
    "gigaHashPerSecond" : m8,
    "gigaQuantity" : m9,
    "hashListRoot" : MessageLookupByLibrary.simpleMessage("Корень хэш-списка"),
    "hashPerSecond" : m10,
    "hdWallet" : MessageLookupByLibrary.simpleMessage("HD кошелек"),
    "hdWalletAlgorithm" : MessageLookupByLibrary.simpleMessage("PBKDF: 2048 итераций"),
    "height" : MessageLookupByLibrary.simpleMessage("Рост"),
    "heightEquals" : m11,
    "hide" : MessageLookupByLibrary.simpleMessage("Спрятать"),
    "homePage" : m12,
    "hoursDuration" : m13,
    "id" : MessageLookupByLibrary.simpleMessage("Я бы"),
    "ignore" : MessageLookupByLibrary.simpleMessage("игнорировать"),
    "insecureDeviceWarning" : MessageLookupByLibrary.simpleMessage("Предупреждение о небезопасном устройстве"),
    "insecureDeviceWarningDescription" : MessageLookupByLibrary.simpleMessage("Обнаружено рутированное или взломанное устройство. Дальнейшее использование не рекомендуется."),
    "insufficientFunds" : MessageLookupByLibrary.simpleMessage("Недостаточно средств"),
    "invalidAddress" : MessageLookupByLibrary.simpleMessage("Неверный адрес"),
    "invalidCurrency" : MessageLookupByLibrary.simpleMessage("Неверная валюта"),
    "invalidJson" : MessageLookupByLibrary.simpleMessage("Неверный JSON."),
    "invalidMnemonic" : MessageLookupByLibrary.simpleMessage("Неверная мнемоника"),
    "invalidPrivateKey" : MessageLookupByLibrary.simpleMessage("Неверный закрытый ключ."),
    "invalidPublicKey" : MessageLookupByLibrary.simpleMessage("Неверный открытый ключ."),
    "invalidUrl" : MessageLookupByLibrary.simpleMessage("Неверная ссылка."),
    "kiloHashPerSecond" : m14,
    "kiloQuantity" : m15,
    "language" : MessageLookupByLibrary.simpleMessage("язык"),
    "latestSeen" : MessageLookupByLibrary.simpleMessage("Последнее увиденное"),
    "license" : MessageLookupByLibrary.simpleMessage("Лицензия"),
    "listOfFour" : m16,
    "listOfThree" : m17,
    "listOfTwo" : m18,
    "loading" : MessageLookupByLibrary.simpleMessage("Loading ..."),
    "localeLanguage" : MessageLookupByLibrary.simpleMessage("английский"),
    "marketCap" : m19,
    "matured" : MessageLookupByLibrary.simpleMessage("созревший"),
    "matures" : MessageLookupByLibrary.simpleMessage("Matures"),
    "maturing" : MessageLookupByLibrary.simpleMessage("вызревание"),
    "maturingTransactions" : MessageLookupByLibrary.simpleMessage("Сроки погашения"),
    "maxMemoLength" : MessageLookupByLibrary.simpleMessage("Максимальная длина заметки 100"),
    "megaHashPerSecond" : m20,
    "megaQuantity" : m21,
    "memo" : MessageLookupByLibrary.simpleMessage("напоминание"),
    "menuOfOne" : m22,
    "menuOfTwo" : m23,
    "minAmount" : m24,
    "minFee" : m25,
    "minutesAndSecondsDuration" : m26,
    "minutesDuration" : m27,
    "name" : MessageLookupByLibrary.simpleMessage("название"),
    "nameMustBeUnique" : MessageLookupByLibrary.simpleMessage("Имя должно быть уникальным."),
    "network" : MessageLookupByLibrary.simpleMessage("сеть"),
    "networkOffline" : MessageLookupByLibrary.simpleMessage("Сеть оффлайн"),
    "networkType" : m28,
    "newPeer" : MessageLookupByLibrary.simpleMessage("New Peer"),
    "newWallet" : MessageLookupByLibrary.simpleMessage("Новый кошелек"),
    "next" : MessageLookupByLibrary.simpleMessage("следующий"),
    "noPrivateKeys" : MessageLookupByLibrary.simpleMessage("Нет закрытых ключей"),
    "noPublicKeys" : MessageLookupByLibrary.simpleMessage("Нет открытых ключей"),
    "nonce" : MessageLookupByLibrary.simpleMessage("данное время"),
    "numTransactions" : m29,
    "ok" : MessageLookupByLibrary.simpleMessage("Хорошо"),
    "password" : MessageLookupByLibrary.simpleMessage("пароль"),
    "passwordCantBeEmpty" : MessageLookupByLibrary.simpleMessage("Пароль не может быть пустым."),
    "passwordsDontMatch" : MessageLookupByLibrary.simpleMessage("Пароли не совпадают."),
    "payTo" : MessageLookupByLibrary.simpleMessage("Платить"),
    "peers" : MessageLookupByLibrary.simpleMessage("Сверстники"),
    "pending" : MessageLookupByLibrary.simpleMessage("в ожидании"),
    "petaHashPerSecond" : m30,
    "previous" : MessageLookupByLibrary.simpleMessage("предыдущий"),
    "privacyPolicy" : MessageLookupByLibrary.simpleMessage("политика конфиденциальности"),
    "privateKey" : MessageLookupByLibrary.simpleMessage("Закрытый ключ"),
    "privateKeyList" : MessageLookupByLibrary.simpleMessage("Список закрытых ключей"),
    "publicKeyList" : MessageLookupByLibrary.simpleMessage("Список открытых ключей"),
    "quantity" : m31,
    "receive" : MessageLookupByLibrary.simpleMessage("Получать"),
    "recentHistory" : MessageLookupByLibrary.simpleMessage("Недавняя история"),
    "requireSSLCert" : MessageLookupByLibrary.simpleMessage("Требовать SSL сертификат"),
    "result" : MessageLookupByLibrary.simpleMessage("Результат"),
    "search" : MessageLookupByLibrary.simpleMessage("Поиск"),
    "secondsDuration" : m32,
    "seedPhrase" : MessageLookupByLibrary.simpleMessage("Семенная фраза"),
    "seedPhraseWarning" : MessageLookupByLibrary.simpleMessage("Это семя позволяет любому, кто его знает, потратить все средства с вашего кошелька. Запиши это. Держать его в безопасности."),
    "send" : MessageLookupByLibrary.simpleMessage("послать"),
    "sendFailed" : MessageLookupByLibrary.simpleMessage("Не удалось отправить"),
    "sending" : MessageLookupByLibrary.simpleMessage("Посылка ..."),
    "sentTransactionId" : m33,
    "settings" : MessageLookupByLibrary.simpleMessage("настройки"),
    "show" : MessageLookupByLibrary.simpleMessage("Шоу"),
    "showWalletNameInTitle" : MessageLookupByLibrary.simpleMessage("Показать название кошелька в заголовке"),
    "state" : MessageLookupByLibrary.simpleMessage("государственный"),
    "support" : MessageLookupByLibrary.simpleMessage("Служба поддержки"),
    "target" : MessageLookupByLibrary.simpleMessage("цель"),
    "teraHashPerSecond" : m34,
    "teraQuantity" : m35,
    "thanksForDonating" : MessageLookupByLibrary.simpleMessage("Право на! Спасибо CRUZ сообществу!"),
    "theme" : MessageLookupByLibrary.simpleMessage("тема"),
    "time" : MessageLookupByLibrary.simpleMessage("Время"),
    "tip" : MessageLookupByLibrary.simpleMessage("Совет"),
    "title" : MessageLookupByLibrary.simpleMessage("Cruzall"),
    "to" : MessageLookupByLibrary.simpleMessage("к"),
    "toAddress" : m36,
    "totalBlocksInLastDuration" : m37,
    "transaction" : MessageLookupByLibrary.simpleMessage("Сделка"),
    "transactions" : MessageLookupByLibrary.simpleMessage("операции"),
    "unitTestBeforeCreatingWallets" : MessageLookupByLibrary.simpleMessage("Юнит тест перед созданием кошельков"),
    "unitTestFailure" : MessageLookupByLibrary.simpleMessage("Ошибка модульного теста"),
    "unknown" : MessageLookupByLibrary.simpleMessage("неизвестный"),
    "unknownAddress" : MessageLookupByLibrary.simpleMessage("Неизвестный адрес"),
    "unknownQuery" : MessageLookupByLibrary.simpleMessage("Неизвестный запрос"),
    "unlock" : MessageLookupByLibrary.simpleMessage("отпереть"),
    "unlockTitle" : MessageLookupByLibrary.simpleMessage("Разблокировать крузалл"),
    "url" : MessageLookupByLibrary.simpleMessage("URL"),
    "valueMustBePositive" : MessageLookupByLibrary.simpleMessage("Значение должно быть положительным"),
    "verify" : MessageLookupByLibrary.simpleMessage("проверить"),
    "verifyAddressFailed" : m38,
    "verifyKeyPairsEveryLoad" : MessageLookupByLibrary.simpleMessage("Проверяйте пары ключей при каждой загрузке"),
    "verifyWalletResults" : m39,
    "verifying" : MessageLookupByLibrary.simpleMessage("Проверка ..."),
    "version" : MessageLookupByLibrary.simpleMessage("Версия"),
    "warning" : MessageLookupByLibrary.simpleMessage("Предупреждение"),
    "watchOnlyWallet" : MessageLookupByLibrary.simpleMessage("Часы только кошелек"),
    "welcomeDesc" : MessageLookupByLibrary.simpleMessage("Для начала создайте кошелек:"),
    "welcomeTitle" : MessageLookupByLibrary.simpleMessage("Добро пожаловать в Крузалл")
  };
}