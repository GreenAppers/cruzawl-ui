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
import 'package:cruzawl/util.dart' hide VoidCallback;

import 'localization.dart';
import 'model.dart';
import 'ui.dart';

enum CruzbaseBucketDuration { minute, hour }

/// Chart of mined blocks, e.g. chart of [Transction.isCoinbase()].
class CruzbaseWidget extends StatefulWidget {
  final Currency currency;
  final Widget loadingWidget;
  final Duration windowDuration;
  final CruzbaseBucketDuration bucketDuration;
  final bool wideStyle;
  CruzbaseWidget(this.currency,
      {this.loadingWidget,
      this.wideStyle = false,
      this.windowDuration = const Duration(hours: 1),
      this.bucketDuration = CruzbaseBucketDuration.minute});

  @override
  _CruzbaseWidgetState createState() =>
      _CruzbaseWidgetState(windowDuration, bucketDuration);
}

/// [fetch] some [data] then [build] dynamic [charts.TimeSeriesChart].
class _CruzbaseWidgetState extends State<CruzbaseWidget> {
  SortedListSet<TimeSeriesBlocks> data;
  int dataStartHeight, dataEndHeight, dataMaxBucketBlocks;
  DateTime dataInit, dataStart, dataEnd, windowStart, windowEnd;
  Duration windowDuration, animate = Duration(seconds: 5);
  CruzbaseBucketDuration bucketDuration;
  bool loading = false;
  var refresh;

  _CruzbaseWidgetState(this.windowDuration, this.bucketDuration);

  /// Resets [data]. e.g. for changing [bucketDuration].
  void clear() {
    data = null;
    windowStart = windowEnd = null;
  }

  /// Chart of one hour with minute long buckets.
  void setIntervalHourly() {
    if (!loading)
      setState(() {
        windowDuration = const Duration(hours: 1);
        bucketDuration = CruzbaseBucketDuration.minute;
        clear();
      });
  }

  /// Chart of one day with hour long buckets.
  void setIntervalDaily() {
    if (!loading)
      setState(() {
        windowDuration = const Duration(days: 1);
        bucketDuration = CruzbaseBucketDuration.hour;
        clear();
      });
  }

  /// Add a new block to [data].
  void addBlockToData(BlockHeader header) {
    DateTime time = header.dateTime;
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

  /// Update [dataEnd] time, moving [windowEnd] with it if coinciding.
  void updateDataEndTime(DateTime newDataEnd) {
    if (newDataEnd.isBefore(dataEnd)) return;
    updateWindowEndTime(newDataEnd);
    dataEnd = newDataEnd;
  }

  /// Window to the right moves forward as [data] grows forwards.
  void updateWindowEndTime([DateTime newDataEnd]) {
    if (windowEnd.compareTo(dataEnd) >= 0) windowEnd = newDataEnd ?? dataEnd;
    windowStart = windowEnd.subtract(windowDuration);
  }

  /// Window to the left moves backwards as [data] grows backwards.
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
      done = !blocks.last.dateTime.isAfter(queryBackTo);
      dataStartHeight -= blocks.length;
    }

    debugPrint('load ' +
        (initialLoad ? 'initial' : 'more') +
        ' complete - initial load $dataInit');
    loading = false;
    setState(() {});
  }

  /// Retrieve [fetchBlock] blocks from [peer], starting with [height].
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

    num price = appState.exchangeRates.rateViaBTC('CRUZ', 'USD');

    /// truncateTime() makes scrolling jerky but prevents, I think,
    /// a charts bug where the bar widths wildly vary.
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
    BlockHeader first = window.isEmpty ? null : window.last.block.last;
    BlockHeader last = window.isEmpty ? null : window.first.block.first;
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
        titleWidget: buildTitle(
            context, totalBlocks, first, last, maxHeight, dataEndHeight, price),
        bottomNavigationBar: widget.wideStyle
            ? null
            : buildBottomBar(context, maxHeight, dataEndHeight, price));
  }

  Widget buildBottomBar(
      BuildContext context, int maxHeight, int tipHeight, num price) {
    final Localization locale = Localization.of(context);
    final Cruzawl appState = ScopedModel.of<Cruzawl>(context);
    final ThemeData theme = Theme.of(context);
    final TextStyle titleStyle = appState.theme.titleStyle;
    final TextStyle linkStyle = appState.theme.titleStyle
        .copyWith(decoration: TextDecoration.underline);

    List<Widget> heightEquals = buildHeightEquals(maxHeight, locale,
        titleStyle: titleStyle,
        linkStyle: linkStyle,
        onTap: () => appState.navigateToHeight(context, maxHeight));
    List<Widget> marketCap =
        buildMarketCap(tipHeight, price, locale, titleStyle: titleStyle);

    return Container(
      height: 100,
      color: Color.alphaBlend(theme.colorScheme.onSurface.withOpacity(0.80),
          theme.colorScheme.surface),
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: marketCap == null
            ? heightEquals
            : locale.listOfTwoWidgets(marketCap, heightEquals,
                style: titleStyle),
      )),
    );
  }

  Widget buildTitle(BuildContext context, int totalBlocks, BlockHeader first,
      BlockHeader last, int maxHeight, int tipHeight, num price) {
    final Localization locale = Localization.of(context);
    final Cruzawl appState = ScopedModel.of<Cruzawl>(context);
    final ThemeData theme = Theme.of(context);
    final TextStyle titleStyle = appState.theme.titleStyle;
    final TextStyle linkStyle = appState.theme.titleStyle
        .copyWith(decoration: TextDecoration.underline);

    List<Widget> hashRate =
        buildHashRate(first, last, locale, titleStyle: titleStyle);
    List<Widget> totalBlocksInLast = buildTotalBlocksInLast(totalBlocks, locale,
        titleStyle: titleStyle, linkStyle: linkStyle);
    List<Widget> heightEquals = buildHeightEquals(maxHeight, locale,
        titleStyle: titleStyle,
        linkStyle: linkStyle,
        onTap: () => appState.navigateToHeight(context, maxHeight));
    List<Widget> marketCap =
        buildMarketCap(tipHeight, price, locale, titleStyle: titleStyle);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: widget.wideStyle
          ? (marketCap != null
              ? locale.listOfFourWidgets(
                  hashRate, totalBlocksInLast, heightEquals, marketCap,
                  style: titleStyle)
              : locale.listOfThreeWidgets(
                  hashRate, totalBlocksInLast, heightEquals, style: titleStyle))
          : locale.listOfTwoWidgets(hashRate, totalBlocksInLast,
              style: titleStyle),
    );
  }

  List<Widget> buildHashRate(
      BlockHeader first, BlockHeader last, Localization locale,
      {TextStyle titleStyle}) {
    return <Widget>[
      Text(
          locale.formatHashRate(last == null
              ? 0
              : ((first.blockWork() + last.deltaWork(first)) ~/
                      BigInt.from(windowDuration.inSeconds))
                  .toInt()),
          style: titleStyle),
    ];
  }

  List<Widget> buildTotalBlocksInLast(int totalBlocks, Localization locale,
      {TextStyle titleStyle, TextStyle linkStyle}) {
    final String duration = locale.formatDuration(windowDuration);
    return buildLocalizationMarkupWidgets(
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
  }

  List<Widget> buildHeightEquals(int maxHeight, Localization locale,
          {TextStyle titleStyle, TextStyle linkStyle, VoidCallback onTap}) =>
      buildLocalizationMarkupWidgets(
        locale.heightEquals(maxHeight),
        style: titleStyle,
        tags: <String, LocalizationMarkup>{
          'a': LocalizationMarkup(
            style: linkStyle,
            onTap: onTap,
          ),
        },
      );

  List<Widget> buildMarketCap(int tipHeight, num price, Localization locale,
      {TextStyle titleStyle}) {
    int cap = (widget.currency.supply(tipHeight) * price).round();
    return cap > 0
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
  }
}

/// Element
class TimeSeriesBlocks {
  DateTime time;
  SortedListSet<BlockHeader> block = SortedListSet<BlockHeader>(
      BlockHeader.compareHeight, List<BlockHeader>());
  TimeSeriesBlocks(this.time);

  int get blocks => block.length;

  static int compareTime(dynamic a, dynamic b) => b.time.compareTo(a.time);
}

/// Converts [ui.color] to [charts.Color].
charts.Color chartColor(Color color) =>
    charts.Color(r: color.red, g: color.green, b: color.blue, a: color.alpha);

/// Rounds [time] down to nearest [duration].  e.g. 1:56 to 1:00.
DateTime truncateTime(DateTime time, CruzbaseBucketDuration duration) =>
    DateTime(time.year, time.month, time.day, time.hour,
        duration == CruzbaseBucketDuration.minute ? time.minute : 0);

/// Converts [CruzbaseBucketDuration] to [Duration].
Duration getBucketDuration(CruzbaseBucketDuration duration) {
  switch (duration) {
    case CruzbaseBucketDuration.hour:
      return const Duration(hours: 1);
    case CruzbaseBucketDuration.minute:
    default:
      return const Duration(minutes: 1);
  }
}
