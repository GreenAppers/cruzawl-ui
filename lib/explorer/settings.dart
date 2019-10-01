// Copyright 2019 cruzall developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

/// Cruzawl settings.
library explorer_settings;

import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import 'package:cruzawl/exchange.dart';

import 'package:cruzawl_ui/localization.dart';
import 'package:cruzawl_ui/model.dart';
import 'package:cruzawl_ui/ui.dart';

/// Configure cruzawl settings e.g. language, currency, theme.
class CruzawlSettings extends StatefulWidget {
  /// Enable wallet related settings.
  final bool walletSettings;

  CruzawlSettings({this.walletSettings = false});

  @override
  _CruzawlSettingsState createState() => _CruzawlSettingsState();
}

class _CruzawlSettingsState extends State<CruzawlSettings> {
  @override
  Widget build(BuildContext context) {
    final Cruzawl appState =
        ScopedModel.of<Cruzawl>(context, rebuildOnChange: true);
    final Localization l10n = Localization.of(context);
    final bool encryptionEnabled = appState.preferences.walletsEncrypted;
    final bool warningEnabled = appState.preferences.insecureDeviceWarning;
    final bool unitTestBeforeCreating =
        appState.preferences.unitTestBeforeCreating;
    final bool verifyAddressEveryLoad =
        appState.preferences.verifyAddressEveryLoad;

    final List<Widget> ret = <Widget>[
      Container(
        height: 200,
        child:
            Image.asset(appState.assetPath('${appState.currency.ticker}.png')),
      ),
      ListTile(
        leading: Container(
            padding: EdgeInsets.all(10),
            child: Image.asset(appState.assetPath('icon.png'))),
        title: Text(l10n.version),
        trailing: Text(appState.packageInfo == null
            ? l10n.unknown
            : appState.packageInfo.version),
      ),
      GestureDetector(
        child: ListTile(
          leading: Icon(Icons.people),
          title: Text(l10n.support),
          trailing:
              Text('>', style: TextStyle(color: appState.theme.linkColor)),
        ),
        onTap: () => Navigator.of(context).pushNamed('/support'),
      ),
      ListTile(
        leading: Icon(Icons.color_lens),
        title: Text(l10n.theme),
        trailing: DropdownButton<String>(
          value: appState.preferences.getThemeName(appState.currency),
          onChanged: (String val) async {
            if (appState.currency == null) {
              await appState.preferences.setTheme(val);
            } else {
              Map<String, String> themes = appState.preferences.themes;
              themes[appState.currency.ticker] = val;
              await appState.preferences.setThemes(themes);
            }
            appState.setState(() => appState.setTheme());
          },
          items: buildDropdownMenuItem(themes.keys.toList()),
        ),
      ),
      ListTile(
        leading: Icon(Icons.attach_money),
        title: Text(l10n.currency),
        trailing: DropdownButton<String>(
          value: appState.preferences.localCurrency,
          onChanged: (String val) async {
            await appState.preferences.setLocalCurrency(val);
            appState.setState(() => appState.setLocalCurrency());
          },
          items: buildDropdownMenuItem(coinbaseCurrencies),
        ),
      ),
      ListTile(
        leading: Icon(Icons.language),
        title: Text(l10n.language),
        trailing: DropdownButton<String>(
          value: l10n.localeLanguage,
          onChanged: (String val) {
            int index =
                Localization.supportedLanguages.indexWhere((e) => e == val);
            if (index >= 0 && index < Localization.supportedLocales.length) {
              appState.setState(() => appState.localeOverride =
                  Localization.supportedLocales[index]);
            }
          },
          items: buildDropdownMenuItem(Localization.supportedLanguages),
        ),
      ),
    ];

    if (widget.walletSettings) {
      ret.add(ListTile(
        leading: Icon(encryptionEnabled ? Icons.lock_outline : Icons.lock_open),
        title: Text(l10n.encryption),
        trailing: Switch(
          value: encryptionEnabled,
          onChanged: (bool value) async {
            var password = value
                ? await Navigator.of(context).pushNamed('/enableEncryption')
                : null;
            await appState.preferences.encryptWallets(password);
            setState(() {});
          },
        ),
      ));
      ret.add(ListTile(
        leading: Icon(warningEnabled ? Icons.lock_outline : Icons.lock_open),
        title: Text(l10n.insecureDeviceWarning),
        trailing: Switch(
          value: warningEnabled,
          onChanged: (bool value) async {
            await appState.preferences.setInsecureDeviceWarning(value);
            setState(() {});
          },
        ),
      ));
      ret.add(ListTile(
        leading:
            Icon(verifyAddressEveryLoad ? Icons.lock_outline : Icons.lock_open),
        title: Text(l10n.verifyKeyPairsEveryLoad),
        trailing: Switch(
            value: verifyAddressEveryLoad,
            onChanged: (bool value) async {
              await appState.preferences.setVerifyAddressEveryLoad(value);
              setState(() {});
            }),
      ));
      ret.add(ListTile(
        leading:
            Icon(unitTestBeforeCreating ? Icons.lock_outline : Icons.lock_open),
        title: Text(l10n.unitTestBeforeCreatingWallets),
        trailing: Switch(
            value: unitTestBeforeCreating,
            onChanged: (bool value) async {
              await appState.preferences.setUnitTestBeforeCreating(value);
              setState(() {});
            }),
      ));
      ret.add(GestureDetector(
        child: ListTile(
          leading: Icon(Icons.contacts),
          title: Text(l10n.contacts),
          trailing:
              Text('>', style: TextStyle(color: appState.theme.linkColor)),
        ),
        onTap: () => Navigator.of(context).pushNamed('/settings/contacts'),
      ));
      ret.add(ListTile(
        title: Text(l10n.showWalletNameInTitle),
        trailing: Switch(
          value: appState.preferences.walletNameInTitle,
          onChanged: (bool value) async {
            await appState.preferences.setWalletNameInTitle(value);
            appState.setState(() {});
          },
        ),
      ));
      ret.add(ListTile(
        title: Text(l10n.debugLog),
        trailing: Switch(
          value: appState.preferences.debugLog,
          onChanged: (bool value) async {
            await appState.preferences.setDebugLog(value);
            appState.setState(() => appState.debugLog = value ? '' : null);
          },
        ),
      ));
    }

    if (appState.preferences.debugLog && appState.debugLog != null) {
      ret.add(
        Center(
          child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Text(l10n.debugLog + ' ', style: appState.theme.labelStyle),
            IconButton(
              icon: Icon(Icons.content_copy),
              color: appState.theme.linkColor,
              onPressed: () =>
                  appState.setClipboardText(context, appState.debugLog),
            ),
          ]),
        ),
      );

      ret.add(
        Container(
            height: 600,
            padding: EdgeInsets.only(left: 32, right: 32),
            child: SingleChildScrollView(child: Text(appState.debugLog))),
      );
    }

    return ListView(
      padding: EdgeInsets.only(top: 20),
      children: ret,
    );
  }
}

/// Setup passphrase and enable wallet encryption.
class EnableEncryptionWidget extends StatefulWidget {
  @override
  _EnableEncryptionWidgetState createState() => _EnableEncryptionWidgetState();
}

class _EnableEncryptionWidgetState extends State<EnableEncryptionWidget> {
  final formKey = GlobalKey<FormState>();
  final passwordKey = GlobalKey<FormFieldState>();
  String password, confirm;

  @override
  Widget build(BuildContext c) {
    final Localization l10n = Localization.of(c);

    return Form(
      key: formKey,
      child: ListView(children: <Widget>[
        ListTile(
          subtitle: TextFormField(
            key: passwordKey,
            autofocus: true,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: l10n.password,
            ),
            validator: (value) {
              if (value.isEmpty) return l10n.passwordCantBeEmpty;
              return null;
            },
            onSaved: (val) => password = val,
          ),
        ),
        ListTile(
          subtitle: TextFormField(
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: l10n.confirmPassword,
            ),
            validator: (value) {
              if (passwordKey.currentState.value != value) {
                return l10n.passwordsDontMatch;
              }
              return null;
            },
            onSaved: (val) => confirm = val,
          ),
        ),
        RaisedGradientButton(
          labelText: l10n.encrypt,
          padding: EdgeInsets.all(32),
          onPressed: () {
            if (!formKey.currentState.validate()) return;
            formKey.currentState.save();
            formKey.currentState.reset();
            FocusScope.of(context).requestFocus(FocusNode());
            Navigator.of(context).pop(password);
          },
        ),
      ]),
    );
  }
}

/// Get support, FAQ, legal.
class CruzawlSupport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Cruzawl appState = ScopedModel.of<Cruzawl>(context);
    final Localization l10n = Localization.of(context);
    final String languageCode = Localizations.localeOf(context).languageCode;

    final List<Widget> ret = <Widget>[
      Container(
        height: 200,
        child: Image.asset(appState.assetPath('icon.png')),
      ),
      GestureDetector(
        child: ListTile(
          leading: Icon(Icons.people),
          title: Text('support@greenappers.com'),
          trailing: Icon(Icons.send, color: appState.theme.linkColor),
        ),
        onTap: () => appState.launchUrl(
            context,
            'mailto:support@greenappers.com?subject=' +
                Uri.encodeFull('Cruzall ' + appState.packageInfo.version)),
      ),
      GestureDetector(
        child: ListTile(
          leading: Icon(Icons.home),
          title: Text(l10n.homePage(l10n.title)),
          trailing:
              Text('>', style: TextStyle(color: appState.theme.linkColor)),
        ),
        onTap: () => appState.launchUrl(
            context, 'https://www.greenappers.com/cruzall/$languageCode/'),
      ),
      GestureDetector(
        child: ListTile(
          leading: Icon(Icons.security),
          title: Text(l10n.privacyPolicy),
          trailing:
              Text('>', style: TextStyle(color: appState.theme.linkColor)),
        ),
        onTap: () => appState.launchUrl(context,
            'https://www.greenappers.com/cruzall/$languageCode/privacy_policy.html'),
      ),
      GestureDetector(
        child: ListTile(
          leading: Icon(Icons.wb_sunny),
          title: Text('Green Appers'),
          trailing:
              Text('>', style: TextStyle(color: appState.theme.linkColor)),
        ),
        onTap: () =>
            appState.launchUrl(context, 'https://www.greenappers.com/'),
      ),
      GestureDetector(
        child: ListTile(
          leading: Icon(Icons.whatshot),
          title: Text(appState.currency.name),
          trailing:
              Text('>', style: TextStyle(color: appState.theme.linkColor)),
        ),
        onTap: () => appState.launchUrl(context, appState.currency.url),
      ),
      GestureDetector(
        child: ListTile(
          leading: Icon(Icons.business_center),
          title: Text(l10n.license),
          trailing:
              Text('>', style: TextStyle(color: appState.theme.linkColor)),
        ),
        onTap: () => showLicensePage(
            context: context,
            applicationName: l10n.title,
            applicationVersion: appState.packageInfo.version,
            applicationIcon: Image.asset(appState.assetPath('icon.png'))),
      ),
    ];

    return ListView(
      padding: EdgeInsets.only(top: 20),
      children: ret,
    );
  }
}
