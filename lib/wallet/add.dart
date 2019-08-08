// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

import 'package:flutter_web/material.dart'
    if (dart.library.io) 'package:flutter/material.dart';
import 'package:flutter_web/services.dart'
    if (dart.library.io) 'package:flutter/services.dart';

import 'package:bip39/bip39.dart';

import 'package:cruzawl/currency.dart';
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
  String name, seedPhrase = '', currency = 'CRUZ';
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
          initialValue: currency,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: locale.currency,
          ),
          validator: (value) {
            if (Currency.fromJson(value) == null) return locale.unknownAddress;
            return null;
          },
          onSaved: (value) => currency = value,
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
        subtitle: TextFormField(
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
            subtitle: TextFormField(
                maxLines: 10,
                controller: keyListController,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: locale.publicKeyList,
                ),
                validator: (value) {
                  Currency cur = Currency.fromJson(currency);
                  if (cur == null) return locale.invalidCurrency;
                  try {
                    List<PublicAddress> keys = value
                        .split('\\s+')
                        .map((key) => cur.fromPublicAddressJson(key))
                        .toList();
                    if (keys.length <= 0) return locale.noPublicKeys;
                  } catch (error) {
                    return '$error';
                  }
                },
                onSaved: (value) {
                  Currency cur = Currency.fromJson(currency);
                  publicKeyList = cur == null
                      ? null
                      : value
                          .split('\\s+')
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
            subtitle: TextFormField(
                maxLines: 10,
                controller: keyListController,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: locale.privateKeyList,
                ),
                validator: (value) {
                  Currency cur = Currency.fromJson(currency);
                  if (cur == null) return locale.invalidCurrency;
                  try {
                    List<PrivateKey> keys = value
                        .split('\\s+')
                        .map((key) => cur.fromPrivateKeyJson(key))
                        .toList();
                    if (keys.length <= 0) return locale.noPrivateKeys;
                    for (PrivateKey key in keys)
                      if (!cur.fromPrivateKey(key).verify())
                        return locale.verifyAddressFailed(key.toJson());
                  } catch (error) {
                    return '$error';
                  }
                },
                onSaved: (value) {
                  Currency cur = Currency.fromJson(currency);
                  keyList = cur == null
                      ? null
                      : value
                          .split('\\s+')
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

          if (hdWallet) {
            widget.appState.addWallet(Wallet.fromSeedPhrase(
                widget.appState.databaseFactory,
                widget.appState.getWalletFilename(name),
                name,
                Currency.fromJson(currency),
                seedPhrase,
                widget.appState.preferences,
                debugPrint,
                widget.appState.openedWallet));
          } else if (watchOnlyWallet) {
            widget.appState.addWallet(Wallet.fromPublicKeyList(
                widget.appState.databaseFactory,
                widget.appState.getWalletFilename(name),
                name,
                Currency.fromJson(currency),
                Seed(randBytes(64)),
                publicKeyList,
                widget.appState.preferences,
                debugPrint,
                widget.appState.openedWallet));
          } else {
            widget.appState.addWallet(Wallet.fromPrivateKeyList(
                widget.appState.databaseFactory,
                widget.appState.getWalletFilename(name),
                name,
                Currency.fromJson(currency),
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
