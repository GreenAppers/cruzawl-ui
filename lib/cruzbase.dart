// Copyright 2019 cruzawl developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

import 'dart:math';

import 'package:flutter_web/material.dart'
    if (dart.library.io) 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:collection/collection.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:cruzawl/currency.dart';
import 'package:cruzawl/network.dart';
import 'package:cruzawl/util.dart';

import 'localization.dart';
import 'model.dart';
import 'ui.dart';

enum CruzbaseBucketDuration { minute, hour }

class CruzbaseWidget extends StatefulWidget {
  final Currency currency;
  final Widget loadingWidget;
  final Duration windowDuration;
  final CruzbaseBucketDuration bucketDuration;
  CruzbaseWidget(this.currency,
      {this.loadingWidget,
      this.windowDuration = const Duration(hours: 1),
      this.bucketDuration = CruzbaseBucketDuration.minute});

  @override
  _CruzbaseWidgetState createState() =>
      _CruzbaseWidgetState(windowDuration, bucketDuration);
}

class _CruzbaseWidgetState extends State<CruzbaseWidget> {
  SortedListSet<TimeSeriesBlocks> data;
  int dataStartHeight, dataEndHeight, dataMaxBucketBlocks;
  DateTime dataInit, dataStart, dataEnd, windowStart, windowEnd;
  Duration windowDuration, animate = Duration(seconds: 5);
  CruzbaseBucketDuration bucketDuration;
  bool loading = false;
  var refresh;

  _CruzbaseWidgetState(this.windowDuration, this.bucketDuration);

  void clear() {
    data = null;
    windowStart = windowEnd = null;
  }

  void setIntervalHourly() {
    if (!loading)
      setState(() {
        windowDuration = const Duration(hours: 1);
        bucketDuration = CruzbaseBucketDuration.minute;
        clear();
      });
  }

  void setIntervalDaily() {
    if (!loading)
      setState(() {
        windowDuration = const Duration(days: 1);
        bucketDuration = CruzbaseBucketDuration.hour;
        clear();
      });
  }

  void addBlockToData(BlockHeader header) {
    DateTime time = blockTime(header);
    if (time.isBefore(dataStart)) dataStart = time;
    if (time.isAfter(dataEnd)) updateDataEndTime(time);
    TimeSeriesBlocks point =
        TimeSeriesBlocks(truncateTime(time, bucketDuration));
    TimeSeriesBlocks prevPoint = data.find(point);
    if (prevPoint != null) {
      prevPoint.block.add(header);
      dataMaxBucketBlocks = max(dataMaxBucketBlocks, prevPoint.blocks);
    } else {
      point.block.add(header);
      data.add(point);
      dataMaxBucketBlocks = max(dataMaxBucketBlocks, point.blocks);
    }
  }

  void updateDataEndTime(DateTime newDataEnd) {
    if (newDataEnd.isBefore(dataEnd)) return;
    updateWindowEndTime(newDataEnd);
    dataEnd = newDataEnd;
  }

  void updateWindowEndTime([DateTime newDataEnd]) {
    if (windowEnd.compareTo(dataEnd) >= 0) windowEnd = newDataEnd ?? dataEnd;
    windowStart = windowEnd.subtract(windowDuration);
  }

  void updateWindowStartTime([DateTime newDataStart]) {
    if (windowStart.compareTo(dataStart) <= 0)
      windowStart = newDataStart ?? dataStart;
    windowEnd = windowStart.add(windowDuration);
  }

  void load() async {
    if (loading || !widget.currency.network.hasPeer) return;
    Peer peer = await widget.currency.network.getPeer();
    loading = true;
    DateTime queryBackTo;
    bool initialLoad = data == null;

    if (initialLoad) {
      debugPrint('cruzbase initial load');
      dataMaxBucketBlocks = 0;
      dataInit = dataStart = dataEnd = DateTime.now();
      dataStartHeight = dataEndHeight = peer.tip.height;
      data = SortedListSet<TimeSeriesBlocks>(
          TimeSeriesBlocks.compareTime, List<TimeSeriesBlocks>());
      queryBackTo = dataEnd.subtract(windowDuration);
      windowStart ??= queryBackTo;
      windowEnd ??= dataEnd;
    } else {
      Duration bufferDuration = const Duration(hours: 4);
      updateDataEndTime(DateTime.now());
      int tipHeight = peer.tip.height;
      if (tipHeight > dataEndHeight) {
        await fetch(peer, tipHeight, tipHeight - dataEndHeight);
        dataEndHeight = tipHeight;
        if (dataStart.compareTo(windowStart.subtract(bufferDuration)) < 0) {
          loading = false;
          setState(() {});
          return;
        }
      } else {
        if (dataStart.compareTo(windowStart.subtract(bufferDuration)) < 0) {
          loading = false;
          return;
        }
      }
      debugPrint('cruzbase load more');
      queryBackTo = dataEnd.subtract(bufferDuration);
    }

    for (bool done = false; !done && dataStartHeight >= 0; /**/) {
      List<BlockHeader> blocks = await fetch(peer, dataStartHeight, 50);
      if (blocks == null || blocks.isEmpty) return;
      done = !blockTime(blocks.last).isAfter(queryBackTo);
      dataStartHeight -= blocks.length;
    }

    debugPrint('load ' +
        (initialLoad ? 'initial' : 'more') +
        ' complete - initial load $dataInit');
    loading = false;
    setState(() {});
  }

  Future<List<BlockHeader>> fetch(Peer peer, int height, int fetchBlock) async {
    int count = 0;
    List<Future<BlockHeaderMessage>> blocks =
        List<Future<BlockHeaderMessage>>(fetchBlock);
    for (/**/; count < fetchBlock && height >= 0; count++)
      blocks[count] = peer.getBlockHeader(height: height--);

    List<BlockHeader> ret = List<BlockHeader>(count);
    for (int i = 0; i < count; i++) {
      BlockHeaderMessage message = await blocks[i];
      if (message == null) return null;
      addBlockToData(message.header);
      ret[i] = message.header;
    }
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    final Localization locale = Localization.of(context);
    final Cruzawl appState = ScopedModel.of<Cruzawl>(context);
    final ThemeData theme = Theme.of(context);

    bool loading = data == null || data.isEmpty;
    load();
    appState.exchangeRates.checkForUpdate();

    if (loading)
      return widget.loadingWidget ??
          SimpleScaffold(Center(child: CircularProgressIndicator()),
              title: locale.loading);

    if (refresh == null)
      refresh = Future.delayed(animate, () {
        if (mounted) setState(() => refresh = null);
      });

    /// truncateTime() makes scrolling jerky but prevents, I think, a charts bug
    TimeSeriesBlocks start =
        TimeSeriesBlocks(truncateTime(windowStart, bucketDuration));
    TimeSeriesBlocks end =
        TimeSeriesBlocks(truncateTime(windowEnd, bucketDuration));

    int endIndex =
        lowerBound(data.data, start, compare: TimeSeriesBlocks.compareTime);
    int startIndex =
        lowerBound(data.data, end, compare: TimeSeriesBlocks.compareTime);
    SortedListSet<TimeSeriesBlocks> window = SortedListSet<TimeSeriesBlocks>(
        TimeSeriesBlocks.compareTime, data.data.sublist(startIndex, endIndex));
    Point<num> visitor = window.data.fold(Point<num>(0, 0),
        (p, c) => Point<num>(p.x + c.blocks, max(p.y, c.block.first.height)));
    int totalBlocks = visitor.x, maxHeight = visitor.y;
    Duration barDuration = getBucketDuration(bucketDuration);
    BlockHeader first = window.last.block.last;
    BlockHeader last = window.first.block.first;
    window.add(start, overwrite: false);
    window.add(end, overwrite: false);

    return SimpleScaffold(
        GestureDetector(
          child: charts.TimeSeriesChart(
            [
              charts.Series<TimeSeriesBlocks, DateTime>(
                id: 'blocks',
                colorFn: (_, __) => chartColor(theme.accentColor),
                domainFn: (TimeSeriesBlocks blocks, _) => blocks.time,
                measureFn: (TimeSeriesBlocks blocks, _) => blocks.blocks,
                data: window.data,
              )
            ],
            animate: false,
            defaultRenderer: charts.BarRendererConfig<DateTime>(),
            defaultInteractions: false,
            behaviors: [
              charts.SelectNearest(),
            ],
            selectionModels: [
              charts.SelectionModelConfig(
                type: charts.SelectionModelType.info,
                changedListener: (charts.SelectionModel model) {
                  for (charts.SeriesDatum datum in model.selectedDatum)
                    if (datum.datum.blocks > 0) {
                      appState.navigateToHeight(
                          context, datum.datum.block.first.height);
                      break;
                    }
                },
              ),
            ],
            primaryMeasureAxis: charts.NumericAxisSpec(
                viewport: charts.NumericExtents(0, dataMaxBucketBlocks)),
            /*domainAxis: charts.EndPointsTimeAxisSpec(
                viewport:
                    charts.DateTimeExtents(start: windowStart, end: windowEnd)),*/
          ),
          onHorizontalDragUpdate: (update) {
            double dx = -update.delta.dx, factor = .1;
            windowEnd = dx >= 0
                ? windowEnd.add(barDuration * dx.abs() * factor)
                : windowEnd.subtract(barDuration * dx.abs() * factor);
            setState(() {
              updateWindowEndTime();
              updateWindowStartTime();
            });
          },
        ),
        titleWidget: buildTitle(context, totalBlocks, first, last, maxHeight,
            dataEndHeight, appState.exchangeRates.rateViaBTC('CRUZ', 'USD')));
  }

  Widget buildTitle(BuildContext context, int totalBlocks, BlockHeader first,
      BlockHeader last, int maxHeight, int tipHeight, num price) {
    final Localization locale = Localization.of(context);
    final Cruzawl appState = ScopedModel.of<Cruzawl>(context);
    final ThemeData theme = Theme.of(context);
    final TextStyle titleStyle = appState.theme.titleStyle
        .copyWith(fontSize: 20, color: theme.primaryTextTheme.title.color);
    final TextStyle linkStyle = appState.theme.titleStyle.copyWith(
        fontSize: 20,
        color: theme.primaryTextTheme.title.color,
        decoration: TextDecoration.underline);
    final String duration = locale.formatDuration(windowDuration);

    List<Widget> hashRate = <Widget>[
      Text(
          locale.formatHashRate(last == null
              ? 0
              : ((first.blockWork() + last.deltaWork(first)) ~/
                      BigInt.from(windowDuration.inSeconds))
                  .toInt()),
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
      locale.heightEquals(maxHeight),
      style: titleStyle,
      tags: <String, LocalizationMarkup>{
        'a': LocalizationMarkup(
          style: linkStyle,
          onTap: () => appState.navigateToHeight(context, maxHeight),
        ),
      },
    );

    int cap = (widget.currency.supply(tipHeight) * price).round();
    List<Widget> marketCap = cap > 0
        ? buildLocalizationMarkupWidgets(
            locale.marketCap('\$' + locale.formatQuantity(cap)),
            style: titleStyle,
            tags: <String, LocalizationMarkup>{
              'a': LocalizationMarkup(
                style: titleStyle,
              ),
            },
          )
        : null;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: marketCap != null
          ? locale.listOfFourWidgets(
              hashRate, totalBlocksInLast, heightEquals, marketCap,
              style: titleStyle)
          : locale.listOfThreeWidgets(hashRate, totalBlocksInLast, heightEquals,
              style: titleStyle),
    );
  }
}

class TimeSeriesBlocks {
  DateTime time;
  SortedListSet<BlockHeader> block = SortedListSet<BlockHeader>(
      BlockHeader.compareHeight, List<BlockHeader>());
  TimeSeriesBlocks(this.time);

  int get blocks => block.length;

  static int compareTime(dynamic a, dynamic b) => b.time.compareTo(a.time);
}

charts.Color chartColor(Color color) =>
    charts.Color(r: color.red, g: color.green, b: color.blue, a: color.alpha);

DateTime blockTime(BlockHeader header) =>
    DateTime.fromMillisecondsSinceEpoch(header.time * 1000);

DateTime truncateTime(DateTime time, CruzbaseBucketDuration duration) =>
    DateTime(time.year, time.month, time.day, time.hour,
        duration == CruzbaseBucketDuration.minute ? time.minute : 0);

Duration getBucketDuration(CruzbaseBucketDuration duration) {
  switch (duration) {
    case CruzbaseBucketDuration.hour:
      return Duration(hours: 1);
    case CruzbaseBucketDuration.minute:
    default:
      return Duration(minutes: 1);
  }
}
