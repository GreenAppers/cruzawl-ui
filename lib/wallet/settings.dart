// Copyright 2019 cruzawl developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

import 'package:flutter_web/material.dart'
    if (dart.library.io) 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import 'package:cruzawl/currency.dart';
import 'package:cruzawl/wallet.dart';

import '../localization.dart';
import '../model.dart';
import '../ui.dart';
import 'address.dart';

class WalletSettingsWidget extends StatelessWidget {
  final Wallet wallet;
  final List<Address> addresses;
  WalletSettingsWidget(this.wallet)
      : addresses = wallet.addresses.values.toList()
          ..sort(Address.compareBalance);

  @override
  Widget build(BuildContext context) {
    final Cruzawl appState = ScopedModel.of<Cruzawl>(context);
    final Localization locale = Localization.of(context);
    final TextStyle labelTextStyle = appState.theme.labelStyle;

    List<Widget> header = <Widget>[
      ListTile(
        title: Text(locale.name, style: labelTextStyle),
        trailing: Text(wallet.name),
      ),
      ListTile(
        title: Text(locale.accounts, style: labelTextStyle),
        trailing: Text(wallet.accounts.length.toString()),
      ),
      ListTile(
        title: Text(locale.addresses, style: labelTextStyle),
        trailing: Text(addresses.length.toString()),
      ),
      ListTile(
        title: Text(locale.balance, style: labelTextStyle),
        trailing: Text(wallet.currency.format(wallet.balance)),
      ),
      ListTile(
        title: Text(locale.activeTransactions, style: labelTextStyle),
        trailing: Text(wallet.pendingCount.toString()),
      ),
      ListTile(
        title: Text(locale.maturingTransactions, style: labelTextStyle),
        trailing: Text(wallet.maturing.length.toString()),
      ),
    ];

    if (wallet.hdWallet)
      header.add(
        HideableWidget(
          title: locale.seedPhrase,
          child: CopyableText(wallet.seedPhrase, appState.setClipboardText),
        ),
      );

    header.add(
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 32),
            child: Text(locale.dangerZone, style: labelTextStyle),
          ),
          Container(
            margin: EdgeInsets.only(left: 16, bottom: 48),
            decoration: BoxDecoration(border: Border.all(color: Colors.red)),
            child: ListTile(
              title: Text(locale.deleteThisWallet),
              subtitle: Text(locale.deleteWalletDescription),
              trailing: RaisedButton(
                onPressed: () => deleteWallet(context, appState),
                textColor: Colors.red,
                child: Text(locale.deleteThisWallet),
              ),
            ),
          ),
        ],
      ),
    );

    List<Widget> footer = <Widget>[
      RaisedGradientButton(
        labelText: locale.verify,
        padding: EdgeInsets.all(32),
        onPressed: () async {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text(locale.verifying)));
          await Future.delayed(Duration(seconds: 1));

          int verifiedAddresses = 0, ranTests = appState.runUnitTests();
          bool unitTests = ranTests >= 0;
          if (unitTests)
            for (Address address in addresses)
              verifiedAddresses += address.verify() ? 1 : 0;

          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              content: TitledWidget(
                title: locale.verify,
                content: ListTile(
                  leading: Icon(unitTests ? Icons.check : Icons.close),
                  title: Text(unitTests
                      ? locale.verifyWalletResults(verifiedAddresses,
                          addresses.length, ranTests, ranTests)
                      : locale.unitTestFailure),
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(locale.ok),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
            ),
          );
        },
      ),
      RaisedGradientButton(
        labelText: locale.copyPublicKeys,
        padding: EdgeInsets.all(32),
        onPressed: () {
          String publicKeyList = '';
          for (Address address in addresses)
            publicKeyList += '${address.publicKey.toJson()}\n';
          appState.setClipboardText(context, publicKeyList);
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text(locale.copied)));
        },
      ),
    ];

    return ListView.builder(
      padding: EdgeInsets.fromLTRB(0, 16, 16, 16),
      itemCount: header.length + footer.length + addresses.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index < header.length) return header[index];
        if (index == header.length)
          return Center(child: Text(locale.addresses, style: labelTextStyle));
        int addressIndex = index - header.length - 1;
        if (addressIndex < addresses.length) {
          Address address = addresses[addressIndex];
          return AddressListTile(
            wallet,
            address,
            onTap: () => appState.navigateToAddress(context, address),
          );
        } else {
          int footerIndex = addressIndex - addresses.length;
          if (footerIndex < footer.length) return footer[footerIndex];
          return null;
        }
      },
    );
  }

  void deleteWallet(BuildContext context, Cruzawl appState) {
    final Localization locale = Localization.of(context);
    if (appState.wallets.length < 2) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text(locale.cantDeleteOnlyWallet)));
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: TitledWidget(
          title: locale.deleteWallet,
          content: ListTile(
            leading: Icon(Icons.cast),
            title: Text(wallet.name),
            //subtitle: Text(wallet.seed.toJson()),
            //trailing: Icon(Icons.info_outline),
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(locale.cancel),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FlatButton(
            child: Text(locale.delete),
            onPressed: () {
              appState.removeWallet();
              appState.setState(() {});
              Navigator.of(context)
                  .popUntil(ModalRoute.withName(Navigator.defaultRouteName));
            },
          ),
        ],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
      ),
    );
  }
}
