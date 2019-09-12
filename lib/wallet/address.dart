// Copyright 2019 cruzall developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

import 'dart:math';

import 'package:flutter/material.dart';

import 'package:qr_flutter/qr_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:cruzawl/currency.dart';
import 'package:cruzawl/network.dart';
import 'package:cruzawl/util.dart' hide VoidCallback;
import 'package:cruzawl/wallet.dart';

import '../localization.dart';
import '../model.dart';
import '../ui.dart';

class AddressWidget extends StatefulWidget {
  final Wallet wallet;
  final Address address;
  AddressWidget(this.wallet, this.address);

  @override
  _AddressWidgetState createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
  List<Widget> header;
  SortedListSet<Transaction> transactions;

  void loadTransactions() {
    String addressText = widget.address.publicKey.toJson();
    transactions = SortedListSet(
        Transaction.timeCompare,
        widget.wallet.transactions.data
            .where((v) => v.fromText == addressText || v.toText == addressText)
            .toList());
  }

  @override
  void initState() {
    super.initState();
    loadTransactions();
  }

  @override
  Widget build(BuildContext context) {
    final Address address = widget.address;
    final String addressText = address.publicKey.toJson();
    final Localization l10n = Localization.of(context);
    final Cruzawl appState = ScopedModel.of<Cruzawl>(context);
    final Size screenSize = MediaQuery.of(context).size;
    final TextStyle labelTextStyle = appState.theme.labelStyle;
    final bool fullyLoaded = address.loadIterator.done;

    final List<Widget> top = <Widget>[
      Center(
        child: QrImage(
          data: addressText,
          size: min(screenSize.width, screenSize.height) * 2 / 3.0,
        ),
      ),
    ];

    if (appState.createIconImage != createQrImage) {
      top.add(AddressRow(
          l10n.walletAccountName(widget.wallet.name, address.accountId + 1,
              address.chainIndex + 1),
          appState.createIconImage(addressText)));
    }

    top.add(Container(
      padding: const EdgeInsets.only(top: 16),
      child: Text(l10n.address, style: labelTextStyle),
    ));

    top.add(Container(
      padding: EdgeInsets.only(right: 32),
      child: CopyableText(addressText, appState.setClipboardText),
    ));

    if (address.chainCode != null)
      top.add(HideableWidget(
        title: l10n.chainCode,
        child:
            CopyableText(address.chainCode.toJson(), appState.setClipboardText),
      ));

    if (address.privateKey != null)
      top.add(
        HideableWidget(
          title: l10n.privateKey,
          child: CopyableText(
              address.privateKey.toJson(), appState.setClipboardText),
        ),
      );

    header = <Widget>[
      Container(
        padding: EdgeInsets.only(bottom: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: top,
        ),
      ),
    ];

    header.add(
      ListTile(
        title: Text(l10n.account, style: labelTextStyle),
        trailing: Text('${address.accountId + 1}'),
      ),
    );
    if (address.chainIndex != null && widget.wallet.hdWallet)
      header.add(
        ListTile(
          title: Text(l10n.chainIndex, style: labelTextStyle),
          trailing: Text('${address.chainIndex + 1}'),
        ),
      );
    header.add(
      ListTile(
        title: Text(l10n.state, style: labelTextStyle),
        trailing: Text(l10n.addressState(address.state)),
      ),
    );
    header.add(
      ListTile(
        title: Text(l10n.balance, style: labelTextStyle),
        trailing: Text(widget.wallet.currency.format(address.balance)),
      ),
    );
    header.add(
      ListTile(
        title: Text(l10n.transactions, style: labelTextStyle),
        trailing:
            Text((transactions != null ? transactions.length : 0).toString()),
      ),
    );
    if (address.earliestSeen != null)
      header.add(
        ListTile(
          title: Text(l10n.earliestSeen, style: labelTextStyle),
          trailing: Text(address.earliestSeen.toString()),
        ),
      );
    if (address.latestSeen != null)
      header.add(
        ListTile(
          title: Text(l10n.latestSeen, style: labelTextStyle),
          trailing: Text(address.latestSeen.toString()),
        ),
      );

    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      itemCount: header.length +
          (transactions.length > 0
              ? (transactions.length + (fullyLoaded ? 1 : 2))
              : 0),
      itemBuilder: itemBuilder,
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    if (index < header.length) return header[index];
    if (index == header.length) {
      final Localization l10n = Localization.of(context);
      final Cruzawl appState = ScopedModel.of<Cruzawl>(context);
      final TextStyle labelTextStyle = appState.theme.labelStyle;
      return Center(child: Text(l10n.transactions, style: labelTextStyle));
    }

    int transactionIndex = index - header.length - 1;
    if (transactionIndex < transactions.length) {
      final Cruzawl appState = ScopedModel.of<Cruzawl>(context);
      Transaction tx = transactions.data[transactionIndex];
      return TransactionListTile(
          widget.wallet.currency, tx, WalletTransactionInfo(widget.wallet, tx),
          onTap: (tx) => appState.navigateToTransaction(context, tx));
    }

    assert(!widget.address.loadIterator.done);

    if (widget.wallet.network.hasPeer)
      widget.wallet.network.getPeer().then((Peer peer) {
        if (peer != null)
          widget.wallet
              .getNextTransactions(peer, widget.address)
              .then((results) {
            if (mounted) setState(() => loadTransactions());
          });
      });

    return Center(child: CircularProgressIndicator());
  }
}
