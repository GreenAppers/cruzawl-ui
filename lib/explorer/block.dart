// Copyright 2019 cruzawl developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

/// In-depth single [Block] explorer
library explorer_block;

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import 'package:cruzawl/currency.dart';
import 'package:cruzawl/network.dart';

import 'package:cruzawl_ui/localization.dart';
import 'package:cruzawl_ui/model.dart';
import 'package:cruzawl_ui/ui.dart';

/// Explore the transactions and metadata for one [Block].
class BlockWidget extends StatefulWidget {
  /// The [PeerNetwork] to retrieve the [Block] from.
  final PeerNetwork network;

  /// The title for this [Widget].
  final String title;

  /// Queries the [Block] with [BlockHeader.id()].
  final String blockId;

  /// Queries the [Block] with [BlockHeader.height].
  final int blockHeight;

  /// Displayed while fetching data.
  final Widget loadingWidget;

  /// If specified, the maximum width used.
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
    if (loading ||
        !widget.network.hasPeer ||
        (widget.blockId != null && widget.blockId.isEmpty)) {
      return;
    }
    loading = true;
    Peer peer = await widget.network.getPeer();

    BlockMessage message;
    if ((blockHeight = widget.blockHeight) != null) {
      message = await peer.getBlock(height: blockHeight);
      if (message != null) blockId = message.id.toJson();
    } else {
      blockId = widget.blockId ?? widget.network.tipId.toJson();
      message = await peer.getBlock(
          id: widget.network.currency.fromBlockIdJson(blockId));
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
        if (nextMessage != null && nextMessage.id != null) {
          nextBlockId = nextMessage.id.toJson();
        }
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

    final Localization l10n = Localization.of(context);
    if (block == null) {
      load();
      return widget.loadingWidget ??
          SimpleScaffold(Center(child: CircularProgressIndicator()),
              title: l10n.loading);
    }

    final Cruzawl appState = ScopedModel.of<Cruzawl>(context);
    final Size screenSize = MediaQuery.of(context).size;
    final TextStyle linkStyle = appState.theme.linkStyle;
    final TextStyle labelTextStyle = appState.theme.labelStyle;
    final bool wideStyle =
        screenSize.width > (widget.maxWidth ?? double.maxFinite);
    final String previousBlockId = block.header.previous.toJson();
    final ThemeData theme = Theme.of(context);
    final TextStyle subtitleStyle =
        theme.textTheme.body1.copyWith(color: theme.textTheme.caption.color);

    List<Widget> header = <Widget>[
      ListTile(
        onTap: nullOp,
        title: Text(l10n.time),
        trailing: Text(block.header.dateTime.toString()),
      ),
      ListTile(
        onTap: nullOp,
        title: Text(l10n.height),
        trailing: HyperLinkWidget(
          text: block.header.height.toString(),
          style: wideStyle ? linkStyle : null,
          hoverForeground: wideStyle ? appState.theme.hoverLinkColor : null,
          onTap: () => appState.navigateToHeight(context, block.header.height),
        ),
      ),
    ];

    if (prevBlock != null) {
      Duration duration = block.header.deltaTime(prevBlock);
      if (duration.inSeconds > 0) {
        header.add(
          ListTile(
            onTap: nullOp,
            title: Text(l10n.deltaTime),
            trailing: Text(l10n.formatShortDuration(duration)),
          ),
        );
        header.add(
          ListTile(
            onTap: nullOp,
            title: Text(l10n.deltaHashPower),
            trailing:
                Text(l10n.formatHashRate(block.header.hashRate(prevBlock))),
          ),
        );
      }
    }

    header.add(
      ListTile(
        onTap: nullOp,
        title: Text(l10n.nonce),
        trailing: Text(block.header.nonceValue.toString()),
      ),
    );

    if (block.transactions != null &&
        block.transactions.isNotEmpty &&
        block.transactions.first.memo != null) {
      header.add(
        buildListTile(
          Text(l10n.memo),
          wideStyle,
          Text(block.transactions.first.memo),
        ),
      );
    }

    header.add(
      buildListTile(
        Text(l10n.id),
        wideStyle,
        HyperLinkWidget(
          text: blockId,
          style: wideStyle ? linkStyle : subtitleStyle,
          hoverForeground: wideStyle ? appState.theme.hoverLinkColor : null,
          onTap: () => appState.navigateToBlockId(context, blockId),
        ),
      ),
    );

    header.add(
      buildListTile(
        Text(l10n.previous),
        wideStyle,
        HyperLinkWidget(
          text: previousBlockId,
          style: wideStyle ? linkStyle : subtitleStyle,
          hoverForeground: wideStyle ? appState.theme.hoverLinkColor : null,
          onTap: () => appState.navigateToBlockId(context, previousBlockId),
        ),
      ),
    );

    if (nextBlockId != null) {
      header.add(
        buildListTile(
          Text(l10n.next),
          wideStyle,
          HyperLinkWidget(
            text: nextBlockId,
            style: wideStyle ? linkStyle : subtitleStyle,
            hoverForeground: wideStyle ? appState.theme.hoverLinkColor : null,
            onTap: () => appState.navigateToBlockId(context, nextBlockId),
          ),
        ),
      );
    }

    header.add(
      buildListTile(
        Text(l10n.target),
        wideStyle,
        Text(block.header.target.toJson()),
      ),
    );

    if (block.header.chainWork != null) {
      header.add(
        buildListTile(Text(l10n.chainWork), wideStyle,
            Text(block.header.chainWork.toJson())),
      );
    }

    header.add(
      buildListTile(
          Text(l10n.hashRoot), wideStyle, Text(block.header.hashRoot.toJson())),
    );

    List<Widget> footer = <Widget>[
      RaisedGradientButton(
        labelText: l10n.copy,
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
              (block.transactions.isNotEmpty ? 1 : 0) +
              block.transactions.length,
          itemBuilder: (BuildContext context, int index) {
            if (index < header.length) return header[index];
            if (index == header.length) {
              return Center(
                  child: Text(
                      l10n.numTransactions(block.header.transactionCount),
                      style: labelTextStyle));
            }
            int transactionIndex = index - header.length - 1;
            if (transactionIndex < block.transactions.length) {
              Transaction transaction = block.transactions[transactionIndex];
              return TransactionListTile(
                widget.network.currency,
                transaction,
                TransactionInfo(wideStyle: wideStyle),
                onTap: (tx) => appState.navigateToTransaction(context, tx),
                onFromTap: transaction.inputs.length != 1
                    ? null
                    : (tx) => appState.navigateToAddressText(
                        context, tx.inputs.first.fromText),
                onToTap: transaction.outputs.length != 1
                    ? null
                    : (tx) => appState.navigateToAddressText(
                        context, tx.outputs.first.toText),
              );
            } else {
              int footerIndex = transactionIndex - block.transactions.length;
              if (footerIndex < footer.length) return footer[footerIndex];
              return null;
            }
          },
        ),
      ),
      title: widget.title ?? (isTip ? l10n.tip : l10n.block) + ' ' + blockId,
    );
  }
}
