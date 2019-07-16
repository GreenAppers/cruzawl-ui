// Copyright 2019 cruzawl developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

import 'package:flutter_web/gestures.dart'
    if (dart.library.io) 'package:flutter/gestures.dart';
import 'package:flutter_web/material.dart'
    if (dart.library.io) 'package:flutter/material.dart';
import 'package:flutter_web/services.dart'
    if (dart.library.io) 'package:flutter/services.dart';

import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:scoped_model/scoped_model.dart';

import 'ui_html.dart' if (dart.library.io) 'ui_io.dart';

class SimpleScaffoldActions extends Model {
  final List<Widget> actions;
  SimpleScaffoldActions(this.actions);
}

class SimpleScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget secondColumn;
  SimpleScaffold(this.title, this.body, {this.secondColumn});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    SimpleScaffoldActions actions;
    try { actions = ScopedModel.of<SimpleScaffoldActions>(context); }
    catch(error) { actions = null; }

    return Scaffold(
        appBar: GradientAppBar(
          leading:
              backButtonBuilder != null ? backButtonBuilder(context) : null,
          title: Text(
            title,
            style: TextStyle(
              fontFamily: 'MartelSans',
            ),
          ),
          actions: actions == null ? null : actions.actions,
          backgroundColorStart: theme.primaryColor,
          backgroundColorEnd: theme.accentColor,
        ),
        body: secondColumn != null
            ? Row(children: <Widget>[
                Flexible(child: body),
                Flexible(child: secondColumn)
              ])
            : body);
  }
}

class PopupMenuBuilder {
  List<PopupMenuItem<int>> item = <PopupMenuItem<int>>[];
  List<VoidCallback> onSelectedCallback = <VoidCallback>[];

  PopupMenuBuilder addItem({Icon icon, String text, VoidCallback onSelected}) {
    onSelectedCallback.add(onSelected);
    if (icon != null) {
      item.add(PopupMenuItem<int>(
          child: Row(
            children: <Widget>[
              Container(padding: const EdgeInsets.all(8.0), child: icon),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Text(text),
              ),
            ],
          ),
          value: item.length));
    } else {
      item.add(PopupMenuItem<int>(child: Text(text), value: item.length));
    }
    return this;
  }

  Widget build(
      {Icon icon,
      Widget child,
      EdgeInsetsGeometry padding = const EdgeInsets.all(8.0)}) {
    return PopupMenuButton(
        icon: icon,
        child: child,
        padding: padding,
        itemBuilder: (_) => item,
        onSelected: (int v) {
          onSelectedCallback[v]();
        });
  }
}

class RaisedGradientButton extends StatelessWidget {
  final String labelText;
  final VoidCallback onPressed;
  final EdgeInsets padding;
  RaisedGradientButton(
      {this.labelText,
      this.onPressed,
      this.padding = const EdgeInsets.all(16)});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: padding,
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32.0),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [theme.primaryColor, theme.accentColor],
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey[500],
                  offset: Offset(0.0, 1.5),
                  blurRadius: 1.5,
                ),
              ],
            ),
            child: FlatButton.icon(
              color: Colors.transparent,
              icon: const Icon(
                Icons.send,
                color: Colors.white,
              ),
              label: Text(
                labelText,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: onPressed,
            ),
          ),
        ),
      ],
    );
  }
}

class TitledWidget extends StatelessWidget {
  final String title;
  final Widget content;
  TitledWidget({this.title, this.content});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
            width: double.maxFinite,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  theme.primaryColor,
                  theme.accentColor,
                ],
              ),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32.0),
                  topRight: Radius.circular(32.0)),
            ),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          content,
        ],
      ),
    );
  }
}

class HideableWidget extends StatefulWidget {
  final String title;
  final Widget child;
  HideableWidget({this.title, this.child});

  @override
  _HideableWidgetState createState() => _HideableWidgetState();
}

class _HideableWidgetState extends State<HideableWidget> {
  bool show = false;

  @override
  Widget build(BuildContext c) {
    final ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(top: 16),
          child: RichText(
            text: TextSpan(
              text: widget.title,
              style: TextStyle(
                fontFamily: 'MartelSans',
                color: Colors.grey,
              ),
              children: !show
                  ? null
                  : <TextSpan>[
                      TextSpan(text: ' ['),
                      TextSpan(
                        text: 'Hide',
                        style: TextStyle(
                          color: theme.accentColor,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => setState(() => show = false),
                      ),
                      TextSpan(text: ']'),
                    ],
            ),
          ),
        ),
        (show
            ? widget.child
            : RichText(
                text: TextSpan(
                  text: '[',
                  style: TextStyle(color: Colors.grey),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Show',
                      style: TextStyle(
                        color: theme.accentColor,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => setState(() => show = true),
                    ),
                    TextSpan(text: ']'),
                  ],
                ),
              )),
      ],
    );
  }
}

class CopyableText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final VoidCallback onTap;
  CopyableText(this.text, {this.style, this.onTap});

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.only(right: 32),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.content_copy),
              color: Theme.of(context).accentColor,
              onPressed: () => setClipboardText(context, text),
            ),
            Flexible(
              child: onTap == null
                  ? Text(text, style: style)
                  : GestureDetector(
                      child: Text(text),
                      onTap: onTap,
                    ),
            ),
          ],
        ),
      );

  static void setClipboardText(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text)).then((result) =>
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Copied.'))));
  }
}

List<DropdownMenuItem<String>> buildDropdownMenuItem(List<String> x) {
  return x
      .map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ))
      .toList();
}

Widget buildListTile(Widget title, bool wideStyle, Widget widget) {
  return wideStyle
      ? ListTile(title: title, trailing: widget)
      : Container(
          padding: EdgeInsets.only(bottom: 16),
          child: ListTile(title: Center(child: title), subtitle: widget));
}

Map<String, ThemeData> themes = <String, ThemeData>{
  'red': ThemeData(primarySwatch: Colors.red, accentColor: Colors.redAccent),
  'pink': ThemeData(primarySwatch: Colors.pink, accentColor: Colors.pinkAccent),
  'purple':
      ThemeData(primarySwatch: Colors.purple, accentColor: Colors.purpleAccent),
  'deepPurple': ThemeData(
      primarySwatch: Colors.deepPurple, accentColor: Colors.deepPurpleAccent),
  'indigo':
      ThemeData(primarySwatch: Colors.indigo, accentColor: Colors.indigoAccent),
  'blue': ThemeData(primarySwatch: Colors.blue, accentColor: Colors.blueAccent),
  'lightBlue': ThemeData(
      primarySwatch: Colors.lightBlue, accentColor: Colors.lightBlueAccent),
  'cyan': ThemeData(primarySwatch: Colors.cyan, accentColor: Colors.cyanAccent),
  'teal': ThemeData(primarySwatch: Colors.teal, accentColor: Colors.tealAccent),
  'green':
      ThemeData(primarySwatch: Colors.green, accentColor: Colors.greenAccent),
  'lightGreen': ThemeData(
      primarySwatch: Colors.lightGreen, accentColor: Colors.lightGreenAccent),
  'lime': ThemeData(primarySwatch: Colors.lime, accentColor: Colors.limeAccent),
  'yellow':
      ThemeData(primarySwatch: Colors.yellow, accentColor: Colors.yellowAccent),
  'amber':
      ThemeData(primarySwatch: Colors.amber, accentColor: Colors.amberAccent),
  'orange':
      ThemeData(primarySwatch: Colors.orange, accentColor: Colors.orangeAccent),
  'deepOrange': ThemeData(
      primarySwatch: Colors.deepOrange, accentColor: Colors.orangeAccent),
  'brown':
      ThemeData(primarySwatch: Colors.brown, accentColor: Colors.brown[100]),
  'blueGrey': ThemeData(
      primarySwatch: Colors.blueGrey, accentColor: Colors.blueGrey[100]),
};
