// Copyright 2019 cruzbit developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

import 'package:flutter_web/material.dart'
    if (dart.library.io) 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;

import 'package:cruzawl/currency.dart';
import 'package:cruzawl/network.dart';

import 'ui.dart';

class CruzbaseWidget extends StatefulWidget {
  final Currency currency;
  final BlockHeader tip;
  final Widget loadingWidget;
  final Duration totalDuration, bucketDuration;
  CruzbaseWidget(this.currency, this.tip,
      {this.loadingWidget,
      this.totalDuration = const Duration(days: 1),
      this.bucketDuration = const Duration(hours: 1)});

  @override
  _CruzbaseWidgetState createState() => _CruzbaseWidgetState();
}

class _CruzbaseWidgetState extends State<CruzbaseWidget> {
  List<charts.Series<TimeSeriesBlocks, DateTime>> series;
  int totalBlocks;
  bool loading = false;

  void load(Color color) async {
    if (loading || !widget.currency.network.hasPeer) return;
    loading = true;
    totalBlocks = 0;

    final DateTime now = DateTime.now(),
        end = now.subtract(widget.totalDuration);
    final List<TimeSeriesBlocks> data = List<TimeSeriesBlocks>();
    {
      final int len =
          divideDuration(widget.totalDuration, widget.bucketDuration) + 1;
      DateTime next = now;
      for (int i = 0; i < len; i++) {
        next = next.subtract(widget.bucketDuration);
        data.add(TimeSeriesBlocks(next, 0));
      }
    }

    Peer peer = await widget.currency.network.getPeer();
    int fetchBlock = 50, height = widget.tip.height;
    List<Future<BlockHeaderMessage>> blocks =
        List<Future<BlockHeaderMessage>>(fetchBlock);

    for (bool done = false; !done && height >= 0; /**/) {
      int count = 0;
      for (/**/; count < fetchBlock && height >= 0; count++)
        blocks[count] = peer.getBlockHeader(height: height--);

      for (int i = 0; i < count; i++) {
        BlockHeaderMessage message = await blocks[i];
        if (message == null) {
          loading = false;
          return;
        }
        BlockHeader header = message.header;
        if ((done = !blockTime(header).isAfter(end))) break;

        totalBlocks++;
        Duration offset = now.difference(blockTime(header));
        int bucket = divideDuration(offset, widget.bucketDuration);
        assert(bucket < data.length, 'failed $bucket < ${data.length}');
        data[bucket].blocks++;
      }
    }

    series = [
      charts.Series<TimeSeriesBlocks, DateTime>(
        id: 'Blocks',
        colorFn: (_, __) => chartColor(color),
        domainFn: (TimeSeriesBlocks blocks, _) => blocks.time,
        measureFn: (TimeSeriesBlocks blocks, _) => blocks.blocks,
        data: data,
      )
    ];

    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    if (series == null) {
      load(theme.accentColor);
      return widget.loadingWidget ??
          SimpleScaffold(
              "Loading...", Center(child: CircularProgressIndicator()));
    }

    return SimpleScaffold(
        '$totalBlocks blocks in last ${widget.totalDuration.toString()}',
        charts.TimeSeriesChart(
          series,
          animate: false,
          defaultRenderer: charts.BarRendererConfig<DateTime>(),
          defaultInteractions: false,
          behaviors: [charts.SelectNearest(), charts.DomainHighlighter()],
        ));
  }
}

class TimeSeriesBlocks {
  DateTime time;
  int blocks;
  TimeSeriesBlocks(this.time, this.blocks);
}

charts.Color chartColor(Color color) =>
    charts.Color(r: color.red, g: color.green, b: color.blue, a: color.alpha);

int divideDuration(Duration q, Duration d) =>
    (q.inMicroseconds / d.inMicroseconds).ceil();

DateTime blockTime(BlockHeader header) =>
    DateTime.fromMillisecondsSinceEpoch(header.time * 1000);
