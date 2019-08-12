// Copyright 2019 cruzawl developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

import 'package:flutter_web/gestures.dart'
    if (dart.library.io) 'package:flutter/gestures.dart';
import 'package:flutter_web/material.dart'
    if (dart.library.io) 'package:flutter/material.dart';

import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:cruzawl/currency.dart';
import 'package:cruzawl/network.dart';
import 'package:cruzawl/util.dart' hide VoidCallback;

import 'localization.dart';
import 'model.dart';
import 'ui_html.dart' if (dart.library.io) 'ui_io.dart';

bool useWideStyle(BuildContext context, double maxWidth) =>
    MediaQuery.of(context).size.width > (maxWidth ?? double.maxFinite);

class SimpleScaffoldActions extends Model {
  List<Widget> actions;
  String searchError;
  bool searchBar, showSearchBar = false, searching = false;
  SimpleScaffoldActions(this.actions, {this.searchBar = false});

  void toggleSearchBar() => setState(() => showSearchBar = !showSearchBar);

  void setSearching(bool v) => setState(() => searching = v);

  void setState(VoidCallback stateChangeCb) {
    stateChangeCb();
    notifyListeners();
  }

  String getSearchError(Localization locale) {
    if (searching) return locale.loading;
    String ret = searchError;
    searchError = null;
    return ret;
  }
}

class SimpleScaffold extends StatefulWidget {
  final String title;
  final Widget body, secondColumn, titleWidget, bottomNavigationBar;

  SimpleScaffold(this.body,
      {this.title,
      this.titleWidget,
      this.secondColumn,
      this.bottomNavigationBar});

  @override
  _SimpleScaffoldState createState() => _SimpleScaffoldState();
}

class _SimpleScaffoldState extends State<SimpleScaffold> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController searchController = TextEditingController();
  int queryHeight;
  BlockId queryBlock;
  PublicAddress queryAddress;
  TransactionId queryTransaction;
  bool foundBlock, foundTransaction;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Cruzawl appState = ScopedModel.of<Cruzawl>(context);
    final Localization locale = Localization.of(context);
    final ThemeData theme = Theme.of(context);
    SimpleScaffoldActions model;
    List<Widget> actions;

    try {
      model =
          ScopedModel.of<SimpleScaffoldActions>(context, rebuildOnChange: true);
      if (model.searchBar) {
        actions = <Widget>[
          model.searching
              ? CircularProgressIndicator()
              : IconButton(
                  icon: Icon(model.showSearchBar ? Icons.close : Icons.search),
                  color: theme.primaryTextTheme.title.color,
                  onPressed: () => toggleSearchBar(model),
                  padding: EdgeInsets.all(0),
                ),
        ];
        actions.addAll(model.actions);
      } else {
        actions = model.actions;
      }
      if (model.searchError != null) formKey.currentState.validate();
    } catch (error) {}

    TextStyle titleStyle = appState.theme.titleStyle;
    return Scaffold(
        appBar: GradientAppBar(
          leading:
              backButtonBuilder != null ? backButtonBuilder(context) : null,
          title: (model != null && model.showSearchBar)
              ? Theme(
                  data: ThemeData(
                    primaryColor: titleStyle.color,
                    accentColor: titleStyle.color,
                    hintColor: titleStyle.color,
                  ),
                  child: Form(
                      key: formKey,
                      child: EnterTextFormField(
                          controller: searchController,
                          decoration: InputDecoration(
                              prefixIcon: IconButton(
                                  icon: Icon(Icons.search,
                                      color: titleStyle.color),
                                  onPressed: () async =>
                                      await searchSubmit(context, model)),
                              hintText: locale.search,
                              hintStyle: titleStyle),
                          style: titleStyle,
                          cursorColor: Colors.white,
                          autofocus: true,
                          validator: (q) =>
                              model.getSearchError(locale) ??
                              validateQuery(q, appState, locale),
                          onFieldSubmitted: (q) async =>
                              await searchSubmit(context, model))))
              : (widget.titleWidget ??
                  Text(widget.title ?? locale.title, style: titleStyle)),
          actions: actions,
          backgroundColorStart: theme.primaryColor,
          backgroundColorEnd: theme.accentColor,
        ),
        body: widget.secondColumn != null
            ? Row(children: <Widget>[
                Flexible(child: widget.body),
                Flexible(child: widget.secondColumn)
              ])
            : widget.body,
        bottomNavigationBar: widget.bottomNavigationBar);
  }

  void toggleSearchBar(SimpleScaffoldActions model) {
    if (model.showSearchBar) model.setState(() => searchClear(model));
    else model.toggleSearchBar();
  }

  void searchClear(SimpleScaffoldActions model) {
    formKey.currentState.reset();
    searchController.clear();
    model.searching = false;
    model.showSearchBar = false;
    queryBlock = null;
    queryHeight = null;
    queryAddress = null;
    queryTransaction = null;
  }

  Future<void> searchSubmit(
      BuildContext context, SimpleScaffoldActions model) async {
    if (!formKey.currentState.validate()) return;
    final Cruzawl appState = ScopedModel.of<Cruzawl>(context);
    final Localization locale = Localization.of(context);

    if (queryAddress != null) {
      appState.navigateToAddressText(context, queryAddress.toJson());
      searchClear(model);
      return;
    } else if (queryHeight != null) {
      appState.navigateToHeight(context, queryHeight);
      searchClear(model);
      return;
    }

    assert(queryBlock != null || queryTransaction != null);
    model.setSearching(true);

    Peer peer = await appState.currency.network.getPeer();
    if (peer == null) return;
    Future<BlockHeaderMessage> getBlock;
    Future<TransactionMessage> getTxn;
    if (queryBlock != null) getBlock = peer.getBlockHeader(id: queryBlock);
    if (queryTransaction != null) {
      getTxn = peer.getTransaction(queryTransaction);
    }
    BlockHeaderMessage block = getBlock != null ? await getBlock : null;
    TransactionMessage transaction = getTxn != null ? await getTxn : null;

    if (block != null && block.header != null) {
      appState.navigateToBlockId(context, queryBlock.toJson());
      searchClear(model);
      return;
    }

    if (transaction != null && transaction.transaction != null) {
      appState.navigateToTransaction(context, transaction.transaction);
      searchClear(model);
      return;
    }

    model.searchError = locale.unknownQuery;
    model.setSearching(false);
  }

  String validateQuery(String query, Cruzawl appState, Localization locale) {
    query.trim();
    Currency currency = appState.currency;
    if (!currency.network.hasPeer) return locale.networkOffline;
    if ((queryAddress = currency.fromPublicAddressJson(query)) != null)
      return null;
    if (currency.fromPrivateKeyJson(query) != null) return locale.privateKey;
    if ((queryHeight = int.tryParse(query)) != null) {
      if (queryHeight < currency.network.tipHeight && queryHeight >= 0) {
        return null;
      } else {
        queryHeight = null;
      }
    }
    queryBlock = currency.fromBlockIdJson(query, true);
    queryTransaction = currency.fromTransactionIdJson(query, true);
    if (queryBlock != null || queryTransaction != null) return null;
    return locale.unknownQuery;
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
    final Localization locale = Localization.of(context);
    final Cruzawl appState = ScopedModel.of<Cruzawl>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(top: 16),
          child: RichText(
            text: TextSpan(
              text: widget.title,
              style: appState.theme.labelStyle,
              children: !show
                  ? null
                  : <TextSpan>[
                      TextSpan(text: ' '),
                      buildLocalizationMarkupTextSpan(
                        locale.menuOfOne(locale.hide),
                        tags: <String, LocalizationMarkup>{
                          'a': LocalizationMarkup(
                            style: appState.theme.linkStyle,
                            onTap: () => setState(() => show = false),
                          ),
                        },
                      ),
                    ],
            ),
          ),
        ),
        (show
            ? widget.child
            : RichText(
                text: buildLocalizationMarkupTextSpan(
                locale.menuOfOne(locale.show),
                style: appState.theme.labelStyle,
                tags: <String, LocalizationMarkup>{
                  'a': LocalizationMarkup(
                    style: appState.theme.linkStyle,
                    onTap: () => setState(() => show = true),
                  ),
                },
              ))),
      ],
    );
  }
}

class CopyableText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final VoidCallback onTap;
  final SetClipboardText setClipboardText;
  CopyableText(this.text, this.setClipboardText, {this.style, this.onTap});

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.only(right: 32),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.content_copy),
              color: ScopedModel.of<Cruzawl>(context).theme.linkColor,
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

class AppTheme {
  ThemeData data;
  Color linkColor;
  String titleFont;
  TextStyle titleStyle, labelStyle, linkStyle;
  AppTheme(this.data, {this.linkColor}) {
    linkColor = linkColor ?? data.primaryColor;
  }
}

Map<String, AppTheme> themes = <String, AppTheme>{
  'red': AppTheme(
      ThemeData(primarySwatch: Colors.red, accentColor: Colors.redAccent)),
  'pink': AppTheme(
      ThemeData(primarySwatch: Colors.pink, accentColor: Colors.pinkAccent)),
  'purple': AppTheme(ThemeData(
      primarySwatch: Colors.purple, accentColor: Colors.purpleAccent)),
  'deepPurple': AppTheme(ThemeData(
      primarySwatch: Colors.deepPurple, accentColor: Colors.deepPurpleAccent)),
  'indigo': AppTheme(ThemeData(
      primarySwatch: Colors.indigo, accentColor: Colors.indigoAccent)),
  'blue': AppTheme(
      ThemeData(primarySwatch: Colors.blue, accentColor: Colors.blueAccent)),
  'lightBlue': AppTheme(ThemeData(
      primarySwatch: Colors.lightBlue, accentColor: Colors.lightBlueAccent)),
  'cyan': AppTheme(
      ThemeData(primarySwatch: Colors.cyan, accentColor: Colors.cyanAccent)),
  'teal': AppTheme(
      ThemeData(primarySwatch: Colors.teal, accentColor: Colors.tealAccent)),
  'green': AppTheme(
      ThemeData(primarySwatch: Colors.green, accentColor: Colors.greenAccent)),
  'lightGreen': AppTheme(ThemeData(
      primarySwatch: Colors.lightGreen, accentColor: Colors.lightGreenAccent)),
  'lime': AppTheme(
      ThemeData(primarySwatch: Colors.lime, accentColor: Colors.limeAccent)),
  'yellow': AppTheme(ThemeData(
      primarySwatch: Colors.yellow, accentColor: Colors.yellowAccent)),
  'amber': AppTheme(
      ThemeData(primarySwatch: Colors.amber, accentColor: Colors.amberAccent)),
  'orange': AppTheme(ThemeData(
      primarySwatch: Colors.orange, accentColor: Colors.orangeAccent)),
  'deepOrange': AppTheme(
      ThemeData(
          primarySwatch: Colors.deepOrange, accentColor: Colors.orangeAccent),
      linkColor: Colors.orangeAccent),
  'brown': AppTheme(
      ThemeData(primarySwatch: Colors.brown, accentColor: Colors.brown[100])),
  'blueGrey': AppTheme(ThemeData(
      primarySwatch: Colors.blueGrey, accentColor: Colors.blueGrey[100])),
};
