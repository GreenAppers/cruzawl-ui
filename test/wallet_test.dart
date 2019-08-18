// Copyright 2019 cruzall developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sembast/sembast_memory.dart';

import 'package:cruzawl/preferences.dart';
import 'package:cruzawl/test.dart';
import 'package:cruzawl/util.dart';
import 'package:cruzawl/wallet.dart';

import 'package:cruzawl_ui/localization.dart';
import 'package:cruzawl_ui/model.dart';
import 'package:cruzawl_ui/ui.dart';
import 'package:cruzawl_ui/wallet/add.dart';
import 'package:cruzawl_ui/wallet/settings.dart';

void main() async {
  List<LocalizationsDelegate> localizationsDelegates =  <LocalizationsDelegate>[
    LocalizationDelegate(),
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate
  ];
  List<Locale> supportedLocales = <Locale>[ Locale('en') ];

  CruzawlPreferences preferences = CruzawlPreferences(
      await databaseFactoryMemoryFs.openDatabase('settings.db'));
  await preferences.load();
  preferences.networkEnabled = false;
  preferences.minimumReserveAddress = 3;
  SetClipboardText stringCallback = (BuildContext c, String x) {};
  Cruzawl appState = Cruzawl((String x) => x, stringCallback, stringCallback,
      databaseFactoryMemoryFs, preferences, '/', NullFileSystem());

  testWidgets('AddWalletWidget', (WidgetTester tester) async {
    expect(appState.wallets.length, 0);
    AddWalletWidget addWallet = AddWalletWidget(appState);
    await tester.pumpWidget(ScopedModel(
        model: appState,
        child: MaterialApp(
            localizationsDelegates: localizationsDelegates,
            supportedLocales: supportedLocales,
            home: SimpleScaffold(AddWalletWidget(appState), title: 'Add Wallet'))));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(RaisedGradientButton));
    await tester.pump(Duration(seconds: 1));
    await tester.pump(Duration(seconds: 2));
    expect(appState.wallets.length, 1);
    expect(appState.wallet.wallet.addresses.length,
        preferences.minimumReserveAddress);
  });

  testWidgets('WalletSettingsWidget Verify', (WidgetTester tester) async {
    Wallet wallet = appState.wallet.wallet;
    await tester.pumpWidget(ScopedModel(
        model: appState,
        child: MaterialApp(
            localizationsDelegates: localizationsDelegates,
            supportedLocales: supportedLocales,
            home: SimpleScaffold(WalletSettingsWidget(wallet),
                title: wallet.name))));
    await tester.pumpAndSettle();
    await tester.drag(find.text('Addresses'), Offset(0.0, -400));
    await tester.pump();
    await tester.tap(find.widgetWithText(RaisedGradientButton, 'Verify'));
    await tester.pump(Duration(seconds: 1));
    await tester.pump(Duration(seconds: 2));
    expect(find.text('Verified 3/3 addresses and 11/11 tests succeeded'),
        findsOneWidget);
  });
}