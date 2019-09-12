// Copyright 2019 cruzawl developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tuple/tuple.dart';

import 'package:cruzawl/currency.dart';
import 'package:cruzawl/network.dart';
import 'package:cruzawl/util.dart' hide VoidCallback;

import '../localization.dart';
import '../model.dart';
import '../ui.dart';

enum CruzbaseBucketDuration { minute, hour }

/// Chart of mined blocks, e.g. chart of [Transction.isCoinbase()].
class CruzbaseWidget extends StatefulWidget {
  final PeerNetwork network;
  final Widget loadingWidget;
  final Duration windowDuration, animate = Duration(seconds: 5);
  final CruzbaseBucketDuration bucketDuration;
  final bool wideStyle;
  final int fetchBlock;

  CruzbaseWidget(this.network,
      {this.loadingWidget,
      this.wideStyle = false,
      this.windowDuration = const Duration(hours: 1),
      this.bucketDuration = CruzbaseBucketDuration.minute,
      this.fetchBlock = 50});

  @override
  _CruzbaseWidgetState createState() =>
      _CruzbaseWidgetState(windowDuration, bucketDuration);
}

/// [fetch] some [data] then [build] dynamic [charts.TimeSeriesChart].
class _CruzbaseWidgetState extends State<CruzbaseWidget> {
  SortedListSet<TimeSeriesBlocks> data;
  int dataStartHeight, dataEndHeight, dataMaxBucketBlocks;
  DateTime dataInit, dataStart, dataEnd, windowStart, windowEnd;
  Duration windowDuration;
  CruzbaseBucketDuration bucketDuration;
  bool loading = false;
  Timer refresh;

  _CruzbaseWidgetState(this.windowDuration, this.bucketDuration);

  @override
  void dispose() {
    if (refresh != null) refresh.cancel();
    super.dispose();
  }

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
      prevPoint.transactions += header.transactionCount;
      dataMaxBucketBlocks = max(dataMaxBucketBlocks, prevPoint.blocks);
    } else {
      point.block.add(header);
      point.transactions += header.transactionCount;
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

  void load(Cruzawl appState) async {
    if (loading || !widget.network.hasPeer) return;
    Peer peer = await widget.network.getPeer();
    loading = true;
    DateTime queryBackTo;
    bool initialLoad = data == null;

    if (initialLoad) {
      debugPrint('cruzbase initial load');
      appState.setLocalCurrency();
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
      List<BlockHeader> blocks =
          await fetch(peer, dataStartHeight, widget.fetchBlock);
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
    final Localization l10n = Localization.of(context);
    final Cruzawl appState = ScopedModel.of<Cruzawl>(context);
    final ThemeData theme = Theme.of(context);

    bool loading = data == null || data.isEmpty;
    load(appState);
    appState.exchangeRates.checkForUpdate();

    if (loading)
      return widget.loadingWidget ??
          SimpleScaffold(Center(child: CircularProgressIndicator()),
              title: l10n.loading);

    if (refresh == null) {
      refresh = Timer.periodic(widget.animate, (Timer t) {
        if (mounted) setState(() {});
      });
    }

    num price = appState.exchangeRates
        .rateViaBTC('CRUZ', appState.preferences.localCurrency);

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
    Tuple3<int, int, int> visitor = window.data.fold(
        Tuple3<int, int, int>(0, 0, 0),
        (p, c) => Tuple3<int, int, int>(p.item1 + c.blocks,
            p.item2 + c.transactions, max(p.item3, c.block.first.height)));
    int totalBlocks = visitor.item1,
        totalTransactions = visitor.item2,
        maxHeight = visitor.item3;
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
        titleWidget: buildTitle(context, totalBlocks, totalTransactions, first,
            last, maxHeight, dataEndHeight, price),
        bottomNavigationBar: widget.wideStyle
            ? null
            : buildBottomBar(context, totalBlocks, totalTransactions, maxHeight,
                dataEndHeight, price));
  }

  Widget buildBottomBar(BuildContext context, int totalBlocks,
      int totalTransactions, int maxHeight, int tipHeight, num price) {
    final Localization l10n = Localization.of(context);
    final Cruzawl appState = ScopedModel.of<Cruzawl>(context);
    final ThemeData theme = Theme.of(context);
    final TextStyle titleStyle = appState.theme.titleStyle;
    final TextStyle linkStyle = appState.theme.titleStyle
        .copyWith(decoration: TextDecoration.underline);

    List<Widget> totalBlocksInLast = buildTotalBlocksInLast(
        totalBlocks, totalTransactions, l10n,
        titleStyle: titleStyle, linkStyle: linkStyle);
    List<Widget> heightEquals = buildHeightEquals(maxHeight, l10n,
        titleStyle: titleStyle,
        linkStyle: linkStyle,
        onTap: () => appState.navigateToHeight(context, maxHeight));
    List<Widget> marketCap = buildMarketCap(
        tipHeight, price, appState.preferences.localCurrency, l10n,
        titleStyle: titleStyle, onTap: () => appState.launchMarketUrl(context));

    return Container(
      height: 100,
      color: Color.alphaBlend(theme.colorScheme.onSurface.withOpacity(0.80),
          theme.colorScheme.surface),
      child: Center(
          child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: totalBlocksInLast),
          Row(
              key: marketCap == null ? null : Key('marketCap'),
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: marketCap == null
                  ? heightEquals
                  : l10n.listOfTwoWidgets(heightEquals, marketCap,
                      style: titleStyle)),
        ],
      )),
    );
  }

  Widget buildTitle(
      BuildContext context,
      int totalBlocks,
      int totalTransactions,
      BlockHeader first,
      BlockHeader last,
      int maxHeight,
      int tipHeight,
      num price) {
    final Localization l10n = Localization.of(context);
    final Cruzawl appState = ScopedModel.of<Cruzawl>(context);
    final ThemeData theme = Theme.of(context);
    final TextStyle titleStyle = appState.theme.titleStyle;
    final TextStyle linkStyle = appState.theme.titleStyle
        .copyWith(decoration: TextDecoration.underline);

    List<Widget> hashRate =
        buildHashRate(first, last, l10n, titleStyle: titleStyle);
    List<Widget> totalBlocksInLast = buildTotalBlocksInLast(
        totalBlocks, totalTransactions, l10n,
        titleStyle: titleStyle, linkStyle: linkStyle);
    List<Widget> heightEquals = buildHeightEquals(maxHeight, l10n,
        titleStyle: titleStyle,
        linkStyle: linkStyle,
        onTap: () => appState.navigateToHeight(context, maxHeight));
    List<Widget> marketCap = buildMarketCap(
        tipHeight, price, appState.preferences.localCurrency, l10n,
        titleStyle: titleStyle, onTap: () => appState.launchMarketUrl(context));

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: widget.wideStyle
          ? (marketCap != null
              ? l10n.listOfFourWidgets(
                  hashRate, totalBlocksInLast, heightEquals, marketCap,
                  style: titleStyle)
              : l10n.listOfThreeWidgets(
                  hashRate, totalBlocksInLast, heightEquals,
                  style: titleStyle))
          : hashRate,
    );
  }

  List<Widget> buildHashRate(
      BlockHeader first, BlockHeader last, Localization l10n,
      {TextStyle titleStyle}) {
    return <Widget>[
      Text(
          l10n.formatHashRate(last == null
              ? 0
              : ((first.blockWork() + last.deltaWork(first)) ~/
                      BigInt.from(windowDuration.inSeconds))
                  .toInt()),
          style: titleStyle),
    ];
  }

  List<Widget> buildTotalBlocksInLast(
      int totalBlocks, int totalTransactions, Localization l10n,
      {TextStyle titleStyle, TextStyle linkStyle}) {
    final String duration = l10n.formatDuration(windowDuration);
    return buildLocalizationMarkupWidgets(
      l10n.totalBlocksTransactionsInLastDuration(
          totalBlocks, totalTransactions, duration),
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
                      text: l10n.formatDuration(Duration(days: 1)),
                      onSelected: setIntervalDaily)
                  ..addItem(
                      text: l10n.formatDuration(Duration(hours: 1)),
                      onSelected: setIntervalHourly))
                .build(
                    child: Text('$duration', style: linkStyle), padding: null),
          ],
        ),
      },
    );
  }

  List<Widget> buildHeightEquals(int maxHeight, Localization l10n,
          {TextStyle titleStyle, TextStyle linkStyle, VoidCallback onTap}) =>
      buildLocalizationMarkupWidgets(
        l10n.heightEquals(maxHeight),
        style: titleStyle,
        tags: <String, LocalizationMarkup>{
          'a': LocalizationMarkup(
            style: linkStyle,
            onTap: onTap,
          ),
        },
      );

  List<Widget> buildMarketCap(
      int tipHeight, num price, String currency, Localization l10n,
      {TextStyle titleStyle, VoidCallback onTap}) {
    int cap = (widget.network.currency.supply(tipHeight) * price).round();
    return cap > 0
        ? buildLocalizationMarkupWidgets(
            l10n.marketCap(
                NumberFormat.compactSimpleCurrency(name: currency).format(cap)),
            style: titleStyle,
            tags: <String, LocalizationMarkup>{
              'a': LocalizationMarkup(
                style: titleStyle,
                onTap: onTap,
              ),
            },
          )
        : null;
  }
}

/// Element
class TimeSeriesBlocks {
  DateTime time;
  int transactions = 0;
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
