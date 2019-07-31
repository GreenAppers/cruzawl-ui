// Copyright 2019 cruzawl developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

import 'package:flutter_web/material.dart'
    if (dart.library.io) 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:scoped_model/scoped_model.dart';

import 'package:cruzawl/currency.dart';
import 'package:cruzawl/network.dart';

import 'localization.dart';
import 'model.dart';
import 'ui.dart';

class CruzbaseWidget extends StatefulWidget {
  final Currency currency;
  final BlockHeader tip;
  final Widget loadingWidget;
  final Duration totalDuration, bucketDuration;
  CruzbaseWidget(this.currency, this.tip,
      {this.loadingWidget,
      this.totalDuration = const Duration(hours: 1),
      this.bucketDuration = const Duration(minutes: 1)});

  @override
  _CruzbaseWidgetState createState() =>
      _CruzbaseWidgetState(totalDuration, bucketDuration);
}

class _CruzbaseWidgetState extends State<CruzbaseWidget> {
  Duration totalDuration, bucketDuration;
  List<charts.Series<TimeSeriesBlocks, DateTime>> series;
  int totalBlocks;
  bool loading = false;
  BlockHeader last;
  _CruzbaseWidgetState(this.totalDuration, this.bucketDuration);

  void setIntervalHourly() {
    if (!loading)
      setState(() {
        totalDuration = const Duration(hours: 1);
        bucketDuration = const Duration(minutes: 1);
        series = null;
      });
  }

  void setIntervalDaily() {
    if (!loading)
      setState(() {
        totalDuration = const Duration(days: 1);
        bucketDuration = const Duration(hours: 1);
        series = null;
      });
  }

  void load(Color color) async {
    if (loading || !widget.currency.network.hasPeer) return;
    loading = true;
    totalBlocks = 0;

    final DateTime now = DateTime.now(), end = now.subtract(totalDuration);
    final List<TimeSeriesBlocks> data = List<TimeSeriesBlocks>();
    {
      final int len = divideDuration(totalDuration, bucketDuration) + 1;
      DateTime next = now;
      for (int i = 0; i < len; i++) {
        next = next.subtract(bucketDuration);
        data.add(TimeSeriesBlocks(next));
      }
    }

    last = null;
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

        Duration offset = now.difference(blockTime(header));
        int bucket = divideDuration(offset, bucketDuration);
        if (bucket >= 0 && bucket < data.length) {
          data[bucket].block.add(header);
          totalBlocks++;
          last = header;
        }
      }
    }

    series = [
      charts.Series<TimeSeriesBlocks, DateTime>(
        id: 'blocks',
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
    final Localization locale = Localization.of(context);
    final Cruzawl appState = ScopedModel.of<Cruzawl>(context);
    final ThemeData theme = Theme.of(context);

    if (series == null) {
      load(theme.accentColor);
      return widget.loadingWidget ??
          SimpleScaffold(Center(child: CircularProgressIndicator()),
              title: locale.loading);
    }

    return SimpleScaffold(
        charts.TimeSeriesChart(
          series,
          animate: false,
          defaultRenderer: charts.BarRendererConfig<DateTime>(),
          defaultInteractions: false,
          behaviors: [charts.SelectNearest(), charts.DomainHighlighter()],
          selectionModels: [
            charts.SelectionModelConfig(
              type: charts.SelectionModelType.info,
              changedListener: (charts.SelectionModel model) {
                for (charts.SeriesDatum datum in model.selectedDatum)
                  if (datum.datum.blocks > 0) {
                    appState.navigateToHeight(
                        context, datum.datum.block[0].height);
                    break;
                  }
              },
            ),
          ],
        ),
        titleWidget: buildTitle(context));
  }

  Widget buildTitle(BuildContext context) {
    final Localization locale = Localization.of(context);
    final Cruzawl appState = ScopedModel.of<Cruzawl>(context);
    final ThemeData theme = Theme.of(context);
    final TextStyle titleStyle = appState.theme.titleStyle
        .copyWith(fontSize: 20, color: theme.primaryTextTheme.title.color);
    final TextStyle linkStyle = appState.theme.titleStyle.copyWith(
        fontSize: 20,
        color: theme.primaryTextTheme.title.color,
        decoration: TextDecoration.underline);
    final String duration = locale.formatDuration(totalDuration);

    List<Widget> hashRate = <Widget>[
      Text(locale.formatHashRate(last == null ? 0 : widget.tip.hashRate(last)),
          style: titleStyle),
    ];

    List<Widget> totalBlocksInLast = buildLocalizationMarkupWidgets(
      locale.totalBlocksInLastDuration(totalBlocks, duration),
      style: titleStyle,
      tags: <String, LocalizationMarkup>{
        'a1': LocalizationMarkup(
          style: linkStyle,
          onTap: () => Navigator.of(context).pushNamed('/tip'),
        ),
        'a2': LocalizationMarkup(
          widget: <Widget>[
            (PopupMenuBuilder()
                  ..addItem(
                      text: locale.formatDuration(Duration(days: 1)),
                      onSelected: setIntervalDaily)
                  ..addItem(
                      text: locale.formatDuration(Duration(hours: 1)),
                      onSelected: setIntervalHourly))
                .build(
                    child: Text('$duration', style: linkStyle), padding: null),
          ],
        ),
      },
    );

    List<Widget> heightEquals = buildLocalizationMarkupWidgets(
      locale.heightEquals(widget.tip.height),
      style: titleStyle,
      tags: <String, LocalizationMarkup>{
        'a': LocalizationMarkup(
          style: linkStyle,
          onTap: () => appState.navigateToHeight(context, widget.tip.height),
        ),
      },
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: locale.listOfThreeWidgets(
          hashRate, totalBlocksInLast, heightEquals,
          style: titleStyle),
    );
  }
}

class TimeSeriesBlocks {
  DateTime time;
  List<BlockHeader> block = List<BlockHeader>();
  TimeSeriesBlocks(this.time);

  int get blocks => block.length;
}

charts.Color chartColor(Color color) =>
    charts.Color(r: color.red, g: color.green, b: color.blue, a: color.alpha);

int divideDuration(Duration q, Duration d) =>
    (q.inMicroseconds / d.inMicroseconds).ceil();

DateTime blockTime(BlockHeader header) =>
    DateTime.fromMillisecondsSinceEpoch(header.time * 1000);
