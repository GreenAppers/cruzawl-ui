// Copyright 2019 cruzawl developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

/// [PeerNetwork] settings.
library explorer_network;

import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import 'package:cruzawl/currency.dart';
import 'package:cruzawl/network.dart';
import 'package:cruzawl/preferences.dart';

import 'package:cruzawl_ui/localization.dart';
import 'package:cruzawl_ui/model.dart';
import 'package:cruzawl_ui/ui.dart';

/// Manage [PeerPreference] list.
class CruzawlNetworkSettings extends StatefulWidget {
  @override
  _CruzawlNetworkSettingsState createState() => _CruzawlNetworkSettingsState();
}

class _CruzawlNetworkSettingsState extends State<CruzawlNetworkSettings> {
  List<PeerPreference> peers;
  int selectedPeerIndex;

  @override
  Widget build(BuildContext context) {
    final Cruzawl appState =
        ScopedModel.of<Cruzawl>(context, rebuildOnChange: true);
    final Localization l10n = Localization.of(context);
    final PeerNetwork network = appState.network;

    peers = appState.preferences.peers;

    List<Widget> ret = <Widget>[
      SwitchListTile(
        title: Text(l10n.network),
        value: appState.preferences.networkEnabled,
        onChanged: (bool value) async {
          await appState.preferences.setNetworkEnabled(value);
          appState.reconnectPeers(appState.currency);
          appState.setState(() {});
        },
        secondary: const Icon(Icons.vpn_lock),
      ),
    ];

    for (Peer peer in network.peers) {
      ret.add(
        ListTile(
          onTap: nullOp,
          leading: IconButton(
            tooltip: l10n.connected,
            icon: Icon(Icons.check),
            onPressed: nullOp,
          ),
          title: Text(peer.spec.name),
          subtitle: Text(peer.spec.url),
          trailing: IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: nullOp,
          ),
        ),
      );
    }

    List<Widget> reorder = <Widget>[];
    for (int i = 0; i < peers.length; i++) {
      PeerPreference peer = peers[i];
      reorder.add(
        Container(
          key: ValueKey(peer),
          margin: EdgeInsets.all(5.0),
          child: ListTile(
            leading: Icon(peer.ignoreBadCert ? Icons.cast : Icons.vpn_lock),
            title: Text(peer.name),
            subtitle: Text(peer.url),
            trailing: Icon(Icons.menu),
            onTap: () => setState(
                () => selectedPeerIndex = i == selectedPeerIndex ? null : i),
          ),
          decoration: i == selectedPeerIndex
              ? BoxDecoration(
                  color: Colors.black38,
                  border: Border.all(color: Colors.black))
              : BoxDecoration(),
        ),
      );
    }

    ret.add(
      Center(
        child: Container(
          padding: EdgeInsets.only(top: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                tooltip: l10n.deletePeer,
                icon: Icon(Icons.remove),
                color: appState.theme.linkColor,
                onPressed: removeSelectedPeer,
              ),
              Text(l10n.peers),
              IconButton(
                tooltip: l10n.newPeer,
                icon: Icon(Icons.add),
                color: appState.theme.linkColor,
                onPressed: () => Navigator.of(context).pushNamed('/addPeer'),
              ),
            ],
          ),
        ),
      ),
    );

    ret.add(
      Flexible(
        child: ReorderableListView(
          children: reorder,
          onReorder: (int oldIndex, int newIndex) async {
            debugPrint('reorder $oldIndex -> $newIndex');
            PeerPreference peer = peers[oldIndex];
            peers.insert(newIndex, peer);
            peers.removeAt(oldIndex + (newIndex < oldIndex ? 1 : 0));
            await appState.preferences.setPeers(peers);
            setState(() {
              if (selectedPeerIndex == oldIndex) {
                selectedPeerIndex = newIndex - (newIndex > oldIndex ? 1 : 0);
              }
            });
          },
        ),
      ),
    );

    return Column(children: ret);
  }

  void removeSelectedPeer() {
    if (selectedPeerIndex == null) return;
    final Cruzawl appState = ScopedModel.of<Cruzawl>(context);
    final Localization l10n = Localization.of(context);
    PeerPreference peer = peers[selectedPeerIndex];
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: TitledWidget(
          title: l10n.deletePeer,
          content: ListTile(
            leading: Icon(Icons.cast),
            title: Text(peer.name),
            subtitle: Text(peer.url),
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
            onPressed: () async {
              peers.removeAt(selectedPeerIndex);
              await appState.preferences.setPeers(peers);
              setState(() => appState.reconnectPeers(appState.currency));
              Navigator.of(context).pop();
            },
          ),
        ],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
      ),
    );
  }
}

/// Add [PeerPreference] to list.
class AddPeerWidget extends StatefulWidget {
  @override
  _AddPeerWidgetState createState() => _AddPeerWidgetState();
}

class _AddPeerWidgetState extends State<AddPeerWidget> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController urlController = TextEditingController();
  final TextEditingController userController = TextEditingController();
  final TextEditingController credentialController = TextEditingController();
  final TextEditingController sshUrlController = TextEditingController();
  final TextEditingController sshUserController = TextEditingController();
  final TextEditingController sshCredentialController = TextEditingController();
  String name,
      url,
      user,
      password,
      peerType,
      sshUrl,
      sshUser,
      sshKey,
      sshPassword;
  bool certRequired = true, sshTunneling = false;

  @override
  void dispose() {
    urlController.dispose();
    userController.dispose();
    credentialController.dispose();
    sshUrlController.dispose();
    sshUserController.dispose();
    sshCredentialController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext c) {
    final Localization l10n = Localization.of(context);
    final Cruzawl appState = ScopedModel.of<Cruzawl>(context);
    final Currency currency = appState.currency;
    final PeerNetwork network = appState.network;
    final List<PeerPreference> peers = appState.preferences.peers;

    final List<Widget> rows = <Widget>[
      ListTile(
        subtitle: TextFormField(
          enabled: false,
          initialValue: currency.ticker,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: l10n.currency,
          ),
        ),
      ),
      ListTile(
        subtitle: TextFormField(
          autofocus: true,
          keyboardType: TextInputType.emailAddress,
          initialValue: name,
          decoration: InputDecoration(
            labelText: l10n.name,
          ),
          validator: (value) {
            if (peers.indexWhere((v) => v.name == value) != -1) {
              return l10n.nameMustBeUnique;
            }
            return null;
          },
          onSaved: (val) => name = val,
        ),
      ),
      ListTile(
        subtitle: PastableTextFormField(
          keyboardType: TextInputType.emailAddress,
          controller: urlController,
          decoration: InputDecoration(
            labelText: l10n.url,
          ),
          validator: (value) {
            try {
              network.createPeerWithSpec(
                  PeerPreference('', value, currency.ticker, ''));
            } on Exception {
              return l10n.invalidUrl;
            }
            return null;
          },
          onSaved: (val) => url = val,
        ),
      ),
    ];

    if (network.peerTypes != null) {
      if (peerType == null) peerType = network.peerTypes[0];
      rows.add(ListTile(
          leading: Icon(Icons.language),
          title: Text(l10n.type),
          trailing: DropdownButton<String>(
            value: peerType,
            items: buildDropdownMenuItem(network.peerTypes),
            onChanged: (String value) => setState(() => peerType = value),
          )));
    }

    if (peerType != null && peerType == 'BitcoinRPC') {
      rows.add(ListTile(
        subtitle: PastableTextFormField(
          keyboardType: TextInputType.emailAddress,
          controller: userController,
          decoration: InputDecoration(labelText: l10n.username),
          validator: (value) {
            if (value.isEmpty) return l10n.usernameCantBeEmpty;
            return null;
          },
          onSaved: (val) => user = val,
        ),
      ));

      rows.add(ListTile(
        subtitle: TextFormField(
          obscureText: true,
          keyboardType: TextInputType.emailAddress,
          controller: credentialController,
          decoration: InputDecoration(labelText: l10n.password),
          validator: (value) {
            if (value.isEmpty) return l10n.passwordCantBeEmpty;
            return null;
          },
          onSaved: (val) => password = val,
        ),
      ));
    }

    rows.add(ListTile(
      leading: Icon(certRequired ? Icons.lock_outline : Icons.lock_open),
      title: Text(l10n.requireSSLCert),
      trailing: Switch(
        value: certRequired,
        onChanged: (bool value) => setState(() => certRequired = value),
      ),
    ));

    if (currency == btc || currency == eth) {
      rows.add(ListTile(
        leading: Icon(Icons.vpn_lock),
        title: Text(l10n.sshTunneling),
        trailing: Switch(
          value: sshTunneling,
          onChanged: (bool value) => setState(() => sshTunneling = value),
        ),
      ));
    }

    if (sshTunneling) {
      rows.add(ListTile(
        subtitle: PastableTextFormField(
          keyboardType: TextInputType.emailAddress,
          controller: sshUrlController,
          decoration: InputDecoration(labelText: l10n.url),
          validator: (value) {
            try {
              network.createPeerWithSpec(PeerPreference(
                  '', '127.0.0.1', currency.ticker, '',
                  sshUrl: value));
            } on Exception {
              return l10n.invalidUrl;
            }
            return null;
          },
          onSaved: (val) => sshUrl = val,
        ),
      ));

      rows.add(ListTile(
        subtitle: PastableTextFormField(
          keyboardType: TextInputType.emailAddress,
          controller: sshUserController,
          decoration: InputDecoration(labelText: l10n.username),
          validator: (value) {
            if (value.isEmpty) return l10n.usernameCantBeEmpty;
            return null;
          },
          onSaved: (val) => sshUser = val,
        ),
      ));

      rows.add(ListTile(
        subtitle: TextFormField(
          obscureText: true,
          keyboardType: TextInputType.emailAddress,
          controller: sshCredentialController,
          decoration: InputDecoration(labelText: l10n.password),
          validator: (value) {
            if (value.isEmpty) return l10n.passwordCantBeEmpty;
            return null;
          },
          onSaved: (val) => sshPassword = val,
        ),
      ));
    }

    rows.add(RaisedGradientButton(
      labelText: l10n.create,
      padding: EdgeInsets.all(32),
      onPressed: () async {
        if (!formKey.currentState.validate()) return;
        formKey.currentState.save();
        formKey.currentState.reset();
        FocusScope.of(context).requestFocus(FocusNode());
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text(l10n.creating)));

        String options =
            PeerPreference.formatOptions(ignoreBadCert: !certRequired);
        peers.add(PeerPreference(name, url, currency.ticker, options,
            type: peerType,
            user: user,
            password: password,
            sshUrl: sshTunneling ? sshUrl : null,
            sshUser: sshTunneling ? sshUser : null,
            sshKey: sshTunneling ? sshKey : null,
            sshPassword: sshTunneling ? sshPassword : null));
        await appState.preferences.setPeers(peers);
        if (peers.length == 1) appState.connectPeers(currency);

        appState.setState(() {});
        Navigator.of(context).pop();
      },
    ));

    return Form(
      key: formKey,
      child: ListView(children: rows),
    );
  }
}
