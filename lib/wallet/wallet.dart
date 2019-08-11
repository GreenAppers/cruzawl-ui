// Copyright 2019 cruzawl developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

import 'package:flutter_web/material.dart'
    if (dart.library.io) 'package:flutter/material.dart';

import 'package:gradient_app_bar/gradient_app_bar.dart';

import 'package:cruzawl/currency.dart';
import 'package:cruzawl/wallet.dart';

import '../localization.dart';
import '../model.dart';
import '../ui.dart';

import 'balance.dart';
import 'receive.dart';
import 'send.dart';

/// Main wallet [TabBarView] with Receive, Balance, Send.
class WalletWidget extends StatefulWidget {
  final Wallet wallet;
  final Cruzawl appState;
  WalletWidget(this.wallet, this.appState);

  @override
  _WalletWidgetState createState() => _WalletWidgetState();
}

class _WalletWidgetState extends State<WalletWidget> {
  /// Shows "Insecure Device Warning" if [Cruzawl.isTrustFall].
  @override
  void initState() {
    super.initState();
    if (widget.appState.isTrustFall &&
        widget.appState.preferences.insecureDeviceWarning)
      Future.delayed(Duration(seconds: 0)).then((_) => showDialog(
          context: context,
          builder: (context) {
            final Localization locale = Localization.of(context);
            return AlertDialog(
              title: Text(locale.insecureDeviceWarning),
              content: Text(locale.insecureDeviceWarningDescription,
                  style: TextStyle(color: Colors.red)),
              actions: <Widget>[
                FlatButton(
                  child: Text(locale.ignore),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
            );
          }));
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Currency currency = widget.wallet.currency;
    final Localization locale = Localization.of(context);

    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        appBar: GradientAppBar(
          centerTitle: true,
          title: Text(
            locale.balanceTitle(locale.ticker(currency.ticker),
                currency.format(widget.wallet.balance)),
            overflow: TextOverflow.ellipsis,
            style: widget.appState.theme.titleStyle,
          ),
          backgroundColorStart: theme.primaryColor,
          backgroundColorEnd: theme.accentColor,
          leading: buildWalletsMenu(context),
          actions: <Widget>[
            (PopupMenuBuilder()
                  ..addItem(
                    icon: Icon(Icons.settings),
                    text: locale.settings,
                    onSelected: () =>
                        widget.appState.navigateToSettings(context),
                  )
                  ..addItem(
                    icon: Icon(Icons.vpn_lock),
                    text: locale.network,
                    onSelected: () =>
                        widget.appState.navigateToNetwork(context),
                  )
                  ..addItem(
                    icon: Icon(Icons.redeem),
                    text: locale.donations,
                    onSelected: () => widget.appState.navigateToAddressText(
                        context,
                        'RWEgB+NQs/T83EkmIFNVJG+xK64Hm90GmQgrdR2V7BI='),
                  ))
                .build(
              icon: Icon(Icons.more_vert),
            ),
          ],
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.attach_money),
                text: locale.receive,
              ),
              Tab(
                icon: Icon(Icons.receipt),
                text: locale.balance,
              ),
              Tab(
                icon: Icon(Icons.send),
                text: locale.send,
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
    final Localization locale = Localization.of(context);
    final PopupMenuBuilder walletsMenu = PopupMenuBuilder();

    for (WalletModel x in widget.appState.wallets) {
      bool activeWallet = x.wallet.name == widget.wallet.name;
      walletsMenu.addItem(
        text: x.wallet.name,
        icon: Icon(
            activeWallet ? Icons.check_box : Icons.check_box_outline_blank),
        onSelected: activeWallet
            ? () => widget.appState.navigateToWallet(context)
            : () => widget.appState.changeActiveWallet(x),
      );
    }
    walletsMenu.addItem(
      icon: Icon(Icons.add),
      text: locale.addWallet,
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
}
