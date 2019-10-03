// Copyright 2019 cruzawl developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:cruzawl/currency.dart';
import 'package:cruzawl/network.dart';

import 'package:cruzawl_ui/localization.dart';
import 'package:cruzawl_ui/model.dart';
import 'package:cruzawl_ui/ui_html.dart'
    if (dart.library.io) 'package:cruzawl_ui/ui_io.dart';
export 'package:cruzawl_ui/ui_html.dart'
    if (dart.library.io) 'package:cruzawl_ui/ui_io.dart';

/// Passed to onTap to trigger hover highlight.
void nullOp() {}

/// Use desktop instead of mobile style if [maxWidth] exceeded.
bool useWideStyle(BuildContext context, double maxWidth) =>
    MediaQuery.of(context).size.width > (maxWidth ?? double.maxFinite);

/// [Model] controlling [GradientAppBar.actions] for [SimpleScaffold].
class SimpleScaffoldActions extends Model {
  /// The actions [SimpleScaffold] should supply [AppBar].
  List<Widget> actions;

  /// Search error text;
  String searchError;

  /// Enables an [AppBar] search box.
  bool searchBar;

  /// If the search box is currently displayed.
  bool showSearchBar = false;

  /// If currently fetching search results.
  bool searching = false;

  SimpleScaffoldActions(this.actions, {this.searchBar = false});

  /// Toggle the search box, e.g. if user tapped the search icon.
  void toggleSearchBar() => setState(() => showSearchBar = !showSearchBar);

  /// Set when sending search queries and cleared after receving results.
  void setSearching(bool v) => setState(() => searching = v);

  /// Like [State.setState()] for this [Model].
  void setState(VoidCallback stateChangeCb) {
    stateChangeCb();
    notifyListeners();
  }

  /// Retrieves and clears the search error, if any.
  String getSearchError(Localization l10n) {
    if (searching) return l10n.loading;
    String ret = searchError;
    searchError = null;
    return ret;
  }
}

/// A [Scaffold] with [GradientAppBar] and [SimpleScaffoldActions] controls.
class SimpleScaffold extends StatefulWidget {
  /// Specifies [GradientAppBar.title] as [Text] with [title].
  final String title;

  /// Specifies [GradientAppBar.title] with [titleWidget].
  final Widget titleWidget;

  /// The [Scaffold.body].
  final Widget body;

  /// Optionally place [secondColumn] next to [body].
  final Widget secondColumn;

  /// Optionally adds a bottom navigation bar.
  final Widget bottomNavigationBar;

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
    final Localization l10n = Localization.of(context);
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
                  tooltip: model.showSearchBar ? l10n.cancel : l10n.search,
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
    } catch (error) {
      // ignore missing ScopedModel exception
    }

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
                                  tooltip: l10n.submit,
                                  icon: Icon(Icons.search,
                                      color: titleStyle.color),
                                  onPressed: () async =>
                                      await searchSubmit(context, model)),
                              hintText: l10n.search,
                              hintStyle: titleStyle),
                          style: titleStyle,
                          cursorColor: Colors.white,
                          autofocus: true,
                          validator: (q) =>
                              model.getSearchError(l10n) ??
                              validateQuery(q, appState, l10n),
                          onFieldSubmitted: (q) async =>
                              await searchSubmit(context, model))))
              : (widget.titleWidget ??
                  Text(widget.title ?? l10n.title, style: titleStyle)),
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
    if (model.showSearchBar) {
      model.setState(() => searchClear(model));
    } else {
      model.toggleSearchBar();
    }
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
    final Localization l10n = Localization.of(context);

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

    Peer peer = await appState.network.getPeer();
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

    model.searchError = l10n.unknownQuery;
    model.setSearching(false);
  }

  String validateQuery(String query, Cruzawl appState, Localization l10n) {
    query.trim();
    Currency currency = appState.currency;
    PeerNetwork network = appState.network;
    if (!network.hasPeer) return l10n.networkOffline;
    if ((queryAddress = currency.fromPublicAddressJson(query)) != null) {
      return null;
    }
    if (currency.fromPrivateKeyJson(query) != null) return l10n.privateKey;
    if ((queryHeight = int.tryParse(query)) != null) {
      if (queryHeight < network.tipHeight && queryHeight >= 0) {
        return null;
      } else {
        queryHeight = null;
      }
    }
    queryBlock = currency.fromBlockIdJson(query, true);
    queryTransaction = currency.fromTransactionIdJson(query, true);
    if (queryBlock != null || queryTransaction != null) return null;
    return l10n.unknownQuery;
  }
}

/// Simple model for [PopupMenuButton].
class PopupMenuBuilder {
  /// List of [PopupMenuItem] actions.
  List<PopupMenuItem<int>> item = <PopupMenuItem<int>>[];

  /// Called by corresponding [item]'s [PopupMenuButton.onSelected].
  List<VoidCallback> onSelectedCallback = <VoidCallback>[];

  /// Add actions to the [PopupMenuButton] returned by [build()].
  PopupMenuBuilder addItem(
      {IconData icon, String text, VoidCallback onSelected}) {
    onSelectedCallback.add(onSelected);
    if (icon != null) {
      item.add(PopupMenuItem<int>(
          child: Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Icon(icon, color: Colors.grey),
              ),
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

  /// Build the [PopupMenuButton].
  Widget build(
      {Icon icon,
      Widget child,
      String tooltip,
      EdgeInsetsGeometry padding = const EdgeInsets.all(8.0)}) {
    return PopupMenuButton(
        icon: icon,
        child: child,
        padding: padding,
        tooltip: tooltip,
        itemBuilder: (_) => item,
        onSelected: (int v) {
          onSelectedCallback[v]();
        });
  }
}

/// Gradient filled [FlatButton] with [BoxShadow].
class RaisedGradientButton extends StatelessWidget {
  /// Text labeling this button.
  final String labelText;

  /// Icon for this button.
  final IconData icon;

  /// Called when this button pressed.
  final VoidCallback onPressed;

  /// Padding for this button.
  final EdgeInsets padding;

  RaisedGradientButton(
      {this.labelText,
      this.onPressed,
      this.icon = Icons.send,
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
              icon: icon == null ? null : Icon(icon, color: Colors.white),
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

/// Gradient and title for [AlertDialog.content].
class TitledWidget extends StatelessWidget {
  /// The title for this widget.
  final String title;

  /// The content for this widget.
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

/// Widget providing an underlined hyperlink that highlights on hover.
class HyperLinkWidget extends StatefulWidget {
  final Key key;
  final Widget child;
  final String text, semanticsLabel;
  final TextStyle style;
  final Color hoverBackground, hoverForeground;
  final VoidCallback onTap;
  HyperLinkWidget(
      {this.key,
      this.child,
      this.text,
      this.semanticsLabel,
      this.style,
      this.hoverBackground,
      this.hoverForeground,
      this.onTap});

  @override
  _HyperLinkWidgetState createState() => _HyperLinkWidgetState();
}

class _HyperLinkWidgetState extends State<HyperLinkWidget> {
  bool hover = false;

  @override
  Widget build(BuildContext c) => widget.onTap != null
      ? (widget.hoverBackground != null
          ? Material(
              color: Colors.transparent,
              textStyle: (hover && widget.style != null)
                  ? widget.style.copyWith(color: widget.hoverForeground)
                  : widget.style,
              child: buildInkWell())
          : buildInkWell())
      : buildText();

  Widget buildInkWell() => InkWell(
      onTap: widget.onTap,
      hoverColor: widget.hoverBackground,
      onHover: widget.hoverForeground != null
          ? (bool v) => setState(() => hover = v)
          : null,
      child: widget.child ?? buildText());

  Widget buildText() => Text(widget.text,
      key: widget.key,
      style: (hover && widget.style != null)
          ? widget.style.copyWith(color: widget.hoverForeground)
          : widget.style,
      semanticsLabel: widget.semanticsLabel);
}

/// Widget for optionally displaying private information.
class HideableWidget extends StatefulWidget {
  /// Title of the private information.
  final String title;

  /// The private information to optionally display.
  final Widget child;

  HideableWidget({this.title, this.child});

  @override
  _HideableWidgetState createState() => _HideableWidgetState();
}

class _HideableWidgetState extends State<HideableWidget> {
  bool show = false;

  @override
  Widget build(BuildContext c) {
    final Localization l10n = Localization.of(context);
    final Cruzawl appState = ScopedModel.of<Cruzawl>(context);
    final Widget title = Text(widget.title, style: appState.theme.labelStyle);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(top: 16),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: !show
                  ? <Widget>[title]
                  : (buildLocalizationMarkupWidgets(
                      ' ' + l10n.menuOfOne(l10n.hide),
                      style: appState.theme.labelStyle,
                      tags: <String, LocalizationMarkup>{
                        'a': LocalizationMarkup(
                          style: appState.theme.linkStyle,
                          onTap: () => setState(() => show = false),
                        ),
                      },
                    )..insert(0, title))),
        ),
        (show
            ? widget.child
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: buildLocalizationMarkupWidgets(
                  l10n.menuOfOne(l10n.show),
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

/// Adds copy icon before [text].
class CopyableText extends StatelessWidget {
  /// The text to display and optionally copy.
  final String text;

  /// The [TextStyle] for [text].
  final TextStyle style;

  /// Called when text is tapped.
  final VoidCallback onTap;

  /// Called when copy icon is pressed
  final SetClipboardText setClipboardText;

  CopyableText(this.text, this.setClipboardText, {this.style, this.onTap});

  @override
  Widget build(BuildContext context) {
    final Localization l10n = Localization.of(context);
    return Container(
      padding: EdgeInsets.only(right: 32),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            tooltip: l10n.copy,
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
}

/// Returns list of [DropdownMenuItem] with value x, and child Text(x).
List<DropdownMenuItem<String>> buildDropdownMenuItem(List<String> x) {
  return x
      .map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ))
      .toList();
}

/// Returns [ListTile] styled for desktop or mobile depending on [wideStyle].
Widget buildListTile(Widget title, bool wideStyle, Widget widget) {
  return wideStyle
      ? ListTile(title: title, trailing: widget, onTap: nullOp)
      : Container(
          padding: EdgeInsets.only(bottom: 16),
          child: ListTile(
              title: Center(child: title), subtitle: widget, onTap: nullOp));
}

/// [ThemeData] and further customizations.
class AppTheme {
  /// The [ThemeData] for this app.
  ThemeData data;

  /// Color to use for links, e.g. [data.primaryColor].
  Color linkColor;

  /// Color to use on link hover, e.g. [data.accentColor].
  Color hoverLinkColor;

  /// Font to use in [AppBar].
  String titleFont;

  /// Style to use in [AppBar].
  TextStyle titleStyle;

  /// Style to use for labels.
  TextStyle labelStyle;

  /// Style to use for links, e.g. underlined [data.accentColor].
  TextStyle linkStyle;

  AppTheme(this.data, {this.linkColor, this.hoverLinkColor}) {
    linkColor = linkColor ?? data.primaryColor;
    hoverLinkColor = hoverLinkColor ?? data.accentColor;
  }
}

/// Supported themes.
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
      linkColor: Colors.orangeAccent,
      hoverLinkColor: Colors.deepOrange),
  'brown': AppTheme(
      ThemeData(primarySwatch: Colors.brown, accentColor: Colors.brown[100])),
  'blueGrey': AppTheme(ThemeData(
      primarySwatch: Colors.blueGrey, accentColor: Colors.blueGrey[100])),
};

/// [ListTile] describing a [Transaction].
class TransactionListTile extends StatelessWidget {
  /// The [Currency] for this transaction.
  final Currency currency;

  /// The [Transaction] data.
  final Transaction tx;

  /// The associated [TransactionInfo], e.g. is this transaction to/from our wallet?
  final TransactionInfo info;

  /// Called when the [ListTile] is tapped.
  final TransactionCallback onTap;

  /// Called when the [Transaction.from] text is tapped.
  final TransactionCallback onFromTap;

  /// Called when the [Transaction.to] text is tapped.
  final TransactionCallback onToTap;

  TransactionListTile(this.currency, this.tx, this.info,
      {this.onTap, this.onFromTap, this.onToTap});

  @override
  Widget build(BuildContext context) {
    final Localization l10n = Localization.of(context);
    final Cruzawl appState = ScopedModel.of<Cruzawl>(context);
    final bool toTap = info.wideStyle && onToTap != null;
    final bool fromTap = info.wideStyle && onFromTap != null;
    final bool amountLink = info.wideStyle && onTap != null;
    final bool singleToAddress = tx.outputs.length == 1;
    final bool singleFromAddress = tx.inputs.length == 1;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: ListTile(
        title: info.wideStyle
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: buildLocalizationMarkupWidgets(
                  singleToAddress
                      ? l10n
                          .toAddress('{@<a>}${tx.outputs.first.toText}{@</a>}')
                      : l10n.itemId('{@<a>}${tx.hash.toJson()}{@</a>}'),
                  style: appState.theme.labelStyle,
                  tags: <String, LocalizationMarkup>{
                    'a': LocalizationMarkup(
                      style: toTap ? appState.theme.linkStyle : null,
                      hoverForeground:
                          toTap ? appState.theme.hoverLinkColor : null,
                      onTap: onToTap == null ? null : () => onToTap(tx),
                    ),
                  },
                ),
              )
            : GestureDetector(
                child: Text(singleToAddress
                    ? l10n.toAddress(
                        tx.outputs.first.toText ?? l10n.unableToDecode)
                    : l10n.itemId(tx.hash.toJson())),
                onTap: onToTap == null ? null : () => onToTap(tx)),
        subtitle: (!singleToAddress && !singleFromAddress)
            ? null
            : (info.wideStyle
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: buildLocalizationMarkupWidgets(
                      singleFromAddress
                          ? l10n.fromAddress(
                              '{@<a>}${tx.inputs.first.fromText}{@</a>}')
                          : l10n.itemId('{@<a>}${tx.hash.toJson()}{@</a>}'),
                      style: appState.theme.labelStyle,
                      tags: <String, LocalizationMarkup>{
                        'a': LocalizationMarkup(
                          style: fromTap ? appState.theme.linkStyle : null,
                          hoverForeground:
                              toTap ? appState.theme.hoverLinkColor : null,
                          onTap: onFromTap == null ? null : () => onFromTap(tx),
                        ),
                      },
                    ),
                  )
                : GestureDetector(
                    child: Text(singleFromAddress
                        ? l10n.fromAddress(
                            tx.inputs.first.fromText ?? l10n.unableToDecode)
                        : l10n.itemId(tx.hash.toJson())),
                    onTap: onFromTap == null ? null : () => onFromTap(tx))),
        trailing: HyperLinkWidget(
          text: info.amountPrefix +
              currency.format(tx.amount + (info.fromWallet ? tx.fee : 0)),
          style: (amountLink && !info.fromWallet && !info.toWallet)
              ? appState.theme.linkStyle
              : TextStyle(color: info.color).apply(
                  decoration: amountLink ? TextDecoration.underline : null),
          hoverForeground: amountLink ? appState.theme.hoverLinkColor : null,
          onTap: onTap == null ? null : () => onTap(tx),
        ),
      ),
    );
  }
}

/// [ListTile] describing an [Address].
class AddressListTile extends StatelessWidget {
  /// The [Currency] for this transaction.
  final Currency currency;

  /// The [Address.publicKey] text.
  final String text;

  /// The name of this address, e.g. from [Contact] list.
  final String name;

  /// An icon for this address, e.g. a Jdenticon.
  final Widget icon;

  /// The balance for this address.
  final num balance;

  /// Called when the [ListTile] is tapped.
  final VoidCallback onTap;

  AddressListTile(this.currency, this.text, this.icon,
      {this.name, this.balance, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: ListTile(
        title: Text(name ?? text),
        subtitle: name == null ? null : Text(text),
        leading: icon,
        trailing: balance == null
            ? null
            : Text(
                currency.format(balance),
                style: balance > 0 ? TextStyle(color: Colors.green) : null,
              ),
        onTap: onTap ?? () => Navigator.of(context).pop(text),
      ),
    );
  }
}

/// [Row] describing an [Address].
class AddressRow extends StatelessWidget {
  /// The name of this address, e.g. from [Contact] list.
  final String name;

  /// An icon for this address, e.g. a Jdenticon.
  final Widget icon;

  AddressRow(this.name, this.icon);

  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.only(left: 32, top: 32, right: 72, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          icon,
          Flexible(
              child: Text(name, maxLines: 2, overflow: TextOverflow.ellipsis))
        ],
      ));
}
