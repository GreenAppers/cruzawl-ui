// Copyright 2019 cruzawl developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

import 'package:flutter_web/material.dart'
    if (dart.library.io) 'package:flutter/material.dart';
import 'package:flutter_web/services.dart'
    if (dart.library.io) 'package:flutter/services.dart';

import 'package:scoped_model/scoped_model.dart';

import 'package:cruzawl/currency.dart';
import 'package:cruzawl/network.dart';
import 'package:cruzawl/preferences.dart';
import 'package:cruzawl/wallet.dart';

import '../localization.dart';
import '../model.dart';
import '../ui.dart';
import 'address.dart';

class WalletSendWidget extends StatefulWidget {
  final Wallet wallet;
  WalletSendWidget(this.wallet);

  @override
  _WalletSendWidgetState createState() => _WalletSendWidgetState();
}

class _WalletSendWidgetState extends State<WalletSendWidget> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final TextEditingController memoController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  String fromInput, toInput, memoInput;
  num amountInput, feeInput;
  Wallet lastWallet;

  @override
  void dispose() {
    fromController.dispose();
    toController.dispose();
    memoController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Localization l10n = Localization.of(context);
    final Cruzawl appState = ScopedModel.of<Cruzawl>(context);
    final TextStyle labelTextStyle =
        TextStyle(fontFamily: appState.theme.titleFont);
    final Wallet wallet =
        ScopedModel.of<WalletModel>(context, rebuildOnChange: true).wallet;
    final Currency currency = wallet.currency;

    if (lastWallet == null || lastWallet != wallet) {
      lastWallet = wallet;
      fromController.text = widget.wallet.addresses.values
          .toList()
          .reduce(Address.reduceBalance)
          .publicKey
          .toJson();
      fromController.selection = TextSelection(baseOffset: 0, extentOffset: 0);
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: ListView(
        padding: EdgeInsets.all(32.0),
        children: <Widget>[
          Form(
            key: formKey,
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: <int, TableColumnWidth>{
                0: IntrinsicColumnWidth(),
                1: IntrinsicColumnWidth(),
              },
              children: <TableRow>[
                TableRow(
                  children: <Widget>[
                    GestureDetector(
                      onTap: chooseSendFrom,
                      child: const Icon(Icons.person),
                    ),
                    GestureDetector(
                      onTap: chooseSendFrom,
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Text(l10n.from, style: labelTextStyle),
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: chooseSendFrom,
                      child: TextFormField(
                        enabled: false,
                        maxLines: null,
                        controller: fromController,
                        textAlign: TextAlign.right,
                        keyboardType: TextInputType.multiline,
                        validator: (value) {
                          Address fromAddress = wallet.addresses[value];
                          if (fromAddress == null) return l10n.unknownAddress;
                          if (fromAddress.privateKey == null)
                            return l10n.watchOnlyWallet;
                          return null;
                        },
                        onSaved: (value) => fromInput = value,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    GestureDetector(
                      onTap: chooseSendTo,
                      child: const Icon(Icons.send),
                    ),
                    GestureDetector(
                      onTap: chooseSendTo,
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Text(l10n.payTo, style: labelTextStyle),
                      ),
                    ),
                    PastableTextFormField(
                      maxLines: null,
                      controller: toController,
                      textAlign: TextAlign.right,
                      keyboardType: TextInputType.multiline,
                      decoration: appState.barcodeScan == null
                          ? null
                          : InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(Icons.camera_alt),
                                  onPressed: () async {
                                    String barcode =
                                        await appState.barcodeScan();
                                    if (barcode != null) {
                                      setState(
                                          () => toController.text = barcode);
                                    }
                                  }),
                              hintText: '',
                            ),
                      validator: (value) {
                        if (currency.fromPublicAddressJson(value) == null)
                          return l10n.invalidAddress;
                        return null;
                      },
                      onSaved: (value) => toInput = value,
                    ),
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    const Icon(Icons.edit),
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Text(l10n.memo, style: labelTextStyle),
                    ),
                    PastableTextFormField(
                      maxLines: null,
                      controller: memoController,
                      textAlign: TextAlign.right,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: '',
                      ),
                      validator: (value) {
                        if (value.length > 100) return l10n.maxMemoLength;
                        return null;
                      },
                      onSaved: (value) => memoInput = value,
                    ),
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    const Icon(Icons.attach_money),
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Text(l10n.amount, style: labelTextStyle),
                    ),
                    PastableTextFormField(
                      controller: amountController,
                      textAlign: TextAlign.right,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        hintText: '0.0',
                        suffixText: ' ' + l10n.ticker(currency.ticker),
                      ),
                      validator: (value) {
                        num v = currency.parse(value);
                        if (!(v > 0)) return l10n.valueMustBePositive;
                        Address fromAddress =
                            wallet.addresses[fromController.text];
                        if (fromAddress != null) {
                          if (fromAddress.privateKey == null)
                            return l10n.watchOnlyWallet;
                          if (v > fromAddress.balance)
                            return l10n.insufficientFunds;
                        }
                        if (wallet.network.minAmount == null)
                          return l10n.networkOffline;
                        if (v < wallet.network.minAmount)
                          return l10n.minAmount(wallet.network.minAmount);
                        return null;
                      },
                      onSaved: (value) => amountInput = currency.parse(value),
                    ),
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    const Icon(Icons.rowing),
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Text(l10n.fee, style: labelTextStyle),
                    ),
                    TextFormField(
                      initialValue: currency.suggestedFee(null),
                      textAlign: TextAlign.right,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        hintText: currency.suggestedFee(null),
                        suffixText: ' ' + l10n.ticker(currency.ticker),
                      ),
                      validator: (value) {
                        num v = currency.parse(value);
                        if (!(v > 0)) return l10n.valueMustBePositive;
                        num amount = currency.parse(amountController.text);
                        Address fromAddress =
                            wallet.addresses[fromController.text];
                        if (fromAddress != null &&
                            (amount + v) > fromAddress.balance)
                          return l10n.insufficientFunds;
                        if (wallet.network.tipHeight == null ||
                            wallet.network.tipHeight == 0 ||
                            wallet.network.minFee == null)
                          return l10n.networkOffline;
                        if (v < wallet.network.minFee)
                          return l10n.minFee(wallet.network.minFee);
                        return null;
                      },
                      onSaved: (value) => feeInput = currency.parse(value),
                    ),
                  ],
                ),
              ],
            ),
          ),
          RaisedGradientButton(
            labelText: l10n.send,
            onPressed: () async {
              if (!formKey.currentState.validate()) return;
              formKey.currentState.save();
              formKey.currentState.reset();
              fromController.clear();
              toController.clear();
              memoController.clear();
              amountController.clear();
              FocusScope.of(context).requestFocus(FocusNode());
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text(l10n.sending)));
              Address fromAddress = wallet.addresses[fromInput];
              Transaction transaction = await wallet.createTransaction(
                  currency.signedTransaction(
                      fromAddress,
                      currency.fromPublicAddressJson(toInput),
                      amountInput,
                      feeInput,
                      memoInput,
                      wallet.network.tipHeight,
                      expires: wallet.network.tipHeight + 3));

              TransactionId transactionId;
              for (int i = 0; transactionId == null && i < 3; i++) {
                Peer peer = await wallet.network.getPeer();
                if (peer == null) continue;
                transactionId = await peer.putTransaction(transaction);
              }
              if (transactionId != null)
                Scaffold.of(context).showSnackBar(SnackBar(
                    content:
                        Text(l10n.sentTransactionId(transactionId.toJson()))));
              else
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text(l10n.sendFailed)));
            },
          ),
        ],
      ),
    );
  }

  void chooseSendFrom() async {
    var addr = await Navigator.of(context).pushNamed('/sendFrom');
    if (addr != null) fromController.text = addr;
    fromController.selection = TextSelection(baseOffset: 0, extentOffset: 0);
  }

  void chooseSendTo() async {
    var addr = await Navigator.of(context).pushNamed('/contacts');
    if (addr != null) toController.text = addr;
    toController.selection = TextSelection(baseOffset: 0, extentOffset: 0);
  }
}
