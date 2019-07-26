// Copyright 2019 cruzawl developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:flutter_web/material.dart'
    if (dart.library.io) 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import 'package:cruzawl/currency.dart';
import 'package:cruzawl/cruz.dart';
import 'package:cruzawl/network.dart';

import 'transaction.dart';
import 'ui.dart';
import 'model.dart';

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
  BlockHeader prevBlock;
  _BlockWidgetState(this.isTip);

  void load() async {
    if (loading || !widget.currency.network.hasPeer) return;
    Peer peer = await widget.currency.network.getPeer();
    loading = true;

    BlockMessage message;
    if ((blockHeight = widget.blockHeight) != null) {
      message = await peer.getBlock(height: blockHeight);
      if (message != null) blockId = message.id.toJson();
    } else {
      blockId = widget.blockId ?? widget.currency.network.tipId.toJson();
      message = await peer.getBlock(id: CruzBlockId.fromJson(blockId));
    }

    if (message != null) {
      if (message.block.header.previous != null) {
        BlockHeaderMessage prevMessage =
            await peer.getBlockHeader(id: message.block.header.previous);
        if (prevMessage != null) prevBlock = prevMessage.header;
      }
      block = message.block;
    }

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
          SimpleScaffold(Center(child: CircularProgressIndicator()),
              title: "Loading...");
    }

    final Cruzawl appState = ScopedModel.of<Cruzawl>(context);
    final Size screenSize = MediaQuery.of(context).size;
    final TextStyle linkStyle = TextStyle(
      color: appState.theme.linkColor,
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
    ];

    if (prevBlock != null) {
      Duration duration = Duration(seconds: block.header.time - prevBlock.time);
      int seconds = duration.inSeconds - duration.inMinutes * 60;
      header.add(
        ListTile(
          title: Text('Delta Time'),
          trailing: Text(duration.inMinutes > 0
              ? ('${duration.inMinutes} minutes' +
                  (seconds != 0 ? ' $seconds seconds' : ''))
              : '${duration.inSeconds} seconds'),
        ),
      );
      if (duration.inSeconds > 0)
        header.add(
          ListTile(
            title: Text('Delta Hash Power'),
            trailing: Text(
                widget.currency.formatHashRate(block.header.hashRate(prevBlock))),
          ),
        );
    }

    header.add(
      ListTile(
        title: Text('Nonce'),
        trailing: Text(block.header.nonce.toString()),
      ),
    );

    header.add(
      buildListTile(
        Text('Id'),
        wideStyle,
        GestureDetector(
          child: Text(blockId, style: wideStyle ? linkStyle : null),
          onTap: () => Navigator.of(context).pushNamed('/block/' + blockId),
        ),
      ),
    );

    header.add(
      buildListTile(
        Text('Previous'),
        wideStyle,
        GestureDetector(
          child: Text(previousBlockId, style: wideStyle ? linkStyle : null),
          onTap: () =>
              Navigator.of(context).pushNamed('/block/' + previousBlockId),
        ),
      ),
    );

    header.add(
      buildListTile(
        Text('Target'),
        wideStyle,
        Text(block.header.target.toJson()),
      ),
    );

    header.add(
      buildListTile(
          Text('Chain Work'), wideStyle, Text(block.header.chainWork.toJson())),
    );

    header.add(
      buildListTile(Text('Hash List Root'), wideStyle,
          Text(block.header.hashListRoot.toJson())),
    );

    List<Widget> footer = <Widget>[
      RaisedGradientButton(
        labelText: 'Copy',
        onPressed: () => appState.setClipboardText(context, jsonEncode(block)),
      )
    ];

    return SimpleScaffold(
      Container(
        constraints: widget.maxWidth == null
            ? null
            : BoxConstraints(maxWidth: widget.maxWidth),
        child: ListView.builder(
          itemCount: header.length +
              footer.length +
              (block.transactions.length > 0 ? 1 : 0) +
              block.transactions.length,
          itemBuilder: (BuildContext context, int index) {
            if (index < header.length) return header[index];
            if (index == header.length)
              return Center(
                  child: Text('Transactions (${block.header.transactionCount})',
                      style: labelTextStyle));
            int transactionIndex = index - header.length - 1;
            if (transactionIndex < block.transactions.length) {
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
            } else {
              int footerIndex = transactionIndex - block.transactions.length;
              if (footerIndex < footer.length) return footer[footerIndex];
              return null;
            }
          },
        ),
      ),
      title: widget.title ?? (isTip ? "Tip " : "Block ") + blockId,
    );
  }
}
