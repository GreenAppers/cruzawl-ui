// Copyright 2019 cruzawl developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

import 'dart:math';

import 'package:flutter_web/material.dart'
    if (dart.library.io) 'package:flutter/material.dart';

import 'package:qr_flutter/qr_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:cruzawl/currency.dart';
import 'package:cruzawl/network.dart';

import 'localizations.dart';
import 'model.dart';
import 'transaction.dart';
import 'ui.dart';

class ExternalAddressWidget extends StatefulWidget {
  final Currency currency;
  final String addressText, title;
  final Widget loadingWidget;
  final double maxWidth;
  ExternalAddressWidget(this.currency, this.addressText,
      {this.loadingWidget, this.maxWidth, this.title});

  @override
  _ExternalAddressWidgetState createState() => _ExternalAddressWidgetState();
}

class _ExternalAddressWidgetState extends State<ExternalAddressWidget> {
  num balance, maturing = 0;
  int maturesHeight = 0, earliestSeen;
  bool loading = false;
  TransactionIterator iter;
  List<Transaction> transactions;
  _ExternalAddressWidgetState();

  void load() async {
    if (loading || !widget.currency.network.hasPeer) return;
    loading = true;

    int tipHeight = widget.currency.network.tip.height;
    Peer peer = await widget.currency.network.getPeer();
    PublicAddress address =
        widget.currency.fromPublicAddressJson(widget.addressText);

    if (balance == null) {
      balance = await peer.getBalance(address);
      if (balance == null) {
        loading = false;
        setState(() {});
        return;
      }
    }

    do {
      if (iter != null) {
        if (iter.index == 0)
          iter.height--;
        else
          iter.index--;
      }
      TransactionIteratorResults results = await peer.getTransactions(address,
          startHeight: iter == null ? null : iter.height,
          startIndex: iter == null ? null : iter.index,
          endHeight: iter == null ? null : 0);
      if (results == null) break;

      for (Transaction transaction in results.transactions) {
        bool toWallet = widget.addressText == transaction.toText;
        bool mature =
            transaction.maturity == null || transaction.maturity <= tipHeight;
        if (toWallet && !mature) {
          maturing += transaction.amount;
          maturesHeight = max(maturesHeight, transaction.maturity);
        }
        if (earliestSeen == null || transaction.height < earliestSeen)
          earliestSeen = transaction.height;
      }

      if (transactions == null)
        transactions = results.transactions;
      else
        transactions.addAll(results.transactions);

      if (iter != null &&
          (results.height > iter.height ||
              (results.height == iter.height && results.index > iter.index)))
        iter = TransactionIterator(0, 0);
      else
        iter = TransactionIterator(results.height, results.index);

      // Load most recent 100 blocks worth of transactions
    } while (iter.height > max(0, tipHeight - 100));

    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations locale = AppLocalizations.of(context);
    if (transactions == null) {
      load();
      return SimpleScaffold(Center(child: CircularProgressIndicator()),
          title: locale.loading);
    }

    final Cruzawl appState = ScopedModel.of<Cruzawl>(context);
    final Size screenSize = MediaQuery.of(context).size;
    final TextStyle linkStyle = appState.theme.linkStyle;
    final TextStyle labelTextStyle = appState.theme.labelStyle;
    final bool wideStyle =
        screenSize.width > (widget.maxWidth ?? double.maxFinite);
    final bool fullyLoaded = iter.height == 0 && iter.index == 0;

    final List<Widget> header = <Widget>[
      Center(
        child: QrImage(
          data: widget.addressText,
          size: min(screenSize.width, screenSize.height) *
              (wideStyle ? 1 : 2) /
              3.0,
        ),
      ),
      Center(
        child: Container(
          padding: const EdgeInsets.only(top: 16),
          child: Text(locale.address, style: labelTextStyle),
        ),
      ),
      Center(
        child: Container(
          padding: EdgeInsets.only(right: 32),
          child: CopyableText(widget.addressText, appState.setClipboardText),
        ),
      ),
      ListTile(
        title: Text(locale.balance, style: labelTextStyle),
        trailing: Text(widget.currency.format(balance)),
      ),
    ];

    if (maturing > 0)
      header.add(ListTile(
        title: Text(locale.maturing, style: labelTextStyle),
        trailing: Text(widget.currency.format(maturing)),
      ));
    if (fullyLoaded)
      header.add(ListTile(
        title: Text(locale.earliestSeen, style: labelTextStyle),
        trailing: Text(earliestSeen.toString()),
      ));

    return SimpleScaffold(
      Container(
        constraints: widget.maxWidth == null
            ? null
            : BoxConstraints(maxWidth: widget.maxWidth),
        child: ListView.builder(
          itemCount: header.length +
              (transactions.length > 0 ? (fullyLoaded ? 1 : 2) : 0) +
              transactions.length,
          itemBuilder: (BuildContext context, int index) {
            if (index < header.length) return header[index];
            if (index == header.length)
              return Center(
                  child: Text(locale.numTransactions(transactions.length),
                      style: labelTextStyle));

            int transactionIndex = index - header.length - 1;
            if (transactionIndex < transactions.length) {
              Transaction transaction = transactions[transactionIndex];
              return TransactionListTile(
                widget.currency,
                transaction,
                TransactionInfo(
                    toWallet: widget.addressText == transaction.toText,
                    fromWallet: widget.addressText == transaction.fromText,
                    wideStyle: wideStyle),
                onTap: (tx) => appState.navigateToTransaction(context, tx),
                onFromTap: (tx) => appState.navigateToAddressText(context, tx.fromText),
                onToTap: (tx) => appState.navigateToAddressText(context, tx.toText),
              );
            }

            assert(!(iter.height == 0 && iter.index == 0));
            load();

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
      title: widget.title ?? locale.addressTitle(widget.addressText),
    );
  }
}
