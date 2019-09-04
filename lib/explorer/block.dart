// Copyright 2019 cruzawl developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:flutter_web/material.dart'
    if (dart.library.io) 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import 'package:cruzawl/currency.dart';
import 'package:cruzawl/cruz.dart';
import 'package:cruzawl/network.dart';

import '../localization.dart';
import '../model.dart';
import '../ui.dart';

class BlockWidget extends StatefulWidget {
  final PeerNetwork network;
  final String blockId, title;
  final int blockHeight;
  final Widget loadingWidget;
  final double maxWidth;
  BlockWidget(this.network,
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
  String blockId, nextBlockId;
  int blockHeight;
  Block block;
  BlockHeader prevBlock;
  _BlockWidgetState(this.isTip);

  void load() async {
    if (loading || !widget.network.hasPeer) return;
    Peer peer = await widget.network.getPeer();
    loading = true;

    BlockMessage message;
    if ((blockHeight = widget.blockHeight) != null) {
      message = await peer.getBlock(height: blockHeight);
      if (message != null) blockId = message.id.toJson();
    } else {
      blockId = widget.blockId ?? widget.network.tipId.toJson();
      message = await peer.getBlock(id: CruzBlockId.fromJson(blockId));
    }

    if (message != null) {
      if (message.block.header.previous != null) {
        BlockHeaderMessage prevMessage =
            await peer.getBlockHeader(id: message.block.header.previous);
        if (prevMessage != null) prevBlock = prevMessage.header;
      }
      if (!isTip) {
        BlockHeaderMessage nextMessage =
            await peer.getBlockHeader(height: message.block.header.height + 1);
        if (nextMessage != null && nextMessage.id != null)
          nextBlockId = nextMessage.id.toJson();
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
        widget.network.tipId != null &&
        blockId != widget.network.tipId.toJson()) {
      blockId = null;
      block = null;
    }

    final Localization locale = Localization.of(context);
    if (block == null) {
      load();
      return widget.loadingWidget ??
          SimpleScaffold(Center(child: CircularProgressIndicator()),
              title: locale.loading);
    }

    final Cruzawl appState = ScopedModel.of<Cruzawl>(context);
    final Size screenSize = MediaQuery.of(context).size;
    final TextStyle linkStyle = appState.theme.linkStyle;
    final TextStyle labelTextStyle = appState.theme.labelStyle;
    final bool wideStyle =
        screenSize.width > (widget.maxWidth ?? double.maxFinite);
    final String previousBlockId = block.header.previous.toJson();

    List<Widget> header = <Widget>[
      ListTile(
        title: Text(locale.time),
        trailing: Text(block.header.dateTime.toString()),
      ),
      ListTile(
        title: Text(locale.height),
        trailing: GestureDetector(
          child: Text(block.header.height.toString(),
              style: wideStyle ? linkStyle : null),
          onTap: () => appState.navigateToHeight(context, block.header.height),
        ),
      ),
    ];

    if (prevBlock != null) {
      Duration duration = block.header.deltaTime(prevBlock);
      if (duration.inSeconds > 0) {
        header.add(
          ListTile(
            title: Text(locale.deltaTime),
            trailing: Text(locale.formatShortDuration(duration)),
          ),
        );
        header.add(
          ListTile(
            title: Text(locale.deltaHashPower),
            trailing:
                Text(locale.formatHashRate(block.header.hashRate(prevBlock))),
          ),
        );
      }
    }

    header.add(
      ListTile(
        title: Text(locale.nonce),
        trailing: Text(block.header.nonce.toString()),
      ),
    );

    if (block.transactions[0].memo != null) {
      header.add(
        buildListTile(
          Text(locale.memo),
          wideStyle,
          Text(block.transactions[0].memo),
        ),
      );
    }

    header.add(
      buildListTile(
        Text(locale.id),
        wideStyle,
        GestureDetector(
          child: Text(blockId, style: wideStyle ? linkStyle : null),
          onTap: () => appState.navigateToBlockId(context, blockId),
        ),
      ),
    );

    header.add(
      buildListTile(
        Text(locale.previous),
        wideStyle,
        GestureDetector(
          child: Text(previousBlockId, style: wideStyle ? linkStyle : null),
          onTap: () => appState.navigateToBlockId(context, previousBlockId),
        ),
      ),
    );

    if (nextBlockId != null)
      header.add(
        buildListTile(
          Text(locale.next),
          wideStyle,
          GestureDetector(
            child: Text(nextBlockId, style: wideStyle ? linkStyle : null),
            onTap: () => appState.navigateToBlockId(context, nextBlockId),
          ),
        ),
      );

    header.add(
      buildListTile(
        Text(locale.target),
        wideStyle,
        Text(block.header.target.toJson()),
      ),
    );

    header.add(
      buildListTile(Text(locale.chainWork), wideStyle,
          Text(block.header.chainWork.toJson())),
    );

    header.add(
      buildListTile(Text(locale.hashListRoot), wideStyle,
          Text(block.header.hashListRoot.toJson())),
    );

    List<Widget> footer = <Widget>[
      RaisedGradientButton(
        labelText: locale.copy,
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
                  child: Text(
                      locale.numTransactions(block.header.transactionCount),
                      style: labelTextStyle));
            int transactionIndex = index - header.length - 1;
            if (transactionIndex < block.transactions.length) {
              return TransactionListTile(
                widget.network.currency,
                block.transactions[transactionIndex],
                TransactionInfo(wideStyle: wideStyle),
                onTap: (tx) => appState.navigateToTransaction(context, tx),
                onFromTap: (tx) =>
                    appState.navigateToAddressText(context, tx.fromText),
                onToTap: (tx) =>
                    appState.navigateToAddressText(context, tx.toText),
              );
            } else {
              int footerIndex = transactionIndex - block.transactions.length;
              if (footerIndex < footer.length) return footer[footerIndex];
              return null;
            }
          },
        ),
      ),
      title:
          widget.title ?? (isTip ? locale.tip : locale.block) + ' ' + blockId,
    );
  }
}
