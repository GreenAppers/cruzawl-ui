// Copyright 2019 cruzawl developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:flutter_web/material.dart';

WidgetBuilder backButtonBuilder = (BuildContext context) => GestureDetector(
    child:
        Center(child: Container(
          margin: EdgeInsets.all(3),
          child: Image.asset('cruzbit.png'),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey[500],
                offset: Offset(0.0, 1.5),
                blurRadius: 1.5,
              ),
            ],
          ),
        )),
    onTap: () {
      Navigator.of(context).pushNamed('/');
      window.history.replaceState({}, '', '/#/');
    });
