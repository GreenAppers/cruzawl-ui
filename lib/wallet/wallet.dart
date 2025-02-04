// Copyright 2019 cruzawl developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

/// Widgets for navigating cruzawl [Wallet] app.
library wallet_wallet;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:gradient_app_bar/gradient_app_bar.dart';

import 'package:cruzawl/currency.dart';
import 'package:cruzawl/wallet.dart';

import 'package:cruzawl_ui/localization.dart';
import 'package:cruzawl_ui/model.dart';
import 'package:cruzawl_ui/ui.dart';

import 'balance.dart';
import 'receive.dart';
import 'send.dart';

typedef FutureStringFunction = Future<String> Function();

/// Main wallet [TabBarView] with Receive, Balance, Send.
class WalletWidget extends StatefulWidget {
  final Wallet wallet;
  final Cruzawl appState;
  final FutureStringFunction initialUri;
  final Stream<String> uriStream;
  WalletWidget(this.wallet, this.appState, [this.initialUri, this.uriStream]);

  @override
  _WalletWidgetState createState() => _WalletWidgetState();
}

class _WalletWidgetState extends State<WalletWidget> {
  StreamSubscription uriSubscription;
  Uri uri;

  @override
  void dispose() {
    if (uriSubscription != null) uriSubscription.cancel();
    super.dispose();
  }

  /// Shows "Insecure Device Warning" if [Cruzawl.isTrustFall].
  @override
  void initState() {
    super.initState();

    if (widget.appState.isTrustFall &&
        widget.appState.preferences.insecureDeviceWarning) {
      Future.delayed(Duration(seconds: 0)).then((_) => showDialog(
          context: context,
          builder: (context) {
            final Localization l10n = Localization.of(context);
            return AlertDialog(
              title: Text(l10n.insecureDeviceWarning),
              content: Text(l10n.insecureDeviceWarningDescription,
                  style: TextStyle(color: Colors.red)),
              actions: <Widget>[
                FlatButton(
                  child: Text(l10n.ignore),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
            );
          }));
    }

    if (widget.uriStream != null) initUriHandling();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Currency currency = widget.wallet.currency;
    final Localization l10n = Localization.of(context);

    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        appBar: GradientAppBar(
          centerTitle: true,
          title: Text(
            l10n.balanceTitle(l10n.ticker(currency.ticker),
                currency.format(widget.wallet.balance)),
            overflow: TextOverflow.ellipsis,
            style: widget.appState.theme.titleStyle,
          ),
          backgroundColorStart: theme.primaryColor,
          backgroundColorEnd: theme.accentColor,
          leading:
              Tooltip(message: l10n.wallets, child: buildWalletsMenu(context)),
          actions: <Widget>[
            (PopupMenuBuilder()
                  ..addItem(
                    icon: Icons.settings,
                    text: l10n.settings,
                    onSelected: () =>
                        widget.appState.navigateToSettings(context),
                  )
                  ..addItem(
                    icon: Icons.vpn_lock,
                    text: l10n.network,
                    onSelected: () =>
                        widget.appState.navigateToNetwork(context),
                  )
                /*..addItem(
                    icon: Icons.aspect_ratio,
                    text: l10n.console,
                    onSelected: () =>
                        widget.appState.navigateToConsole(context),
                  )*/
                /*..addItem(
                    icon: Icons.redeem,
                    text: l10n.donations,
                    onSelected: () => widget.appState.navigateToAddressText(
                        context,
                        'RWEgB+NQs/T83EkmIFNVJG+xK64Hm90GmQgrdR2V7BI='),
                  )*/
                )
                .build(
              icon: Icon(Icons.more_vert),
            ),
          ],
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.attach_money),
                text: l10n.receive,
              ),
              Tab(
                icon: Icon(Icons.receipt),
                text: l10n.balance,
              ),
              Tab(
                icon: Icon(Icons.send),
                text: l10n.send,
              ),
            ],
          ),
        ),
        body: widget.appState.fatal != null
            ? ErrorWidget.builder(widget.appState.fatal)
            : (widget.appState.walletsLoading > 0
                ? Center(child: CircularProgressIndicator())
                : TabBarView(
                    children: <Widget>[
                      WalletReceiveWidget(),
                      WalletBalanceWidget(),
                      WalletSendWidget(widget.wallet),
                    ],
                  )),
      ),
    );
  }

  /// Builds "Wallets" drop down menu. e.g. for [AppBar.leading].
  Widget buildWalletsMenu(BuildContext context,
      [IconData menuIcon = Icons.menu]) {
    final ThemeData theme = Theme.of(context);
    final Localization l10n = Localization.of(context);
    final PopupMenuBuilder walletsMenu = PopupMenuBuilder();

    for (WalletModel x in widget.appState.wallets) {
      bool activeWallet = x.wallet.name == widget.wallet.name;
      walletsMenu.addItem(
        text: x.wallet.name,
        icon: activeWallet ? Icons.check_box : Icons.check_box_outline_blank,
        onSelected: activeWallet
            ? () => widget.appState.navigateToWallet(context)
            : () => widget.appState.changeActiveWallet(x),
      );
    }
    walletsMenu.addItem(
      icon: Icons.add,
      text: l10n.addWallet,
      onSelected: () => widget.appState.navigateToAddWallet(context),
    );

    return !widget.appState.preferences.walletNameInTitle
        ? walletsMenu.build(
            child: Icon(
            menuIcon,
            color: theme.primaryTextTheme.title.color,
          ))
        : OverflowBox(
            maxWidth: 200,
            alignment: Alignment.centerLeft,
            child: walletsMenu.build(
              padding: const EdgeInsets.all(0.0),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
                    child: Icon(
                      menuIcon,
                      color: theme.primaryTextTheme.title.color,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      widget.wallet.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: theme.primaryTextTheme.title.color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  void initUriHandling() async {
    uriSubscription = widget.uriStream.listen(handleUri,
        onError: (err) => debugPrint('Failed to get latest link: $err.'));
    String initialUri;
    try {
      initialUri = await widget.initialUri();
    } on PlatformException {
      debugPrint('Failed to get initial uri.');
    } on FormatException {
      debugPrint('Bad parse the initial link as Uri.');
    }
    if (initialUri != null) handleUri(initialUri);
  }

  void handleUri(String uri) {
    debugPrint('handleUri (mounted=$mounted) $uri');
    const String cruzbasePrefix = 'cruzbase.com';
    int cruzbaseOffset = uri.indexOf(cruzbasePrefix);
    if (cruzbaseOffset >= 0) {
      String path = uri.substring(cruzbaseOffset + cruzbasePrefix.length);
      if (path.startsWith('/#/')) path = path.substring(2);
      if (path.isEmpty || path == '/') {
        widget.appState.navigateToBlockChart(context);
      } else {
        Navigator.of(context).pushNamed(path);
      }
    } else {
      int hostOffset = uri.indexOf('://');
      if (!mounted || hostOffset < 0) return;
      String addr = uri.substring(hostOffset + 3);
      widget.appState.navigateToAddressText(context, addr);
    }
  }
}
