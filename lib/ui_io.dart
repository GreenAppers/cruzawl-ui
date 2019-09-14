// Copyright 2019 cruzawl developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import 'localization.dart';
import 'model.dart';

WidgetBuilder backButtonBuilder;

/// Wraps [TextFormField] adding "Paste" context menu and <Enter> submitting.
class EnterTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final InputDecoration decoration;
  final TextStyle style;
  final Color cursorColor;
  final bool autofocus, autocorrect;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;
  EnterTextFormField(
      {this.controller,
      this.decoration,
      this.style,
      this.cursorColor,
      this.autofocus = false,
      this.autocorrect = true,
      this.validator,
      this.onFieldSubmitted});

  @override
  Widget build(BuildContext context) => PastableTextFormField(
      controller: controller,
      decoration: decoration,
      style: style,
      cursorColor: cursorColor,
      autofocus: autofocus,
      autocorrect: autocorrect,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted);
}

/// Wraps [TextFormField] adding "Paste" context menu.
class PastableTextFormField extends StatelessWidget {
  final Key key;
  final TextEditingController controller;
  final String initialValue;
  final FocusNode focusNode;
  final InputDecoration decoration;
  final TextInputType keyboardType;
  final TextStyle style;
  final TextAlign textAlign;
  final bool autofocus, autocorrect;
  final int maxLines;
  final FormFieldSetter<String> onSaved;
  final ValueChanged<String> onFieldSubmitted;
  final FormFieldValidator<String> validator;
  final Color cursorColor;

  PastableTextFormField({
    this.key,
    this.controller,
    this.initialValue,
    FocusNode focusNode,
    this.decoration,
    this.keyboardType,
    this.style,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.autocorrect = true,
    this.maxLines = 1,
    this.onSaved,
    this.onFieldSubmitted,
    this.validator,
    this.cursorColor,
  }) : focusNode = focusNode ?? FocusNode();

  Widget buildWrapped(BuildContext context) => TextFormField(
      key: key,
      controller: controller,
      initialValue: initialValue,
      focusNode: focusNode,
      decoration: decoration,
      keyboardType: keyboardType,
      style: style,
      textAlign: textAlign,
      autofocus: autofocus,
      autocorrect: autocorrect,
      maxLines: maxLines,
      onSaved: onSaved,
      onFieldSubmitted: onFieldSubmitted,
      cursorColor: cursorColor,
      validator: validator);

  @override
  Widget build(BuildContext context) {
    if (controller == null ||
        (!Platform.isMacOS && !Platform.isLinux && !Platform.isWindows)) {
      return buildWrapped(context);
    }

    final Cruzawl appState = ScopedModel.of<Cruzawl>(context);
    final Localization l10n = Localization.of(context);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(focusNode);
      },
      onLongPress: () async {
        String selected = await showMenu(
          context: context,
          position: RelativeRect.fromLTRB(0.0, 300.0, 300.0, 0.0),
          items: [
            PopupMenuItem(
              value: '',
              child: Text(l10n.paste),
            ),
          ],
        );
        if (selected != null && controller != null) {
          controller.text = await appState.getClipboardText();
        }
      },
      child: IgnorePointer(
        child: buildWrapped(context),
      ),
    );
  }
}
