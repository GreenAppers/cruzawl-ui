// Copyright 2019 cruzawl developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:flutter_web/material.dart';

WidgetBuilder backButtonBuilder = (BuildContext context) => GestureDetector(
    child:
        Center(child: Text('CRUZ', style: TextStyle(fontFamily: 'MartelSans'))),
    onTap: () {
      Navigator.of(context).pushNamed('/');
      window.history.replaceState({}, '', '/#/');
    });
