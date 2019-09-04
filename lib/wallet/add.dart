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
    final Localization locale = Localization.of(c);
    if (name == null) name = locale.defaultWalletName;

    List<Widget> ret = <Widget>[];
    ret.add(
      ListTile(
        subtitle: TextFormField(
          enabled: false,
          initialValue: currencyName,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: locale.currency,
          ),
          validator: (value) {
            if (Currency.fromJson(value) == null) return locale.unknownAddress;
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
            labelText: locale.name,
          ),
          validator: (value) {
            if (widget.appState.wallets
                    .indexWhere((v) => v.wallet.name == value) !=
                -1) return locale.nameMustBeUnique;
            return null;
          },
          onSaved: (val) => name = val,
        ),
      ),
    );

    ret.add(SwitchListTile(
      title: Text(locale.hdWallet),
      value: hdWallet,
      onChanged: (bool value) => setState(() => hdWallet = value),
    ));

    if (!hdWallet)
      ret.add(
        SwitchListTile(
          title: Text(locale.watchOnlyWallet),
          value: watchOnlyWallet,
          onChanged: (bool value) => setState(() => watchOnlyWallet = value),
        ),
      );

    if (hdWallet) {
      ret.add(ListTile(
          title: Text(locale.warning, style: widget.appState.theme.labelStyle),
          subtitle: Text(locale.seedPhraseWarning,
              style: TextStyle(color: Colors.red))));
      ret.add(ListTile(
        subtitle: PastableTextFormField(
          maxLines: 3,
          controller: seedPhraseController,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            labelText: locale.seedPhrase,
            suffixIcon: IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () => seedPhraseController.text = generateMnemonic(),
            ),
          ),
          validator: (value) {
            if (!validateMnemonic(value)) return locale.invalidMnemonic;
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
                  labelText: locale.publicKeyList,
                ),
                validator: (value) {
                  Currency cur = Currency.fromJson(currencyName);
                  if (cur == null) return locale.invalidCurrency;
                  try {
                    List<PublicAddress> keys = value
                        .trim()
                        .split(RegExp(r'\s+'))
                        .map((key) => cur.fromPublicAddressJson(key))
                        .toList();
                    if (keys.length <= 0) return locale.noPublicKeys;
                    for (PublicAddress key in keys) {
                      if (key == null) return locale.invalidPublicKey;
                    }
                  } catch (error) {
                    debugPrint('${locale.invalidPublicKey}: $error');
                    return locale.invalidPublicKey;
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
          title: Text(locale.warning, style: widget.appState.theme.labelStyle),
          subtitle: Text(locale.backupKeysWarning,
              style: TextStyle(color: Colors.red))));
      ret.add(
        ListTile(
            subtitle: PastableTextFormField(
                maxLines: 10,
                controller: keyListController,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: locale.privateKeyList,
                ),
                validator: (value) {
                  Currency cur = Currency.fromJson(currencyName);
                  if (cur == null) return locale.invalidCurrency;
                  try {
                    List<PrivateKey> keys = value
                        .trim()
                        .split(RegExp(r'\s+'))
                        .map((key) => cur.fromPrivateKeyJson(key))
                        .toList();
                    if (keys.length <= 0) return locale.noPrivateKeys;
                    for (PrivateKey key in keys) {
                      if (key == null) return locale.invalidPrivateKey;
                      if (!cur.fromPrivateKey(key).verify()) {
                        return locale.verifyAddressFailed(key.toJson());
                      }
                    }
                  } catch (error) {
                    debugPrint('${locale.invalidPrivateKey}: $error');
                    return locale.invalidPrivateKey;
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
        labelText: locale.create,
        padding: EdgeInsets.all(32),
        onPressed: () async {
          if (!formKey.currentState.validate()) return;
          formKey.currentState.save();
          FocusScope.of(context).requestFocus(FocusNode());
          Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(hdWallet
                  ? locale.creatingUsingAlgorithm(locale.hdWalletAlgorithm)
                  : locale.creating)));
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
