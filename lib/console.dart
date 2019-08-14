// Copyright 2019 cruzall developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:flutter_web/material.dart'
    if (dart.library.io) 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:syntax_highlighter/syntax_highlighter.dart';

import 'package:cruzawl/currency.dart';
import 'package:cruzawl/cruz.dart';
import 'package:cruzawl/network.dart';

import 'localization.dart';
import 'model.dart';
import 'ui.dart';

class CruzawlConsole extends StatefulWidget {
  final Currency currency;
  final SyntaxHighlighterStyle style = SyntaxHighlighterStyle.lightThemeStyle();
  CruzawlConsole(this.currency);

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
    final Localization locale = Localization.of(context);

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
                validator: (v) => validateInput(v, locale),
              ),
            ),
            RaisedGradientButton(
              labelText: locale.send,
              onPressed: () async => await submitInput(),
            ),
            Container(
              padding: EdgeInsets.only(top: 32),
              child: output.isEmpty
                  ? null
                  : Center(
                      child: Text(locale.result,
                          style: appState.theme.labelStyle)),
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
        title: locale.console);
  }

  String validateInput(String query, Localization locale) {
    if (!widget.currency.network.hasPeer) return locale.networkOffline;
    try {
      if ((inputJson = jsonDecode(query)) == null) throw FormatException();
      return null;
    } catch (error) {
      return '${locale.invalidJson} ${error.toString()}';
    }
  }

  void submitInput() async {
    if (!formKey.currentState.validate()) return;
    CruzPeer peer = await widget.currency.network.getPeer();
    if (peer == null) return;
    peer.addJsonMessage(
        inputJson,
        (Map<String, dynamic> response) => setState(() => output =
            JsonEncoder.withIndent('  ')
                .convert(response ?? Map<String, dynamic>())));
  }
}
