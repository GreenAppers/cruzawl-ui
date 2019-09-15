// Copyright 2019 cruzall developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

/// Interactive cruzbit.1 protocol explorer.
library explorer_console;

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:syntax_highlighter/syntax_highlighter.dart';

import 'package:cruzawl/cruz.dart';
import 'package:cruzawl/network.dart';

import 'package:cruzawl_ui/localization.dart';
import 'package:cruzawl_ui/model.dart';
import 'package:cruzawl_ui/ui.dart';

/// JSON debug console for cruzbit.1.
class CruzawlConsole extends StatefulWidget {
  /// The [PeerNetwork] to query.
  final PeerNetwork network;

  /// The syntax highlighting style, e.g. light or dark.
  final SyntaxHighlighterStyle style = SyntaxHighlighterStyle.lightThemeStyle();

  CruzawlConsole(this.network);

  @override
  _CruzawlConsoleState createState() => _CruzawlConsoleState();
}

class _CruzawlConsoleState extends State<CruzawlConsole> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController inputController =
      TextEditingController(text: '{ "type": "get_tip_header" }');
  Map<String, dynamic> inputJson;
  String output = '';

  @override
  Widget build(BuildContext context) {
    final Cruzawl appState = ScopedModel.of<Cruzawl>(context);
    final Localization l10n = Localization.of(context);

    return SimpleScaffold(
        ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            Form(
              key: formKey,
              child: TextFormField(
                maxLines: null,
                controller: inputController,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: 'cruzbit.1 JSON:',
                  labelStyle: appState.theme.labelStyle,
                ),
                validator: (v) => validateInput(v, l10n),
              ),
            ),
            RaisedGradientButton(
              labelText: l10n.send,
              onPressed: () async => await submitInput(),
            ),
            Container(
              padding: EdgeInsets.only(top: 32),
              child: output.isEmpty
                  ? null
                  : Center(
                      child:
                          Text(l10n.result, style: appState.theme.labelStyle)),
            ),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                    fontFamily: 'monospace', color: Colors.black),
                children: <TextSpan>[
                  TextSpan(text: output),
                  //DartSyntaxHighlighter(widget.style).format(output),
                ],
              ),
            ),
          ],
        ),
        title: l10n.console);
  }

  String validateInput(String query, Localization l10n) {
    if (!widget.network.hasPeer) return l10n.networkOffline;
    try {
      if ((inputJson = jsonDecode(query)) == null) throw FormatException();
      return null;
    } catch (error) {
      return '${l10n.invalidJson} ${error.toString()}';
    }
  }

  Future<void> submitInput() async {
    if (!formKey.currentState.validate()) return;
    CruzPeer peer = await widget.network.getPeer();
    if (peer == null) return;
    peer.addJsonMessage(
        inputJson,
        (Map<String, dynamic> response) => setState(() => output =
            JsonEncoder.withIndent('  ')
                .convert(response ?? Map<String, dynamic>())));
  }
}
