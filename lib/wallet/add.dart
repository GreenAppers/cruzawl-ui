// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

import 'package:flutter_web/material.dart'
    if (dart.library.io) 'package:flutter/material.dart';
import 'package:flutter_web/services.dart'
    if (dart.library.io) 'package:flutter/services.dart';

import 'package:bip39/bip39.dart';

import 'package:cruzawl/currency.dart';
import 'package:cruzawl/network.dart';
import 'package:cruzawl/util.dart';
import 'package:cruzawl/wallet.dart';

import '../localization.dart';
import '../model.dart';
import '../ui.dart';

class AddWalletWidget extends StatefulWidget {
  final Cruzawl appState;
  final bool welcome;
  AddWalletWidget(this.appState, {this.welcome = false});

  @override
  _AddWalletWidgetState createState() => _AddWalletWidgetState();
}

class _AddWalletWidgetState extends State<AddWalletWidget> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController keyListController = TextEditingController();
  final TextEditingController seedPhraseController =
      TextEditingController(text: generateMnemonic());
  String name, seedPhrase = '', currencyName = 'CRUZ';
  bool hdWallet = true, watchOnlyWallet = false;
  List<PrivateKey> keyList;
  List<PublicAddress> publicKeyList;

  @override
  void dispose() {
    seedPhraseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext c) {
    final Localization l10n = Localization.of(c);
    if (name == null) name = l10n.defaultWalletName;

    List<Widget> ret = <Widget>[];
    ret.add(
      ListTile(
        subtitle: TextFormField(
          enabled: false,
          initialValue: currencyName,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: l10n.currency,
          ),
          validator: (value) {
            if (Currency.fromJson(value) == null) return l10n.unknownAddress;
            return null;
          },
          onSaved: (value) => currencyName = value,
        ),
      ),
    );

    ret.add(
      ListTile(
        subtitle: TextFormField(
          autofocus: true,
          keyboardType: TextInputType.emailAddress,
          initialValue: name,
          decoration: InputDecoration(
            labelText: l10n.name,
          ),
          validator: (value) {
            if (widget.appState.wallets
                    .indexWhere((v) => v.wallet.name == value) !=
                -1) return l10n.nameMustBeUnique;
            return null;
          },
          onSaved: (val) => name = val,
        ),
      ),
    );

    ret.add(SwitchListTile(
      title: Text(l10n.hdWallet),
      value: hdWallet,
      onChanged: (bool value) => setState(() => hdWallet = value),
    ));

    if (!hdWallet)
      ret.add(
        SwitchListTile(
          title: Text(l10n.watchOnlyWallet),
          value: watchOnlyWallet,
          onChanged: (bool value) => setState(() => watchOnlyWallet = value),
        ),
      );

    if (hdWallet) {
      ret.add(ListTile(
          title: Text(l10n.warning, style: widget.appState.theme.labelStyle),
          subtitle: Text(l10n.seedPhraseWarning,
              style: TextStyle(color: Colors.red))));
      ret.add(ListTile(
        subtitle: PastableTextFormField(
          maxLines: 3,
          controller: seedPhraseController,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            labelText: l10n.seedPhrase,
            suffixIcon: IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () => seedPhraseController.text = generateMnemonic(),
            ),
          ),
          validator: (value) {
            if (!validateMnemonic(value)) return l10n.invalidMnemonic;
            return null;
          },
          onSaved: (val) => seedPhrase = val,
        ),
      ));
    } else if (watchOnlyWallet) {
      ret.add(
        ListTile(
            subtitle: PastableTextFormField(
                maxLines: 10,
                controller: keyListController,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: l10n.publicKeyList,
                ),
                validator: (value) {
                  Currency cur = Currency.fromJson(currencyName);
                  if (cur == null) return l10n.invalidCurrency;
                  try {
                    List<PublicAddress> keys = value
                        .trim()
                        .split(RegExp(r'\s+'))
                        .map((key) => cur.fromPublicAddressJson(key))
                        .toList();
                    if (keys.length <= 0) return l10n.noPublicKeys;
                    for (PublicAddress key in keys) {
                      if (key == null) return l10n.invalidPublicKey;
                    }
                  } catch (error) {
                    debugPrint('${l10n.invalidPublicKey}: $error');
                    return l10n.invalidPublicKey;
                  }
                },
                onSaved: (value) {
                  Currency cur = Currency.fromJson(currencyName);
                  publicKeyList = cur == null
                      ? null
                      : value
                          .trim()
                          .split(RegExp(r'\s+'))
                          .map((key) => cur.fromPublicAddressJson(key))
                          .toList();
                })),
      );
    } else {
      ret.add(ListTile(
          title: Text(l10n.warning, style: widget.appState.theme.labelStyle),
          subtitle: Text(l10n.backupKeysWarning,
              style: TextStyle(color: Colors.red))));
      ret.add(
        ListTile(
            subtitle: PastableTextFormField(
                maxLines: 10,
                controller: keyListController,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: l10n.privateKeyList,
                ),
                validator: (value) {
                  Currency cur = Currency.fromJson(currencyName);
                  if (cur == null) return l10n.invalidCurrency;
                  try {
                    List<PrivateKey> keys = value
                        .trim()
                        .split(RegExp(r'\s+'))
                        .map((key) => cur.fromPrivateKeyJson(key))
                        .toList();
                    if (keys.length <= 0) return l10n.noPrivateKeys;
                    for (PrivateKey key in keys) {
                      if (key == null) return l10n.invalidPrivateKey;
                      if (!cur.fromPrivateKey(key).verify()) {
                        return l10n.verifyAddressFailed(key.toJson());
                      }
                    }
                  } catch (error) {
                    debugPrint('${l10n.invalidPrivateKey}: $error');
                    return l10n.invalidPrivateKey;
                  }
                },
                onSaved: (value) {
                  Currency cur = Currency.fromJson(currencyName);
                  keyList = cur == null
                      ? null
                      : value
                          .trim()
                          .split(RegExp(r'\s+'))
                          .map((key) => cur.fromPrivateKeyJson(key))
                          .toList();
                })),
      );
    }

    ret.add(
      RaisedGradientButton(
        labelText: l10n.create,
        padding: EdgeInsets.all(32),
        onPressed: () async {
          if (!formKey.currentState.validate()) return;
          formKey.currentState.save();
          formKey.currentState.reset();
          keyListController.clear();
          seedPhraseController.clear();
          FocusScope.of(context).requestFocus(FocusNode());
          Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(hdWallet
                  ? l10n.creatingUsingAlgorithm(l10n.hdWalletAlgorithm)
                  : l10n.creating)));
          widget.appState.setState(() => widget.appState.walletsLoading++);
          await Future.delayed(Duration(seconds: 1));

          if (widget.appState.preferences.unitTestBeforeCreating &&
              widget.appState.runUnitTests() < 0) return;

          Currency currency = Currency.fromJson(currencyName);
          PeerNetwork network =
              findPeerNetworkForCurrency(widget.appState.networks, currency);

          if (hdWallet) {
            widget.appState.addWallet(Wallet.fromSeedPhrase(
                widget.appState.databaseFactory,
                widget.appState.fileSystem,
                widget.appState.getWalletFilename(name),
                name,
                network,
                seedPhrase,
                widget.appState.preferences,
                debugPrint,
                widget.appState.openedWallet));
          } else if (watchOnlyWallet) {
            widget.appState.addWallet(Wallet.fromPublicKeyList(
                widget.appState.databaseFactory,
                widget.appState.fileSystem,
                widget.appState.getWalletFilename(name),
                name,
                network,
                Seed(randBytes(64)),
                publicKeyList,
                widget.appState.preferences,
                debugPrint,
                widget.appState.openedWallet));
          } else {
            widget.appState.addWallet(Wallet.fromPrivateKeyList(
                widget.appState.databaseFactory,
                widget.appState.fileSystem,
                widget.appState.getWalletFilename(name),
                name,
                network,
                Seed(randBytes(64)),
                keyList,
                widget.appState.preferences,
                debugPrint,
                widget.appState.openedWallet));
          }

          widget.appState.setState(() => widget.appState.walletsLoading--);
          if (!widget.welcome) Navigator.of(context).pop();
        },
      ),
    );

    return Form(key: formKey, child: ListView(children: ret));
  }
}
