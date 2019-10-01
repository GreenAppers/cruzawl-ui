// Copyright 2019 cruzawl developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

/// Widgets for receiving [Transcation].
library wallet_receive;

import 'dart:math';

import 'package:flutter/material.dart';

import 'package:qr_flutter/qr_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:cruzawl/currency.dart';
import 'package:cruzawl/wallet.dart';

import 'package:cruzawl_ui/localization.dart';
import 'package:cruzawl_ui/model.dart';
import 'package:cruzawl_ui/ui.dart';

/// Generate or retrieve an [Address] from [Wallet].
class WalletReceiveWidget extends StatefulWidget {
  @override
  _WalletReceiveWidgetState createState() => _WalletReceiveWidgetState();
}

class _WalletReceiveWidgetState extends State<WalletReceiveWidget> {
  @override
  Widget build(BuildContext context) {
    final Localization l10n = Localization.of(context);
    final Cruzawl appState = ScopedModel.of<Cruzawl>(context);
    final Wallet wallet =
        ScopedModel.of<WalletModel>(context, rebuildOnChange: true).wallet;
    final Address address = wallet.receiveAddress;
    final Size screenSize = MediaQuery.of(context).size;
    final String addressText =
        address == null ? '' : address.publicAddress.toJson();
    final List<Widget> children = <Widget>[];

    if (address != null) {
      children.add(Center(
        child: QrImage(
          data: addressText,
          size: min(256, min(screenSize.width, screenSize.height) * 2 / 3.0),
        ),
      ));
    }

    if (appState.createIconImage != createQrImage && address != null) {
      children.add(AddressRow(
          l10n.walletAccountName(
              wallet.name, address.accountId + 1, address.chainIndex + 1),
          appState.createIconImage(addressText)));
    }

    children.add(Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(top: 16),
          child: Text(l10n.address, style: appState.theme.labelStyle),
        ),
        CopyableText(
          addressText,
          appState.setClipboardText,
          onTap: () => appState.navigateToAddressText(context, addressText),
        ),
        Container(
          padding: EdgeInsets.all(32),
          child: FlatButton.icon(
              icon: Icon(
                Icons.refresh,
                color: appState.theme.linkColor,
              ),
              label: Text(
                l10n.generateNewAddress,
                style: TextStyle(
                  color: appState.theme.linkColor,
                ),
              ),
              onPressed: () async {
                if (address != null) {
                  await wallet.updateAddressState(address, AddressState.open);
                }
                setState(() {});
              }),
        ),
        Container(
          padding: EdgeInsets.only(left: 32, right: 32),
          child: Text(l10n.typingAddressesWarning),
        ),
      ],
    ));

    return ListView(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      children: children,
    );
  }
}
