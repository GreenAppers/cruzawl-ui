// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that looks up messages for specific locales by
// delegating to the appropriate library.

import 'dart:async';

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';
// ignore: implementation_imports
import 'package:intl/src/intl_helpers.dart';

import 'messages_cs.dart' as messages_cs;
import 'messages_de.dart' as messages_de;
import 'messages_en.dart' as messages_en;
import 'messages_es.dart' as messages_es;
import 'messages_id.dart' as messages_id;
import 'messages_ja.dart' as messages_ja;
import 'messages_kr.dart' as messages_kr;
import 'messages_ms.dart' as messages_ms;
import 'messages_ru.dart' as messages_ru;
import 'messages_zh.dart' as messages_zh;

typedef Future<dynamic> LibraryLoader();
Map<String, LibraryLoader> _deferredLibraries = {
// ignore: unnecessary_new
  'cs': () => new Future.value(null),
// ignore: unnecessary_new
  'de': () => new Future.value(null),
// ignore: unnecessary_new
  'en': () => new Future.value(null),
// ignore: unnecessary_new
  'es': () => new Future.value(null),
// ignore: unnecessary_new
  'id': () => new Future.value(null),
// ignore: unnecessary_new
  'ja': () => new Future.value(null),
// ignore: unnecessary_new
  'kr': () => new Future.value(null),
// ignore: unnecessary_new
  'ms': () => new Future.value(null),
// ignore: unnecessary_new
  'ru': () => new Future.value(null),
// ignore: unnecessary_new
  'zh': () => new Future.value(null),
};

MessageLookupByLibrary _findExact(localeName) {
  switch (localeName) {
    case 'cs':
      return messages_cs.messages;
    case 'de':
      return messages_de.messages;
    case 'en':
      return messages_en.messages;
    case 'es':
      return messages_es.messages;
    case 'id':
      return messages_id.messages;
    case 'ja':
      return messages_ja.messages;
    case 'kr':
      return messages_kr.messages;
    case 'ms':
      return messages_ms.messages;
    case 'ru':
      return messages_ru.messages;
    case 'zh':
      return messages_zh.messages;
    default:
      return null;
  }
}

/// User programs should call this before using [localeName] for messages.
Future<bool> initializeMessages(String localeName) async {
  var availableLocale = Intl.verifiedLocale(
    localeName,
    (locale) => _deferredLibraries[locale] != null,
    onFailure: (_) => null);
  if (availableLocale == null) {
    // ignore: unnecessary_new
    return new Future.value(false);
  }
  var lib = _deferredLibraries[availableLocale];
  // ignore: unnecessary_new
  await (lib == null ? new Future.value(false) : lib());
  // ignore: unnecessary_new
  initializeInternalMessageLookup(() => new CompositeMessageLookup());
  messageLookup.addLocale(availableLocale, _findGeneratedMessagesFor);
  // ignore: unnecessary_new
  return new Future.value(true);
}

bool _messagesExistFor(String locale) {
  try {
    return _findExact(locale) != null;
  } catch (e) {
    return false;
  }
}

MessageLookupByLibrary _findGeneratedMessagesFor(locale) {
  var actualLocale = Intl.verifiedLocale(locale, _messagesExistFor,
      onFailure: (_) => null);
  if (actualLocale == null) return null;
  return _findExact(actualLocale);
}
