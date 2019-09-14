// Copyright 2019 cruzawl developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

/// Widgets for [Wallet] summary.
library wallet_balance;

import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import 'package:cruzawl/currency.dart';
import 'package:cruzawl/wallet.dart';

import '../localization.dart';
import '../model.dart';
import '../ui.dart';

/// Show the [Wallet]'s balance and maturing balance.
class WalletBalanceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Localization l10n = Localization.of(context);
    final Cruzawl appState = ScopedModel.of<Cruzawl>(context);
    final Wallet wallet =
        ScopedModel.of<WalletModel>(context, rebuildOnChange: true).wallet;
    final Currency currency = wallet.currency;
    final int numTransactions = wallet.transactions.data.length;
    final bool hasPeer =
        wallet.network != null ? wallet.network.hasPeer : false;

    final List<Widget> ret = <Widget>[
      Container(
        padding: EdgeInsets.only(top: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: !hasPeer
              ? <Widget>[
                  Text(l10n.currentBalanceIs, style: appState.theme.labelStyle)
                ]
              : buildLocalizationMarkupWidgets(
                  l10n.balanceAtHeightIs(wallet.network.tipHeight),
                  style: appState.theme.labelStyle,
                  tags: <String, LocalizationMarkup>{
                    'a': LocalizationMarkup(
                      style: appState.theme.linkStyle,
                      onTap: () => appState.navigateToBlockChart(context),
                      key: Key('chartLink'),
                    ),
                  },
                ),
        ),
      ),
      Container(
        padding: EdgeInsets.only(bottom: 32),
        child: Text(
          currency.format(wallet.balance),
          style: theme.textTheme.display1,
        ),
      ),
    ];

    if (wallet.maturesBalance > 0) {
      ret.add(Text(l10n.balanceMaturingByHeightIs(wallet.maturesHeight),
          style: appState.theme.labelStyle));
      ret.add(
        Container(
          padding: EdgeInsets.only(bottom: 32),
          child: Text(
            currency.format(wallet.maturesBalance),
            style: theme.textTheme.display1,
          ),
        ),
      );
    }

    if (numTransactions > 0) {
      ret.add(Text(l10n.recentHistory, style: appState.theme.labelStyle));
      ret.add(
        Expanded(
          child: ListView.builder(
              itemCount: wallet.transactions.data.length,
              itemBuilder: (BuildContext context, int index) {
                Transaction tx = wallet.transactions.data[index];
                return TransactionListTile(
                  wallet.currency,
                  tx,
                  WalletTransactionInfo(wallet, tx),
                  onToTap: (tx) =>
                      appState.navigateToAddressText(context, tx.toText),
                  onFromTap: (tx) =>
                      appState.navigateToAddressText(context, tx.fromText),
                  onTap: (tx) => appState.navigateToTransaction(context, tx),
                );
              }),
        ),
      );
    }

    return Column(
      children: ret,
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}
