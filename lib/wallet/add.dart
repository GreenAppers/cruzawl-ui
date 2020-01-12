// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

/// Widgets for creating cruzawl [Wallet]s.
library wallet_add;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:bip39/bip39.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:cruzawl/currency.dart';
import 'package:cruzawl/network.dart';
import 'package:cruzawl/util.dart';
import 'package:cruzawl/wallet.dart';

import 'package:cruzawl_ui/localization.dart';
import 'package:cruzawl_ui/model.dart';
import 'package:cruzawl_ui/ui.dart';

/// Adds a new [Wallet].
class AddWalletWidget extends StatefulWidget {
  /// The [Model] to call [Cruzawl.addWallet] on.
  final Cruzawl appState;

  /// Whether being displayed on the app's first run.
  final bool welcome;

  AddWalletWidget(this.appState, {this.welcome = false});

  @override
  _AddWalletWidgetState createState() => _AddWalletWidgetState(
      appState.currency == null ? cruz.ticker : appState.currency.ticker);
}

class _AddWalletWidgetState extends State<AddWalletWidget> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController keyListController = TextEditingController();
  final TextEditingController seedPhraseController =
      TextEditingController(text: generateMnemonic());
  String name, seedPhrase = '';
  String initialCurrencyName, currencyName, currencyChain = 'mainnet';
  bool hdWallet = true, watchOnlyWallet = false;
  List<PrivateKey> keyList;
  List<PublicAddress> publicKeyList;
  _AddWalletWidgetState(this.initialCurrencyName)
      : currencyName = initialCurrencyName;

  @override
  void dispose() {
    seedPhraseController.dispose();
    keyListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext c) {
    final Localization l10n = Localization.of(c);
    if (name == null) name = l10n.defaultWalletName;
    final List<Widget> ret = <Widget>[];

    if (currencies.length > 1) {
      ret.add(ListTile(
        title: Text(l10n.currency),
        trailing: DropdownButton<String>(
            value: currencyName,
            items: buildDropdownMenuItem(
                currencies.map((e) => e.ticker).toList(),
                currencies
                    .map((e) => Image.asset(
                        widget.appState.assetPath('${e.ticker}.png'),
                        width: 40))
                    .toList()),
            onChanged: (currency) {
              currencyName = currency;
              widget.appState.setState(() =>
                  widget.appState.setCurrency(Currency.fromJson(currency)));
            }),
      ));
    }

    if (currencyName == 'ETH') {
      ret.add(ListTile(
        title: Text(l10n.network),
        trailing: DropdownButton<String>(
          value: currencyChain,
          items: buildDropdownMenuItem(<String>['mainnet', 'testnet']),
          onChanged: (value) => setState(() => currencyChain = value),
        ),
      ));
    }

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

    if (!hdWallet) {
      ret.add(
        SwitchListTile(
          title: Text(l10n.watchOnlyWallet),
          value: watchOnlyWallet,
          onChanged: (bool value) => setState(() => watchOnlyWallet = value),
        ),
      );
    }

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
                    if (keys.isEmpty) return l10n.noPublicKeys;
                    for (PublicAddress key in keys) {
                      if (key == null) return l10n.invalidPublicKey;
                    }
                  } catch (error) {
                    debugPrint('${l10n.invalidPublicKey}: $error');
                    return l10n.invalidPublicKey;
                  }
                  return null;
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
                    if (keys.isEmpty) return l10n.noPrivateKeys;
                    for (PrivateKey key in keys) {
                      if (key == null) return l10n.invalidPrivateKey;
                      if (!cur.fromPrivateKey(key).verify()) {
                        return l10n.verifyAddressFailed(key.toJson());
                      }
                    }
                    return null;
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

          Currency currency = Currency.fromJson(currencyName);
          PeerNetwork network =
              findPeerNetworkForCurrency(widget.appState.networks, currency);

          if (widget.appState.preferences.unitTestBeforeCreating &&
              widget.appState.runUnitTests(currency) < 0) return;

          if (hdWallet) {
            await widget.appState.addWallet(Wallet.fromSeedPhrase(
                widget.appState.databaseFactory,
                widget.appState.fileSystem,
                widget.appState.getWalletFilename(name),
                name,
                network,
                currencyChain,
                seedPhrase,
                widget.appState.preferences,
                debugPrint,
                widget.appState.openedWallet));
          } else if (watchOnlyWallet) {
            await widget.appState.addWallet(Wallet.fromPublicKeyList(
                widget.appState.databaseFactory,
                widget.appState.fileSystem,
                widget.appState.getWalletFilename(name),
                name,
                network,
                currencyChain,
                Seed(randBytes(64)),
                publicKeyList,
                widget.appState.preferences,
                debugPrint,
                widget.appState.openedWallet));
          } else {
            await widget.appState.addWallet(Wallet.fromPrivateKeyList(
                widget.appState.databaseFactory,
                widget.appState.fileSystem,
                widget.appState.getWalletFilename(name),
                name,
                network,
                currencyChain,
                Seed(randBytes(64)),
                keyList,
                widget.appState.preferences,
                debugPrint,
                widget.appState.openedWallet));
          }

          widget.appState.setState(() {
            initialCurrencyName = currencyName;
            widget.appState.walletsLoading--;
          });
          if (!widget.welcome) Navigator.of(context).pop();
        },
      ),
    );

    return WillPopScope(
        child: Form(key: formKey, child: ListView(children: ret)),
        onWillPop: () {
          if (initialCurrencyName != currencyName) {
            widget.appState.setState(() => widget.appState
                .setCurrency(Currency.fromJson(initialCurrencyName)));
          }
          return Future.value(true);
        });
  }
}
