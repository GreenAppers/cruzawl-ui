// Copyright 2019 cruzbit developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

import 'package:flutter_web/material.dart'
    if (dart.library.io) 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import 'package:cruzawl/currency.dart';
import 'package:cruzawl/cruz.dart';
import 'package:cruzawl/network.dart';

import 'transaction.dart';
import 'ui.dart';

class BlockWidget extends StatefulWidget {
  final Currency currency;
  final String blockId, title;
  final int blockHeight;
  final Widget loadingWidget;
  final double maxWidth;
  BlockWidget(this.currency,
      {this.blockId,
      this.blockHeight,
      this.loadingWidget,
      this.maxWidth,
      this.title});

  @override
  _BlockWidgetState createState() =>
      _BlockWidgetState(blockId == null && blockHeight == null);
}

class _BlockWidgetState extends State<BlockWidget> {
  bool isTip, loading = false;
  String blockId;
  int blockHeight;
  Block block;
  _BlockWidgetState(this.isTip);

  void load() async {
    if (loading || !widget.currency.network.hasPeer) return;
    loading = true;

    BlockMessage message;
    if ((blockHeight = widget.blockHeight) != null) {
      message = await (await widget.currency.network.getPeer())
          .getBlock(height: blockHeight);
      if (message != null) blockId = message.id.toJson();
    } else {
      blockId = widget.blockId ?? widget.currency.network.tipId.toJson();
      message = await (await widget.currency.network.getPeer())
          .getBlock(id: CruzBlockId.fromJson(blockId));
    }

    if (message != null) block = message.block;
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    if (!loading &&
        isTip &&
        widget.currency.network.tipId != null &&
        blockId != widget.currency.network.tipId.toJson()) {
      blockId = null;
      block = null;
    }

    if (block == null) {
      load();
      return widget.loadingWidget ??
          SimpleScaffold(
              "Loading...", Center(child: CircularProgressIndicator()));
    }

    final Size screenSize = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    final TextStyle linkStyle = TextStyle(
      color: theme.accentColor,
      decoration: TextDecoration.underline,
    );
    final TextStyle labelTextStyle = TextStyle(
      fontFamily: 'MartelSans',
      color: Colors.grey,
    );
    final bool wideStyle =
        screenSize.width > (widget.maxWidth ?? double.maxFinite);
    final String previousBlockId = block.header.previous.toJson();

    List<Widget> header = <Widget>[
      ListTile(
        title: Text('Time'),
        trailing: Text(widget.currency.formatTime(block.header.time)),
      ),
      ListTile(
        title: Text('Height'),
        trailing: Text(block.header.height.toString()),
      ),
      ListTile(
        title: Text('Target'),
        trailing: Text(wideStyle
            ? block.header.target.toJson()
            : widget.currency.formatTarget(block.header.target)),
      ),
      ListTile(
        title: Text('Nonce'),
        trailing: Text(block.header.nonce.toString()),
      ),
      buildListTile(
        Text('Id'),
        wideStyle,
        GestureDetector(
          child: Text(blockId, style: wideStyle ? linkStyle : null),
          onTap: () => Navigator.of(context).pushNamed('/block/' + blockId),
        ),
      ),
      buildListTile(
        Text('Previous'),
        wideStyle,
        GestureDetector(
          child: Text(previousBlockId, style: wideStyle ? linkStyle : null),
          onTap: () =>
              Navigator.of(context).pushNamed('/block/' + previousBlockId),
        ),
      ),
      buildListTile(
          Text('Chain Work'), wideStyle, Text(block.header.chainWork.toJson())),
      buildListTile(Text('Hash List Root'), wideStyle,
          Text(block.header.hashListRoot.toJson())),
    ];

    return SimpleScaffold(
      widget.title ?? (isTip ? "Tip " : "Block ") + blockId,
      Container(
        constraints: widget.maxWidth == null
            ? null
            : BoxConstraints(maxWidth: widget.maxWidth),
        child: ListView.builder(
          itemCount: header.length +
              (block.transactions.length > 0 ? 1 : 0) +
              block.transactions.length,
          itemBuilder: (BuildContext context, int index) {
            if (index < header.length) return header[index];
            if (index == header.length)
              return Center(
                  child: Text('Transactions (${block.header.transactionCount})',
                      style: labelTextStyle));
            int transactionIndex = index - header.length - 1;
            if (transactionIndex < block.transactions.length)
              return TransactionListTile(
                widget.currency,
                block.transactions[transactionIndex],
                TransactionInfo(wideStyle: wideStyle),
                onTap: (tx) => Navigator.of(context)
                    .pushNamed('/transaction/' + tx.id().toJson()),
                onFromTap: (tx) =>
                    Navigator.of(context).pushNamed('/address/' + tx.fromText),
                onToTap: (tx) =>
                    Navigator.of(context).pushNamed('/address/' + tx.toText),
              );
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
