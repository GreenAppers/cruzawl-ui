// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
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
  String get localeName => 'es';

  static m0(address) => "Dirección ${address}";

  static m1(height) => "Su saldo a la altura del bloque {@<a>} ${height} {@</a>} es:";

  static m2(height) => "Su saldo que vence por altura ${height} es:";

  static m3(ticker, balance) => "${ticker} + ${balance}";

  static m4(algorithm) => "Creando ... ( ${algorithm} )";

  static m5(days) => "${Intl.plural(days, one: 'día', other: '${days} días')}";

  static m6(exaHashPerSecond) => "${exaHashPerSecond} EH / s";

  static m7(address) => "De: ${address}";

  static m8(gigaHashPerSecond) => "${gigaHashPerSecond} GH / s";

  static m9(hashPerSecond) => "${hashPerSecond} H / s";

  static m10(height) => "height = {@<a>} ${height} {@</a>}";

  static m11(product) => "${product} Página de inicio";

  static m12(hours) => "${Intl.plural(hours, one: 'hora', other: '${hours} horas')}";

  static m13(kiloHashPerSecond) => "${kiloHashPerSecond} KH / s";

  static m14(item1, item2, item3, item4) => "${item1} , ${item2} , ${item3} , ${item4}";

  static m15(item1, item2, item3) => "${item1} , ${item2} , ${item3}";

  static m16(item1, item2) => "${item1} , ${item2}";

  static m17(cap) => "Capitalización de mercado {@<a>} ${cap} {@</a>}";

  static m18(megaHashPerSecond) => "${megaHashPerSecond} MH / s";

  static m19(item) => "[ {@<a>} ${item} {@</a>} ]";

  static m20(item1, item2) => "[ {@<a1>} ${item1} {@</a1>} , {@<a2>} ${item2} {@</a2>} ]";

  static m21(amount) => "La cantidad mínima es ${amount}";

  static m22(fee) => "La tarifa mínima es ${fee}";

  static m23(minutes, seconds) => "${minutes} ${seconds}";

  static m24(minutes) => "${Intl.plural(minutes, one: '${minutes} minuto', other: '${minutes} minutos')}";

  static m25(type) => "${type} Red";

  static m26(number) => "Transacciones ( ${number} )";

  static m27(petaHashPerSecond) => "${petaHashPerSecond} PH / s";

  static m28(seconds) => "${Intl.plural(seconds, one: '${seconds} segundo', other: '${seconds} segundos')}";

  static m29(transactionId) => "Enviado ${transactionId} ID de ${transactionId}";

  static m30(teraHashPerSecond) => "${teraHashPerSecond} TH / s";

  static m31(address) => "Para: ${address}";

  static m32(totalBlocks, duration) => "${totalBlocks} {@<a1>} bloquea {@</a1>} en los últimos {@<a2>} ${duration} {@</a2>}";

  static m33(totalBlocks, totalTransactions, duration) => "${totalBlocks} {@<a1>} bloquea {@</a1>} , ${totalTransactions} transacciones en las últimas {@<a2>} ${duration} {@</a2>}";

  static m34(addressText) => "verificación fallida: ${addressText}";

  static m35(goodAddresses, totalAddresses, goodTests, totalTests) => "Se verificaron las ${goodAddresses} / ${totalAddresses} y ${goodTests} / ${totalTests}";

  static m36(walletName, accountId, chainIndex) => "${walletName}: Cuenta ${accountId}, Dirección ${chainIndex}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "account" : MessageLookupByLibrary.simpleMessage("Cuenta"),
    "accounts" : MessageLookupByLibrary.simpleMessage("Cuentas"),
    "activeTransactions" : MessageLookupByLibrary.simpleMessage("Transacciones activas"),
    "addWallet" : MessageLookupByLibrary.simpleMessage("Agregar billetera"),
    "address" : MessageLookupByLibrary.simpleMessage("Dirección"),
    "addressMustBeUnique" : MessageLookupByLibrary.simpleMessage("La dirección debe ser única."),
    "addressStateOpen" : MessageLookupByLibrary.simpleMessage("abierto"),
    "addressStateReserve" : MessageLookupByLibrary.simpleMessage("reserva"),
    "addressStateUsed" : MessageLookupByLibrary.simpleMessage("usado"),
    "addressTitle" : m0,
    "addresses" : MessageLookupByLibrary.simpleMessage("Direcciones"),
    "amount" : MessageLookupByLibrary.simpleMessage("Cantidad"),
    "backupKeysWarning" : MessageLookupByLibrary.simpleMessage("Sus claves deben estar respaldadas en almacenamiento externo."),
    "balance" : MessageLookupByLibrary.simpleMessage("Equilibrar"),
    "balanceAtHeightIs" : m1,
    "balanceMaturingByHeightIs" : m2,
    "balanceTitle" : m3,
    "block" : MessageLookupByLibrary.simpleMessage("Bloquear"),
    "blocks" : MessageLookupByLibrary.simpleMessage("Bloques"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Cancelar"),
    "cantDeleteOnlyWallet" : MessageLookupByLibrary.simpleMessage("No se puede eliminar la única billetera."),
    "chainCode" : MessageLookupByLibrary.simpleMessage("Código de cadena"),
    "chainIndex" : MessageLookupByLibrary.simpleMessage("Índice de cadena"),
    "chainWork" : MessageLookupByLibrary.simpleMessage("Trabajo en cadena"),
    "confirmPassword" : MessageLookupByLibrary.simpleMessage("Confirmar contraseña"),
    "confirmations" : MessageLookupByLibrary.simpleMessage("Confirmaciones"),
    "connected" : MessageLookupByLibrary.simpleMessage("Conectada"),
    "console" : MessageLookupByLibrary.simpleMessage("Consola"),
    "contacts" : MessageLookupByLibrary.simpleMessage("Contactos"),
    "copied" : MessageLookupByLibrary.simpleMessage("Copiado"),
    "copy" : MessageLookupByLibrary.simpleMessage("Dupdo"),
    "copyPublicKeys" : MessageLookupByLibrary.simpleMessage("Copiar claves públicas"),
    "create" : MessageLookupByLibrary.simpleMessage("Crear"),
    "creating" : MessageLookupByLibrary.simpleMessage("Creando ..."),
    "creatingUsingAlgorithm" : m4,
    "cruzTicker" : MessageLookupByLibrary.simpleMessage("CRUZ"),
    "currency" : MessageLookupByLibrary.simpleMessage("Moneda"),
    "currentBalanceIs" : MessageLookupByLibrary.simpleMessage("Tu saldo actual es:"),
    "dangerZone" : MessageLookupByLibrary.simpleMessage("Zona peligrosa"),
    "date" : MessageLookupByLibrary.simpleMessage("Fecha"),
    "daysDuration" : m5,
    "debugLog" : MessageLookupByLibrary.simpleMessage("Registro de depuración"),
    "defaultWalletName" : MessageLookupByLibrary.simpleMessage("Mi billetera"),
    "delete" : MessageLookupByLibrary.simpleMessage("Borrar"),
    "deletePeer" : MessageLookupByLibrary.simpleMessage("Eliminar par"),
    "deleteThisWallet" : MessageLookupByLibrary.simpleMessage("Eliminar esta billetera"),
    "deleteWallet" : MessageLookupByLibrary.simpleMessage("Eliminar billetera"),
    "deleteWalletDescription" : MessageLookupByLibrary.simpleMessage("Una vez que eliminas una billetera, no hay vuelta atrás. Por favor, esté seguro"),
    "deltaHashPower" : MessageLookupByLibrary.simpleMessage("Delta Hash Power"),
    "deltaTime" : MessageLookupByLibrary.simpleMessage("Hora Delta"),
    "donations" : MessageLookupByLibrary.simpleMessage("Donaciones"),
    "duration" : MessageLookupByLibrary.simpleMessage("Duración"),
    "earliestSeen" : MessageLookupByLibrary.simpleMessage("Visto más temprano"),
    "email" : MessageLookupByLibrary.simpleMessage("Email"),
    "encrypt" : MessageLookupByLibrary.simpleMessage("Encriptar"),
    "encryption" : MessageLookupByLibrary.simpleMessage("Cifrado"),
    "exaHashPerSecond" : m6,
    "expired" : MessageLookupByLibrary.simpleMessage("Muerto"),
    "expires" : MessageLookupByLibrary.simpleMessage("Expira"),
    "externalAddress" : MessageLookupByLibrary.simpleMessage("Dirección Externa"),
    "fee" : MessageLookupByLibrary.simpleMessage("Cuota"),
    "from" : MessageLookupByLibrary.simpleMessage("Desde"),
    "fromAddress" : m7,
    "generateNewAddress" : MessageLookupByLibrary.simpleMessage("Generar nueva dirección"),
    "gigaHashPerSecond" : m8,
    "hashListRoot" : MessageLookupByLibrary.simpleMessage("Hash List Root"),
    "hashPerSecond" : m9,
    "hdWallet" : MessageLookupByLibrary.simpleMessage("Billetera HD"),
    "hdWalletAlgorithm" : MessageLookupByLibrary.simpleMessage("PBKDF: 2048 iteraciones"),
    "height" : MessageLookupByLibrary.simpleMessage("Altura"),
    "heightEquals" : m10,
    "hide" : MessageLookupByLibrary.simpleMessage("Esconder"),
    "home" : MessageLookupByLibrary.simpleMessage("Casa"),
    "homePage" : m11,
    "hoursDuration" : m12,
    "id" : MessageLookupByLibrary.simpleMessage("Carné de identidad"),
    "ignore" : MessageLookupByLibrary.simpleMessage("Ignorar"),
    "insecureDeviceWarning" : MessageLookupByLibrary.simpleMessage("Advertencia de dispositivo inseguro"),
    "insecureDeviceWarningDescription" : MessageLookupByLibrary.simpleMessage("Se ha detectado un dispositivo rooteado o con jailbreak. Uso adicional no recomendado."),
    "insufficientFunds" : MessageLookupByLibrary.simpleMessage("Fondos insuficientes"),
    "invalidAddress" : MessageLookupByLibrary.simpleMessage("Dirección inválida"),
    "invalidCurrency" : MessageLookupByLibrary.simpleMessage("Moneda inválida"),
    "invalidJson" : MessageLookupByLibrary.simpleMessage("JSON inválido."),
    "invalidMnemonic" : MessageLookupByLibrary.simpleMessage("Mnemotécnico inválido"),
    "invalidPrivateKey" : MessageLookupByLibrary.simpleMessage("Clave privada inválida."),
    "invalidPublicKey" : MessageLookupByLibrary.simpleMessage("Clave pública no válida"),
    "invalidUrl" : MessageLookupByLibrary.simpleMessage("URL invalida."),
    "kiloHashPerSecond" : m13,
    "language" : MessageLookupByLibrary.simpleMessage("Idioma"),
    "latestSeen" : MessageLookupByLibrary.simpleMessage("Último visto"),
    "license" : MessageLookupByLibrary.simpleMessage("Licencia"),
    "listOfFour" : m14,
    "listOfThree" : m15,
    "listOfTwo" : m16,
    "loading" : MessageLookupByLibrary.simpleMessage("Cargando..."),
    "localeLanguage" : MessageLookupByLibrary.simpleMessage("Español"),
    "marketCap" : m17,
    "matured" : MessageLookupByLibrary.simpleMessage("Madurado"),
    "matures" : MessageLookupByLibrary.simpleMessage("Madura"),
    "maturing" : MessageLookupByLibrary.simpleMessage("Madurando"),
    "maturingTransactions" : MessageLookupByLibrary.simpleMessage("Transacciones maduras"),
    "maxMemoLength" : MessageLookupByLibrary.simpleMessage("La longitud máxima de la nota es 100"),
    "megaHashPerSecond" : m18,
    "memo" : MessageLookupByLibrary.simpleMessage("Memorándum"),
    "menuOfOne" : m19,
    "menuOfTwo" : m20,
    "minAmount" : m21,
    "minFee" : m22,
    "minutesAndSecondsDuration" : m23,
    "minutesDuration" : m24,
    "name" : MessageLookupByLibrary.simpleMessage("Nombre"),
    "nameMustBeUnique" : MessageLookupByLibrary.simpleMessage("El nombre debe ser único."),
    "network" : MessageLookupByLibrary.simpleMessage("Red"),
    "networkOffline" : MessageLookupByLibrary.simpleMessage("Red fuera de línea"),
    "networkType" : m25,
    "newContact" : MessageLookupByLibrary.simpleMessage("Nuevo contacto"),
    "newPeer" : MessageLookupByLibrary.simpleMessage("Nuevo par"),
    "newWallet" : MessageLookupByLibrary.simpleMessage("Nueva billetera"),
    "next" : MessageLookupByLibrary.simpleMessage("próximo"),
    "noPrivateKeys" : MessageLookupByLibrary.simpleMessage("Sin claves privadas"),
    "noPublicKeys" : MessageLookupByLibrary.simpleMessage("Sin claves públicas"),
    "nonce" : MessageLookupByLibrary.simpleMessage("Mientras tanto"),
    "numTransactions" : m26,
    "ok" : MessageLookupByLibrary.simpleMessage("Okay"),
    "password" : MessageLookupByLibrary.simpleMessage("Contraseña"),
    "passwordCantBeEmpty" : MessageLookupByLibrary.simpleMessage("La contraseña no puede estar vacía."),
    "passwordsDontMatch" : MessageLookupByLibrary.simpleMessage("Las contraseñas no coinciden."),
    "paste" : MessageLookupByLibrary.simpleMessage("Pegar"),
    "payTo" : MessageLookupByLibrary.simpleMessage("Pagar a"),
    "peers" : MessageLookupByLibrary.simpleMessage("Pares"),
    "pending" : MessageLookupByLibrary.simpleMessage("Pendiente"),
    "petaHashPerSecond" : m27,
    "previous" : MessageLookupByLibrary.simpleMessage("Anterior"),
    "privacyPolicy" : MessageLookupByLibrary.simpleMessage("Política de privacidad"),
    "privateKey" : MessageLookupByLibrary.simpleMessage("Llave privada"),
    "privateKeyList" : MessageLookupByLibrary.simpleMessage("Lista de claves privadas"),
    "publicKeyList" : MessageLookupByLibrary.simpleMessage("Lista de clave pública"),
    "receive" : MessageLookupByLibrary.simpleMessage("Recibir"),
    "recentHistory" : MessageLookupByLibrary.simpleMessage("Historia reciente"),
    "requireSSLCert" : MessageLookupByLibrary.simpleMessage("Requerir certificado SSL"),
    "result" : MessageLookupByLibrary.simpleMessage("Resultado"),
    "search" : MessageLookupByLibrary.simpleMessage("Buscar"),
    "secondsDuration" : m28,
    "seedPhrase" : MessageLookupByLibrary.simpleMessage("Frase de semillas"),
    "seedPhraseWarning" : MessageLookupByLibrary.simpleMessage("Esta semilla permite que cualquiera que lo sepa gaste todos los fondos de su billetera. Escríbelo. Manténlo seguro."),
    "send" : MessageLookupByLibrary.simpleMessage("Enviar"),
    "sendFailed" : MessageLookupByLibrary.simpleMessage("Envio fallido"),
    "sending" : MessageLookupByLibrary.simpleMessage("Enviando..."),
    "sentTransactionId" : m29,
    "settings" : MessageLookupByLibrary.simpleMessage("Configuraciones"),
    "show" : MessageLookupByLibrary.simpleMessage("mostrar"),
    "showWalletNameInTitle" : MessageLookupByLibrary.simpleMessage("Mostrar el nombre de la billetera en el título"),
    "state" : MessageLookupByLibrary.simpleMessage("Estado"),
    "submit" : MessageLookupByLibrary.simpleMessage("Enviar"),
    "support" : MessageLookupByLibrary.simpleMessage("Apoyo"),
    "target" : MessageLookupByLibrary.simpleMessage("Objetivo"),
    "teraHashPerSecond" : m30,
    "thanksForDonating" : MessageLookupByLibrary.simpleMessage("¡Tocar el asunto exacto! Gracias comunidad CRUZ!"),
    "theme" : MessageLookupByLibrary.simpleMessage("Tema"),
    "time" : MessageLookupByLibrary.simpleMessage("Hora"),
    "tip" : MessageLookupByLibrary.simpleMessage("Propina"),
    "title" : MessageLookupByLibrary.simpleMessage("Cruzall"),
    "to" : MessageLookupByLibrary.simpleMessage("A"),
    "toAddress" : m31,
    "totalBlocksInLastDuration" : m32,
    "totalBlocksTransactionsInLastDuration" : m33,
    "transaction" : MessageLookupByLibrary.simpleMessage("Transacción"),
    "transactions" : MessageLookupByLibrary.simpleMessage("Actas"),
    "typingAddressesWarning" : MessageLookupByLibrary.simpleMessage("Advertencia: escribir direcciones a mano es peligroso y propenso a errores. Utilice siempre el botón copiar o el escáner QR."),
    "unitTestBeforeCreatingWallets" : MessageLookupByLibrary.simpleMessage("Prueba unitaria antes de crear billeteras"),
    "unitTestFailure" : MessageLookupByLibrary.simpleMessage("Falla de prueba de unidad"),
    "unknown" : MessageLookupByLibrary.simpleMessage("Desconocido"),
    "unknownAddress" : MessageLookupByLibrary.simpleMessage("Dirección desconocida"),
    "unknownQuery" : MessageLookupByLibrary.simpleMessage("Consulta desconocida"),
    "unlock" : MessageLookupByLibrary.simpleMessage("desbloquear"),
    "unlockTitle" : MessageLookupByLibrary.simpleMessage("Desbloqueo Cruzall"),
    "url" : MessageLookupByLibrary.simpleMessage("URL"),
    "valueMustBePositive" : MessageLookupByLibrary.simpleMessage("El valor debe ser positivo."),
    "verify" : MessageLookupByLibrary.simpleMessage("Verificar"),
    "verifyAddressFailed" : m34,
    "verifyKeyPairsEveryLoad" : MessageLookupByLibrary.simpleMessage("Verifique los pares de claves en cada carga"),
    "verifyWalletResults" : m35,
    "verifying" : MessageLookupByLibrary.simpleMessage("Verificando ..."),
    "version" : MessageLookupByLibrary.simpleMessage("Versión"),
    "walletAccountName" : m36,
    "wallets" : MessageLookupByLibrary.simpleMessage("Carteras"),
    "warning" : MessageLookupByLibrary.simpleMessage("Advertencia"),
    "watchOnlyWallet" : MessageLookupByLibrary.simpleMessage("Cartera de solo reloj"),
    "welcomeDesc" : MessageLookupByLibrary.simpleMessage("Para comenzar, cree una billetera:"),
    "welcomeTitle" : MessageLookupByLibrary.simpleMessage("Bienvenido a Cruzall")
  };
}
