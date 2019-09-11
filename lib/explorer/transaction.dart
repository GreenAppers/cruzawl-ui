// Copyright 2019 cruzawl developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:flutter_web/material.dart'
    if (dart.library.io) 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import 'package:cruzawl/currency.dart';
import 'package:cruzawl/network.dart';

import '../localization.dart';
import '../model.dart';
import '../ui.dart';

class TransactionWidget extends StatefulWidget {
  final PeerNetwork network;
  final TransactionMessage transaction;
  final TransactionInfo info;
  final String transactionIdText;
  final TransactionCallback onHeightTap;
  final Widget loadingWidget;
  final double maxWidth;
  TransactionWidget(this.network, this.info,
      {this.transaction,
      this.transactionIdText,
      this.onHeightTap,
      this.loadingWidget,
      this.maxWidth});

  @override
  _TransactionWidgetState createState() => _TransactionWidgetState(transaction);
}

class _TransactionWidgetState extends State<TransactionWidget> {
  bool loading = false;
  TransactionMessage transaction;
  _TransactionWidgetState(this.transaction);

  void load() async {
    if (loading ||
        transaction != null ||
        !widget.network.hasPeer ||
        widget.transactionIdText.isEmpty) {
      return;
    }
    loading = true;
    transaction = await (await widget.network.getPeer()).getTransaction(widget
        .network.currency
        .fromTransactionIdJson(widget.transactionIdText));

    if (transaction == null) loading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    final Localization l10n = Localization.of(context);
    if (transaction == null) {
      load();
      return SimpleScaffold(Center(child: CircularProgressIndicator()),
          title: l10n.loading);
    }

    final Transaction txn = transaction.transaction;
    final TextStyle valueTextStyle = TextStyle(color: Colors.black);
    final int tipHeight = widget.network.tipHeight ?? 0;
    final Cruzawl appState = ScopedModel.of<Cruzawl>(context);
    final TextStyle labelTextStyle = appState.theme.labelStyle;

    List<Widget> ret = <Widget>[
      ListTile(
        title: Text(l10n.date, style: labelTextStyle),
        subtitle: CopyableText(
            txn.dateTime.toString(), appState.setClipboardText,
            style: valueTextStyle),
      ),
      ListTile(
        title: Text(l10n.from, style: labelTextStyle),
        subtitle: CopyableText(txn.fromText, appState.setClipboardText,
            style: valueTextStyle),
      ),
      ListTile(
        title: Text(l10n.to, style: labelTextStyle),
        subtitle: CopyableText(txn.toText, appState.setClipboardText,
            style: valueTextStyle),
      ),
      ListTile(
        title: Text(l10n.id, style: labelTextStyle),
        subtitle: CopyableText(txn.id().toJson(), appState.setClipboardText,
            style: valueTextStyle),
      ),
    ];

    if (txn.memo != null) {
      ret.add(
        ListTile(
          title: Text(l10n.memo, style: labelTextStyle),
          subtitle: CopyableText(txn.memo, appState.setClipboardText,
              style: valueTextStyle),
        ),
      );
    }

    ret.add(
      ListTile(
        title: Text(l10n.amount, style: labelTextStyle),
        trailing: Text(widget.network.currency.format(txn.amount),
            style: (widget.info.color != null
                ? TextStyle(color: widget.info.color)
                : valueTextStyle)),
      ),
    );

    ret.add(
      ListTile(
        title: Text(l10n.fee, style: labelTextStyle),
        trailing: Text(widget.network.currency.format(txn.fee),
            style: (widget.info.fromWallet
                ? TextStyle(color: Colors.red)
                : valueTextStyle)),
      ),
    );

    if (txn.height != null) {
      ret.add(ListTile(
        title: Text(l10n.height, style: labelTextStyle),
        trailing: Text(txn.height.toString(), style: valueTextStyle),
        onTap:
            widget.onHeightTap != null ? () => widget.onHeightTap(txn) : null,
      ));

      if (txn.height <= tipHeight) {
        ret.add(ListTile(
          title: Text(l10n.confirmations, style: labelTextStyle),
          trailing: Text(
              txn.height == null
                  ? l10n.pending
                  : (1 + tipHeight - txn.height).toString(),
              style: valueTextStyle),
        ));
      }
    }

    ret.add(ListTile(
      title: Text(l10n.nonce, style: labelTextStyle),
      trailing: Text(txn.nonce.toString(), style: valueTextStyle),
    ));

    if (txn.matures != null) {
      int matures = txn.matures;
      ret.add(ListTile(
        title: Text(matures <= tipHeight ? l10n.matured : l10n.matures,
            style: labelTextStyle),
        trailing: Text(matures.toString(), style: valueTextStyle),
      ));
    }

    if (txn.expires != null) {
      int expires = txn.expires;
      ret.add(ListTile(
        title: Text(expires <= tipHeight ? l10n.expired : l10n.expires,
            style: labelTextStyle),
        trailing: Text(expires.toString(), style: valueTextStyle),
      ));
    }

    ret.add(RaisedGradientButton(
      labelText: l10n.copy,
      onPressed: () => appState.setClipboardText(context, jsonEncode(txn)),
    ));

    return SimpleScaffold(
      Container(
        constraints: widget.maxWidth == null
            ? null
            : BoxConstraints(maxWidth: widget.maxWidth),
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          children: ret,
        ),
      ),
      title: l10n.transaction + ' ' + (widget.transactionIdText ?? ''),
    );
  }
}
