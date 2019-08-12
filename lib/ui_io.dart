// Copyright 2019 cruzawl developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:flutter/material.dart';

WidgetBuilder backButtonBuilder = null;

class EnterTextFormField extends StatelessWidget {
  TextEditingController controller;
  InputDecoration decoration;
  TextStyle style;
  Color cursorColor;
  bool autofocus, autocorrect;
  FormFieldValidator<String> validator;
  ValueChanged<String> onFieldSubmitted;
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
  Widget build(BuildContext context) => TextFormField(
      controller: controller,
      decoration: decoration,
      style: style,
      cursorColor: cursorColor,
      autofocus: autofocus,
      autocorrect: autocorrect,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted);
}
