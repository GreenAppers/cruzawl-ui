// Copyright 2019 cruzawl developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

/// [Block] time series explorer
library explorer_block_chart;

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tuple/tuple.dart';

import 'package:cruzawl/currency.dart';
import 'package:cruzawl/currency/btc.dart';
import 'package:cruzawl/currency/eth.dart';
import 'package:cruzawl/network.dart';
import 'package:cruzawl/util.dart' hide VoidCallback;

import 'package:cruzawl_ui/localization.dart';
import 'package:cruzawl_ui/model.dart';
import 'package:cruzawl_ui/ui.dart';

enum BlockChartBucketDuration { minute, hour }

/// Chart of mined blocks, e.g. chart of [Transction.isCoinbase()].
class BlockChartWidget extends StatefulWidget {
  /// The [PeerNetwork] to retrieve [BlockHeader]s from.
  final PeerNetwork network;

  /// Displayed while fetching data.
  final Widget loadingWidget;

  /// The whole chart interval.
  final Duration windowDuration;

  /// Enables timer to shift the time series left.
  final Duration animate = Duration(seconds: 5);

  /// The bar interval.
  final BlockChartBucketDuration bucketDuration;

  /// Layout for desktop (as opposed to mobile).
  final bool wideStyle;

  /// Pipeline this number of [BlockHeader] fetches.
  final int fetchBlock;

  BlockChartWidget(this.network,
      {this.loadingWidget,
      this.wideStyle = false,
      Duration windowDuration,
      BlockChartBucketDuration bucketDuration,
      this.fetchBlock = 50})
      : this.windowDuration = windowDuration ??
            (network.currency is ETH
                ? Duration(minutes: 10)
                : Duration(days: 1)),
        this.bucketDuration = bucketDuration ??
            (network.currency is ETH
                ? BlockChartBucketDuration.minute
                : BlockChartBucketDuration.hour);

  @override
  _BlockChartWidgetState createState() =>
      _BlockChartWidgetState(windowDuration, bucketDuration);
}

/// [fetch] some [data] then [build] dynamic [charts.TimeSeriesChart].
class _BlockChartWidgetState extends State<BlockChartWidget> {
  SortedListSet<TimeSeriesBlocks> data;
  int dataStartHeight, dataEndHeight, dataMaxBucketBlocks, hashRateOverride;
  DateTime dataInit, dataStart, dataEnd, windowStart, windowEnd;
  Duration windowDuration;
  BlockChartBucketDuration bucketDuration;
  bool loading = false;
  Timer refresh;

  _BlockChartWidgetState(this.windowDuration, this.bucketDuration);

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
    if (!loading) {
      setState(() {
        windowDuration = const Duration(hours: 1);
        bucketDuration = BlockChartBucketDuration.minute;
        clear();
      });
    }
  }

  /// Chart of one day with hour long buckets.
  void setIntervalDaily() {
    if (!loading) {
      setState(() {
        windowDuration = const Duration(days: 1);
        bucketDuration = BlockChartBucketDuration.hour;
        clear();
      });
    }
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
      if (prevPoint.block.add(header, overwrite: false)) {
        prevPoint.transactions += header.transactionCount ?? 0;
        dataMaxBucketBlocks = max(dataMaxBucketBlocks, prevPoint.blocks);
      }
    } else {
      if (point.block.add(header, overwrite: false)) {
        point.transactions += header.transactionCount ?? 0;
        data.add(point);
        dataMaxBucketBlocks = max(dataMaxBucketBlocks, point.blocks);
      }
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
    if (windowStart.compareTo(dataStart) <= 0) {
      windowStart = newDataStart ?? dataStart;
    }
    windowEnd = windowStart.add(windowDuration);
  }

  void load(Cruzawl appState) async {
    if (loading || !widget.network.hasPeer) return;
    Peer peer = await widget.network.getPeer();
    loading = true;
    DateTime queryBackTo;
    bool initialLoad = data == null;

    if (initialLoad) {
      debugPrint('block chart initial load');
      appState.setLocalCurrency();
      dataMaxBucketBlocks = 0;
      dataInit = dataStart = dataEnd = DateTime.now();
      dataStartHeight = dataEndHeight = peer.tipHeight;
      data = SortedListSet<TimeSeriesBlocks>(
          TimeSeriesBlocks.compareTime, List<TimeSeriesBlocks>());
      queryBackTo = dataEnd.subtract(windowDuration);
      windowStart ??= queryBackTo;
      windowEnd ??= dataEnd;
    } else {
      Duration bufferDuration = windowDuration ~/ 6;
      updateDataEndTime(DateTime.now());
      int tipHeight = peer.tipHeight;
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
      debugPrint('block chart load more');
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
        ' complete - initial load $dataInit: start=$dataStart end=$dataEnd');
    loading = false;
    setState(() {});
  }

  /// Retrieve [fetchBlock] blocks from [peer], starting with [height].
  Future<List<BlockHeader>> fetch(Peer peer, int height, int fetchBlock) async {
    if (peer is BlockchainAPI) {
      BlockchainAPI blockchain = peer;
      if (data.isEmpty) hashRateOverride = await blockchain.getHashRate();
      List<BlockHeader> ret = await blockchain.getBlockHeaders(
          data.isEmpty ? dataStart : dataStart.subtract(Duration(hours: 24)));
      for (BlockHeader block in ret) {
        addBlockToData(block);
      }
      return ret;
    } else {
      int count = 0;
      List<Future<BlockHeaderMessage>> blocks =
          List<Future<BlockHeaderMessage>>(fetchBlock);
      for (/**/; count < fetchBlock && height >= 0; count++) {
        blocks[count] = peer.getBlockHeader(height: height--);
      }

      List<BlockHeader> ret = List<BlockHeader>(count);
      for (int i = 0; i < count; i++) {
        BlockHeaderMessage message = await blocks[i];
        if (message == null) return null;
        addBlockToData(message.header);
        ret[i] = message.header;
      }
      return ret;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Localization l10n = Localization.of(context);
    final Cruzawl appState = ScopedModel.of<Cruzawl>(context);
    final ThemeData theme = Theme.of(context);

    bool loading = data == null || data.isEmpty;
    load(appState);
    appState.exchangeRates.checkForUpdate();

    if (loading) {
      return widget.loadingWidget ??
          SimpleScaffold(Center(child: CircularProgressIndicator()),
              title: l10n.loading);
    }

    if (refresh == null) {
      refresh = Timer.periodic(widget.animate, (Timer t) {
        if (mounted) setState(() {});
      });
    }

    num price = appState.exchangeRates.rateViaBTC(
        widget.network.currency.ticker, appState.preferences.localCurrency);

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
                  for (charts.SeriesDatum datum in model.selectedDatum) {
                    if (datum.datum.blocks > 0) {
                      appState.navigateToHeight(
                          context, datum.datum.block.first.height);
                      break;
                    }
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
    final Color hoverForeground = theme.accentColor;

    List<Widget> totalBlocksInLast = buildTotalBlocksInLast(
        totalBlocks, totalTransactions, l10n,
        titleStyle: titleStyle,
        linkStyle: linkStyle,
        hoverForeground: hoverForeground);
    List<Widget> heightEquals = buildHeightEquals(maxHeight, l10n,
        titleStyle: titleStyle,
        linkStyle: linkStyle,
        hoverForeground: hoverForeground,
        onTap: () => appState.navigateToHeight(context, maxHeight));
    List<Widget> marketCap = buildMarketCap(
        tipHeight, price, appState.preferences.localCurrency, l10n,
        titleStyle: titleStyle,
        hoverForeground: hoverForeground,
        onTap: () => appState.launchMarketUrl(context));

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
    final TextStyle titleStyle = appState.theme.titleStyle;
    final TextStyle linkStyle = appState.theme.titleStyle
        .copyWith(decoration: TextDecoration.underline);
    final ThemeData theme = Theme.of(context);
    final Color hoverForeground = theme.secondaryHeaderColor;

    List<Widget> hashRate =
        buildHashRate(first, last, l10n, titleStyle: titleStyle);
    List<Widget> totalBlocksInLast = buildTotalBlocksInLast(
        totalBlocks, totalTransactions, l10n,
        titleStyle: titleStyle,
        linkStyle: linkStyle,
        hoverForeground: hoverForeground);
    List<Widget> heightEquals = buildHeightEquals(maxHeight, l10n,
        titleStyle: titleStyle,
        linkStyle: linkStyle,
        hoverForeground: hoverForeground,
        onTap: () => appState.navigateToHeight(context, maxHeight));
    List<Widget> marketCap = buildMarketCap(
        tipHeight, price, appState.preferences.localCurrency, l10n,
        titleStyle: titleStyle,
        hoverForeground: hoverForeground,
        onTap: () => appState.launchMarketUrl(context));

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
    int hashRate = hashRateOverride ??
        ((last == null || last.chainWork == null)
            ? 0
            : ((first.blockWork() + last.deltaWork(first)) ~/
                    BigInt.from(windowDuration.inSeconds))
                .toInt());
    return <Widget>[
      Text(l10n.formatHashRate(hashRate), style: titleStyle),
    ];
  }

  List<Widget> buildTotalBlocksInLast(
      int totalBlocks, int totalTransactions, Localization l10n,
      {TextStyle titleStyle, TextStyle linkStyle, Color hoverForeground}) {
    final String duration = l10n.formatDuration(windowDuration);
    return buildLocalizationMarkupWidgets(
      totalTransactions > 0
          ? l10n.totalBlocksTransactionsInLastDuration(
              totalBlocks, totalTransactions, duration)
          : l10n.totalBlocksInLastDuration(totalBlocks, duration),
      style: titleStyle,
      tags: <String, LocalizationMarkup>{
        'a1': LocalizationMarkup(
          style: linkStyle,
          hoverForeground: hoverForeground,
          onTap: () => Navigator.of(context).pushNamed('/tip'),
        ),
        'a2': LocalizationMarkup(
          widget: <Widget>[
            Tooltip(
                message: l10n.duration,
                child: widget.network.currency is ETH
                    ? Text(duration, style: titleStyle)
                    : (PopupMenuBuilder()
                          ..addItem(
                              text: l10n.formatDuration(Duration(days: 1)),
                              onSelected: setIntervalDaily)
                          ..addItem(
                              text: l10n.formatDuration(Duration(hours: 1)),
                              onSelected: setIntervalHourly))
                        .build(
                            child: Text('$duration', style: linkStyle),
                            padding: null)),
          ],
        ),
      },
    );
  }

  List<Widget> buildHeightEquals(int maxHeight, Localization l10n,
          {TextStyle titleStyle,
          TextStyle linkStyle,
          Color hoverForeground,
          VoidCallback onTap}) =>
      buildLocalizationMarkupWidgets(
        l10n.heightEquals(maxHeight),
        style: titleStyle,
        tags: <String, LocalizationMarkup>{
          'a': LocalizationMarkup(
            style: linkStyle,
            onTap: onTap,
            hoverForeground: hoverForeground,
          ),
        },
      );

  List<Widget> buildMarketCap(
      int tipHeight, num price, String currency, Localization l10n,
      {TextStyle titleStyle, Color hoverForeground, VoidCallback onTap}) {
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
                hoverForeground: hoverForeground,
              ),
            },
          )
        : null;
  }
}

/// Time series element
class TimeSeriesBlocks {
  /// Lower bound time for blocks in this bucket.
  DateTime time;

  /// Sum of the number of transcations in [block].
  int transactions = 0;

  /// The blocks with [BlockHeader.time] in this bucket.
  SortedListSet<BlockHeader> block = SortedListSet<BlockHeader>(
      BlockHeader.compareHeight, List<BlockHeader>());

  TimeSeriesBlocks(this.time);

  /// The number of blocks in this bucket.
  int get blocks => block.length;

  /// Compare the [BlockHeader.time] of two [BlockHeader].
  static int compareTime(dynamic a, dynamic b) => b.time.compareTo(a.time);
}

/// Converts [ui.color] to [charts.Color].
charts.Color chartColor(Color color) =>
    charts.Color(r: color.red, g: color.green, b: color.blue, a: color.alpha);

/// Rounds [time] down to nearest [duration].  e.g. 1:56 to 1:00.
DateTime truncateTime(DateTime time, BlockChartBucketDuration duration) =>
    DateTime(time.year, time.month, time.day, time.hour,
        duration == BlockChartBucketDuration.minute ? time.minute : 0);

/// Converts [BlockChartBucketDuration] to [Duration].
Duration getBucketDuration(BlockChartBucketDuration duration) {
  switch (duration) {
    case BlockChartBucketDuration.hour:
      return const Duration(hours: 1);
    case BlockChartBucketDuration.minute:
    default:
      return const Duration(minutes: 1);
  }
}
