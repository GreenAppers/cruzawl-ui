// Copyright 2019 cruzawl developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:math';

import 'package:flutter_web/material.dart'
    if (dart.library.io) 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import 'package:cruzawl/currency.dart';

import 'localization.dart';
import 'model.dart';
import 'ui.dart';

class TransactionInfo {
  Color color;
  String amountPrefix = '';
  final bool toWallet, fromWallet, wideStyle;

  TransactionInfo(
      {this.toWallet = false,
      this.fromWallet = false,
      this.wideStyle = false}) {
    if (toWallet && !fromWallet) {
      color = Colors.green;
      amountPrefix = '+';
    } else if (fromWallet && !toWallet) {
      color = Colors.red;
      amountPrefix = '-';
    }
  }
}

class TransactionWidget extends StatefulWidget {
  final Currency currency;
  final Transaction transaction;
  final TransactionInfo info;
  final String transactionIdText;
  final TransactionCallback onHeightTap;
  final Widget loadingWidget;
  final double maxWidth;
  TransactionWidget(this.currency, this.info,
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
  Transaction transaction;
  _TransactionWidgetState(this.transaction);

  void load() async {
    if (loading || transaction != null || !widget.currency.network.hasPeer)
      return;
    loading = true;
    transaction = await (await widget.currency.network.getPeer())
        .getTransaction(
            widget.currency.fromTransactionIdJson(widget.transactionIdText));

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
    final Localization locale = Localization.of(context);
    if (transaction == null) {
      load();
      return SimpleScaffold(Center(child: CircularProgressIndicator()),
          title: locale.loading);
    }

    final TextStyle valueTextStyle = TextStyle(color: Colors.black);
    final int tipHeight = widget.currency.network.tipHeight ?? 0;
    final Cruzawl appState = ScopedModel.of<Cruzawl>(context);
    final TextStyle labelTextStyle = appState.theme.labelStyle;

    List<Widget> ret = <Widget>[
      ListTile(
        title: Text(locale.date, style: labelTextStyle),
        subtitle: CopyableText(
            widget.currency.parseTime(transaction.time).toString(),
            appState.setClipboardText,
            style: valueTextStyle),
      ),
      ListTile(
        title: Text(locale.from, style: labelTextStyle),
        subtitle: CopyableText(transaction.fromText, appState.setClipboardText,
            style: valueTextStyle),
      ),
      ListTile(
        title: Text(locale.to, style: labelTextStyle),
        subtitle: CopyableText(transaction.toText, appState.setClipboardText,
            style: valueTextStyle),
      ),
      ListTile(
        title: Text(locale.id, style: labelTextStyle),
        subtitle: CopyableText(
            transaction.id().toJson(), appState.setClipboardText,
            style: valueTextStyle),
      ),
      ListTile(
        title: Text(locale.memo, style: labelTextStyle),
        subtitle: CopyableText(
            transaction.memo ?? '', appState.setClipboardText,
            style: valueTextStyle),
      ),
      ListTile(
        title: Text(locale.amount, style: labelTextStyle),
        trailing: Text(widget.currency.format(transaction.amount),
            style: (widget.info.color != null
                ? TextStyle(color: widget.info.color)
                : valueTextStyle)),
      ),
      ListTile(
        title: Text(locale.fee, style: labelTextStyle),
        trailing: Text(widget.currency.format(transaction.fee),
            style: (widget.info.fromWallet
                ? TextStyle(color: Colors.red)
                : valueTextStyle)),
      ),
      ListTile(
        title: Text(locale.height, style: labelTextStyle),
        trailing: Text(transaction.height.toString(), style: valueTextStyle),
        onTap: widget.onHeightTap != null
            ? () => widget.onHeightTap(transaction)
            : null,
      ),
      ListTile(
        title: Text(locale.confirmations, style: labelTextStyle),
        trailing: Text(max(0, tipHeight - transaction.height).toString(),
            style: valueTextStyle),
      ),
      ListTile(
        title: Text(locale.nonce, style: labelTextStyle),
        trailing: Text(transaction.nonce.toString(), style: valueTextStyle),
      ),
    ];

    if (transaction.matures != null) {
      int matures = transaction.matures;
      ret.add(ListTile(
        title: Text(matures <= tipHeight ? locale.matured : locale.matures,
            style: labelTextStyle),
        trailing: Text(matures.toString(), style: valueTextStyle),
      ));
    }

    if (transaction.expires != null) {
      int expires = transaction.expires;
      ret.add(ListTile(
        title: Text(expires <= tipHeight ? locale.expired : locale.expires,
            style: labelTextStyle),
        trailing: Text(expires.toString(), style: valueTextStyle),
      ));
    }

    ret.add(RaisedGradientButton(
      labelText: locale.copy,
      onPressed: () =>
          appState.setClipboardText(context, jsonEncode(transaction)),
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
      title: locale.transaction,
    );
  }
}

class TransactionListTile extends StatelessWidget {
  final Currency currency;
  final Transaction tx;
  final TransactionInfo info;
  final TransactionCallback onTap, onFromTap, onToTap;
  TransactionListTile(this.currency, this.tx, this.info,
      {this.onTap, this.onFromTap, this.onToTap});

  @override
  Widget build(BuildContext context) {
    final Localization locale = Localization.of(context);
    final Cruzawl appState = ScopedModel.of<Cruzawl>(context);
    final bool amountLink = info.wideStyle && onTap != null;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: ListTile(
        title: GestureDetector(
          child: (info.wideStyle && onToTap != null)
              ? RichText(
                  text: Localization.parseTextSpan(
                    locale.toAddress('{@<a>}${tx.toText}{@</a>}'),
                    tags: <String, TextSpan>{
                      'a': TextSpan(style: appState.theme.linkStyle),
                    },
                  ),
                )
              : Text(locale.toAddress(tx.toText)),
          onTap: onToTap == null ? null : () => onToTap(tx),
        ),
        subtitle: GestureDetector(
          child: (info.wideStyle && onFromTap != null)
              ? RichText(
                  text: Localization.parseTextSpan(
                    locale.fromAddress('{@<a>}${tx.fromText}{@</a>}'),
                    tags: <String, TextSpan>{
                      'a': TextSpan(style: appState.theme.linkStyle),
                    },
                  ),
                )
              : Text(locale.fromAddress(tx.fromText)),
          onTap: onFromTap == null ? null : () => onFromTap(tx),
        ),
        trailing: Text(
            info.amountPrefix +
                currency.format(tx.amount + (info.fromWallet ? tx.fee : 0)),
            style: (amountLink && !info.fromWallet && !info.toWallet)
                ? appState.theme.linkStyle
                : TextStyle(color: info.color).apply(
                    decoration: amountLink ? TextDecoration.underline : null)),
        onTap: onTap == null ? null : () => onTap(tx),
      ),
    );
  }
}
