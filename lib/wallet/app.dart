// Copyright 2019 cruzall developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:flutter_web/foundation.dart'
    if (dart.library.io) 'package:flutter/foundation.dart';
import 'package:flutter_web/material.dart'
    if (dart.library.io) 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import 'package:cruzawl/currency.dart';
import 'package:cruzawl/wallet.dart';

import '../explorer/settings.dart';
import '../localization.dart';
import '../model.dart';
import '../routes.dart';
import '../ui.dart';
import 'add.dart';
import 'send.dart';
import 'settings.dart';
import 'wallet.dart';

class WelcomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Localization locale = Localization.of(context);
    final Cruzawl appState = ScopedModel.of<Cruzawl>(context);
    return SimpleScaffold(
      Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 32),
            child: Text(locale.welcomeDesc),
          ),
          Expanded(
            child: AddWalletWidget(appState, welcome: true),
          ),
        ],
      ),
      title: locale.welcomeTitle,
    );
  }
}

class UnlockWalletWidget extends StatefulWidget {
  @override
  _UnlockWalletWidgetState createState() => _UnlockWalletWidgetState();
}

class _UnlockWalletWidgetState extends State<UnlockWalletWidget> {
  final formKey = GlobalKey<FormState>();
  String password;

  @override
  Widget build(BuildContext c) {
    final Cruzawl appState = ScopedModel.of<Cruzawl>(context);
    final Localization locale = Localization.of(context);

    return SimpleScaffold(
      Form(
        key: formKey,
        child: ListView(children: <Widget>[
          ListTile(
            subtitle: TextFormField(
              autofocus: true,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: locale.password,
              ),
              validator: (value) {
                if (!(value.length > 0)) return locale.passwordCantBeEmpty;
                return null;
              },
              onSaved: (val) => password = val,
            ),
          ),
          RaisedGradientButton(
            labelText: locale.unlock,
            padding: EdgeInsets.all(32),
            onPressed: () {
              if (!formKey.currentState.validate()) return;
              formKey.currentState.save();
              formKey.currentState.reset();
              if (appState.unlockWallets(password))
                appState.setState(() => appState.openWallets());
            },
          ),
        ]),
      ),
      title: locale.unlockTitle,
    );
  }
}

class WalletApp extends StatefulWidget {
  final Cruzawl appState;
  final List<LocalizationsDelegate> localizationsDelegates;
  final FutureStringFunction initialUri;
  final Stream<String> uriStream;
  WalletApp(this.appState, this.localizationsDelegates,
      [this.initialUri, this.uriStream]);

  @override
  WalletAppState createState() => WalletAppState();
}

class WalletAppState extends State<WalletApp> with WidgetsBindingObserver {
  DateTime paused;

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    widget.appState.runQuickTestVector();

    if (!widget.appState.preferences.walletsEncrypted)
      widget.appState.openWallets();

    for (Currency currency in currencies)
      widget.appState.connectPeers(currency);
  }

  @override
  Widget build(BuildContext context) {
    final Cruzawl appState =
        ScopedModel.of<Cruzawl>(context, rebuildOnChange: true);

    if (appState.wallets.length == 0) {
      if (appState.fatal != null)
        return MaterialApp(
          theme: appState.theme.data,
          debugShowCheckedModeBanner: false,
          locale: appState.localeOverride,
          supportedLocales: Localization.supportedLocales,
          localizationsDelegates: widget.localizationsDelegates,
          onGenerateTitle: (BuildContext context) =>
              Localization.of(context).title,
          home: SimpleScaffold(ErrorWidget.builder(appState.fatal)),
        );

      if (appState.preferences.walletsEncrypted)
        return MaterialApp(
          theme: appState.theme.data,
          debugShowCheckedModeBanner: false,
          locale: appState.localeOverride,
          supportedLocales: Localization.supportedLocales,
          localizationsDelegates: widget.localizationsDelegates,
          onGenerateTitle: (BuildContext context) =>
              Localization.of(context).title,
          home: UnlockWalletWidget(),
        );

      return MaterialApp(
        theme: appState.theme.data,
        debugShowCheckedModeBanner: false,
        locale: appState.localeOverride,
        supportedLocales: Localization.supportedLocales,
        localizationsDelegates: widget.localizationsDelegates,
        onGenerateTitle: (BuildContext context) =>
            Localization.of(context).title,
        home: WelcomeWidget(),
      );
    }

    final Wallet wallet = appState.wallet.wallet;
    return ScopedModel(
        model: appState.wallet,
        child: MaterialApp(
            theme: appState.theme.data,
            debugShowCheckedModeBanner: false,
            locale: appState.localeOverride,
            supportedLocales: Localization.supportedLocales,
            localizationsDelegates: widget.localizationsDelegates,
            onGenerateTitle: (BuildContext context) =>
                Localization.of(context).title,
            home: WalletWidget(
                wallet, appState, widget.initialUri, widget.uriStream),
            routes: <String, WidgetBuilder>{
              '/wallet': (BuildContext context) => SimpleScaffold(
                  WalletSettingsWidget(wallet),
                  title: wallet.name),
              '/addWallet': (BuildContext context) => SimpleScaffold(
                  AddWalletWidget(appState),
                  title: Localization.of(context).newWallet),
              '/sendFrom': (BuildContext context) => SimpleScaffold(
                  SendFromWidget(wallet),
                  title: Localization.of(context).from),
              '/enableEncryption': (BuildContext context) => SimpleScaffold(
                  EnableEncryptionWidget(),
                  title: Localization.of(context).encryption),
            },
            onGenerateRoute: CruzawlRoutes(appState,
                    includeWalletRoutes: true, cruzbaseSearchBar: true)
                .onGenerateRoute));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    debugPrint('didChangeAppLifecycleState $state');
    if (state == AppLifecycleState.paused) {
      paused = DateTime.now();
    } else if (state == AppLifecycleState.resumed) {
      Duration pausedDuration = DateTime.now().difference(paused);
      if (pausedDuration.inMinutes > 0)
        for (Currency currency in currencies)
          widget.appState.reconnectPeers(currency);
    }
  }
}