// Copyright 2019 cruzall developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

/// Widgets for running cruzawl [Wallet] app.
library wallet_app;

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import 'package:cruzawl/currency.dart';
import 'package:cruzawl/wallet.dart';

import 'package:cruzawl_ui/explorer/settings.dart';
import 'package:cruzawl_ui/localization.dart';
import 'package:cruzawl_ui/model.dart';
import 'package:cruzawl_ui/routes.dart';
import 'package:cruzawl_ui/ui.dart';
import 'package:cruzawl_ui/wallet/add.dart';
import 'package:cruzawl_ui/wallet/contacts.dart';
import 'package:cruzawl_ui/wallet/settings.dart';
import 'package:cruzawl_ui/wallet/wallet.dart';

/// Displayed on app's first run.
class WelcomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Localization l10n = Localization.of(context);
    final Cruzawl appState = ScopedModel.of<Cruzawl>(context);
    return SimpleScaffold(
      Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 32),
            child: Text(l10n.welcomeDesc),
          ),
          Expanded(
            child: AddWalletWidget(appState, welcome: true),
          ),
        ],
      ),
      title: l10n.welcomeTitle,
    );
  }
}

/// Displayed on app init when encryption is enabled.
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
    final Localization l10n = Localization.of(context);

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
                labelText: l10n.password,
              ),
              validator: (value) {
                if (value.isEmpty) return l10n.passwordCantBeEmpty;
                return null;
              },
              onSaved: (val) => password = val,
            ),
          ),
          RaisedGradientButton(
            labelText: l10n.unlock,
            padding: EdgeInsets.all(32),
            onPressed: () async {
              if (!formKey.currentState.validate()) return;
              formKey.currentState.save();
              formKey.currentState.reset();
              if (appState.unlockWallets(password)) {
                await appState.openWallets();
                appState.setState((){});
              }
            },
          ),
        ]),
      ),
      title: l10n.unlockTitle,
    );
  }
}

/// Forwards to either [WelcomeWidget], [UnlockWalletWidget], [WalletWidget], or [ErrorWidget].
class WalletApp extends StatefulWidget {
  /// The [Model] for this app.
  final Cruzawl appState;

  /// The [LocalizationsDelgate]s to use for this app.
  final List<LocalizationsDelegate> localizationsDelegates;

  /// Returns the URI causing this app to open, if any.
  final FutureStringFunction initialUri;

  /// Called with URIs handled by this app, if any.
  final Stream<String> uriStream;

  WalletApp(this.appState, this.localizationsDelegates,
      [this.initialUri, this.uriStream]);

  @override
  WalletAppState createState() => WalletAppState();
}

class WalletAppState extends State<WalletApp> with WidgetsBindingObserver {
  /// The time this app was last paused.
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

    if (widget.appState.wallets.isEmpty &&
        !widget.appState.preferences.walletsEncrypted) {
      widget.appState.openWallets();
    }

    if (widget.appState.preferences.networkEnabled) {
      for (Currency currency in currencies) {
        widget.appState.connectPeers(currency);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Cruzawl appState =
        ScopedModel.of<Cruzawl>(context, rebuildOnChange: true);

    if (appState.wallets.isEmpty) {
      if (appState.fatal != null) {
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
      }

      if (appState.preferences.walletsEncrypted) {
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
      }

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
              '/addContact': (BuildContext context) => SimpleScaffold(
                  AddContactWidget(),
                  title: Localization.of(context).newContact),
              '/settings/contacts': (BuildContext context) =>
                  ContactsWidget(editing: true),
              '/contacts': (BuildContext context) => ContactsWidget(),
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
    } else if (state == AppLifecycleState.resumed && paused != null) {
      Duration pausedDuration = DateTime.now().difference(paused);
      if (pausedDuration.inMinutes > 0) {
        for (Currency currency in currencies) {
          widget.appState.reconnectPeers(currency);
        }
      }
    }
  }
}
