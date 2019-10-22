// Copyright 2019 cruzawl developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

/// In-depth single [Wallet] examiner.
library wallet_address;

import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import 'package:cruzawl/currency.dart';
import 'package:cruzawl/wallet.dart';

import 'package:cruzawl_ui/localization.dart';
import 'package:cruzawl_ui/model.dart';
import 'package:cruzawl_ui/ui.dart';

/// Examine the transactions and metadata for a [Wallet].
class WalletSettingsWidget extends StatelessWidget {
  /// The [Wallet] to examine.
  final Wallet wallet;

  /// Populated from [wallet] in constructor.
  final List<Address> addresses;

  WalletSettingsWidget(this.wallet)
      : addresses = wallet.addresses.values.toList()
          ..sort(Address.compareBalance);

  @override
  Widget build(BuildContext context) {
    final Cruzawl appState = ScopedModel.of<Cruzawl>(context);
    final Localization l10n = Localization.of(context);
    final TextStyle labelTextStyle = appState.theme.labelStyle;

    List<Widget> header = <Widget>[
      ListTile(
        title: Text(l10n.name, style: labelTextStyle),
        trailing: Text(wallet.name),
      ),
      ListTile(
        title: Text(l10n.currency, style: labelTextStyle),
        trailing: Text(wallet.currency.name),
      ),
    ];

    if (wallet.chain != null && wallet.chain != 'mainnet') {
      header.add(ListTile(
        title: Text(l10n.network, style: labelTextStyle),
        trailing: Text(wallet.chain),
      ));
    }

    header.add(ListTile(
      title: Text(l10n.accounts, style: labelTextStyle),
      trailing: Text(wallet.accounts.length.toString()),
    ));

    header.add(ListTile(
      title: Text(l10n.addresses, style: labelTextStyle),
      trailing: Text(addresses.length.toString()),
    ));

    header.add(ListTile(
      title: Text(l10n.balance, style: labelTextStyle),
      trailing: Text(wallet.currency.format(wallet.balance)),
    ));

    header.add(ListTile(
      title: Text(l10n.activeTransactions, style: labelTextStyle),
      trailing: Text(wallet.pendingCount.toString()),
    ));

    header.add(ListTile(
      title: Text(l10n.maturingTransactions, style: labelTextStyle),
      trailing: Text(wallet.maturing.length.toString()),
    ));

    if (wallet.hdWallet) {
      header.add(
        HideableWidget(
          title: l10n.seedPhrase,
          child: CopyableText(wallet.seedPhrase, appState.setClipboardText),
        ),
      );
    }

    header.add(
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 32),
            child: Text(l10n.dangerZone, style: labelTextStyle),
          ),
          Container(
            margin: EdgeInsets.only(left: 16, bottom: 48),
            decoration: BoxDecoration(border: Border.all(color: Colors.red)),
            child: ListTile(
              title: Text(l10n.deleteThisWallet),
              subtitle: Text(l10n.deleteWalletDescription),
              trailing: RaisedButton(
                onPressed: () => deleteWallet(context, appState),
                textColor: Colors.red,
                child: Text(l10n.deleteThisWallet),
              ),
            ),
          ),
        ],
      ),
    );

    List<Widget> footer = <Widget>[
      RaisedGradientButton(
        labelText: l10n.verify,
        padding: EdgeInsets.all(32),
        onPressed: () async {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text(l10n.verifying)));
          await Future.delayed(Duration(seconds: 1));

          int verifiedAddresses = 0,
              ranTests = appState.runUnitTests(wallet.currency);
          bool unitTests = ranTests >= 0;
          if (unitTests) {
            for (Address address in addresses) {
              verifiedAddresses += address.verify() ? 1 : 0;
            }
          }

          await showDialog(
            context: context,
            builder: (_) => AlertDialog(
              content: TitledWidget(
                title: l10n.verify,
                content: ListTile(
                  leading: Icon(unitTests ? Icons.check : Icons.close),
                  title: Text(unitTests
                      ? l10n.verifyWalletResults(verifiedAddresses,
                          addresses.length, ranTests, ranTests)
                      : l10n.unitTestFailure),
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(l10n.ok),
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
        labelText: l10n.copyAddresses,
        padding: EdgeInsets.all(32),
        onPressed: () {
          String addressList = '';
          for (Address address in addresses) {
            addressList += '${address.publicAddress.toJson()}\n';
          }
          appState.setClipboardText(context, addressList);
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text(l10n.copied)));
        },
      ),
    ];

    return ListView.builder(
      padding: EdgeInsets.fromLTRB(0, 16, 16, 16),
      itemCount: header.length + footer.length + addresses.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index < header.length) return header[index];
        if (index == header.length) {
          return Center(child: Text(l10n.addresses, style: labelTextStyle));
        }
        int addressIndex = index - header.length - 1;
        if (addressIndex < addresses.length) {
          Address address = addresses[addressIndex];
          String addressText = address.publicAddress.toJson();
          return AddressListTile(
            wallet.currency,
            addressText,
            appState.createIconImage(addressText),
            balance: address.balance,
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
    final Localization l10n = Localization.of(context);
    if (appState.wallets.length < 2) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.cantDeleteOnlyWallet)));
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: TitledWidget(
          title: l10n.deleteWallet,
          content: ListTile(
            leading: Icon(Icons.cast),
            title: Text(wallet.name),
            //subtitle: Text(wallet.seed.toJson()),
            //trailing: Icon(Icons.info_outline),
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(l10n.cancel),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FlatButton(
            child: Text(l10n.delete),
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
