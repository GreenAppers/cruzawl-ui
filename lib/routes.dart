// Copyright 2019 cruzawl developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

import 'package:flutter_web/material.dart'
    if (dart.library.io) 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import 'package:cruzawl/currency.dart';
import 'package:cruzawl/util.dart' hide VoidCallback;
import 'package:cruzawl/network.dart';
import 'package:cruzawl/wallet.dart';

import 'explorer/address.dart';
import 'explorer/block.dart';
import 'explorer/console.dart';
import 'explorer/cruzbase.dart';
import 'explorer/network.dart';
import 'explorer/settings.dart';
import 'explorer/transaction.dart';
import 'localization.dart';
import 'model.dart';
import 'ui.dart';
import 'wallet/address.dart';

class CruzawlRoutes {
  final Cruzawl appState;
  final double maxWidth;
  final Widget loadingWidget;
  final Route defaultRoute;
  final bool includeWalletRoutes;
  final SimpleScaffoldActions searchBar;

  CruzawlRoutes(this.appState,
      {this.maxWidth,
      this.loadingWidget,
      this.defaultRoute,
      this.includeWalletRoutes = false,
      bool cruzbaseSearchBar = false})
      : searchBar = cruzbaseSearchBar
            ? SimpleScaffoldActions(<Widget>[], searchBar: true)
            : null;

  Route onGenerateRoute(RouteSettings settings) {
    final PagePath page = PagePath.parse(settings.name);
    final Wallet wallet = appState.wallet.wallet;

    switch (page.page) {
      case 'addPeer':
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) => SimpleScaffold(AddPeerWidget(),
                title: Localization.of(context).newPeer));

      case 'address':
        return MaterialPageRoute(
            settings: settings,
            builder: (context) {
              if (page.arg == 'cruzbase') {
                Widget ret = ScopedModelDescendant<WalletModel>(
                    builder: (context, child, model) => CruzbaseWidget(
                        wallet.network,
                        wideStyle: useWideStyle(context, maxWidth)));
                return searchBar != null
                    ? ScopedModel<SimpleScaffoldActions>(
                        model: searchBar, child: ret)
                    : ret;
              }

              Address address = wallet.addresses[page.arg];
              return address != null
                  ? SimpleScaffold(AddressWidget(wallet, address),
                      title: Localization.of(context).address)
                  : ScopedModelDescendant<WalletModel>(
                      builder: (context, child, model) => ExternalAddressWidget(
                          wallet.network, page.arg,
                          title: Localization.of(context).externalAddress,
                          maxWidth: maxWidth,
                          loadingWidget: loadingWidget));
            });

      case 'block':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => ScopedModelDescendant<WalletModel>(
            builder: (context, child, model) => BlockWidget(wallet.network,
                blockId: page.arg,
                maxWidth: maxWidth,
                loadingWidget: loadingWidget),
          ),
        );

      case 'console':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => ScopedModelDescendant<WalletModel>(
            builder: (context, child, model) => CruzawlConsole(wallet.network),
          ),
        );

      case 'height':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => ScopedModelDescendant<WalletModel>(
            builder: (context, child, model) => BlockWidget(wallet.network,
                blockHeight: int.tryParse(page.arg) ?? 0,
                maxWidth: maxWidth,
                loadingWidget: loadingWidget),
          ),
        );

      case 'network':
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) =>
                ScopedModelDescendant<WalletModel>(
                    builder: (context, child, model) {
                  final Localization locale = Localization.of(context);
                  return SimpleScaffold(CruzawlNetworkSettings(),
                      title: locale
                          .networkType(locale.ticker(wallet.currency.ticker)));
                }));

      case 'settings':
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => SimpleScaffold(
              CruzawlSettings(walletSettings: includeWalletRoutes),
              title: Localization.of(context).settings),
        );

      case 'support':
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => SimpleScaffold(CruzawlSupport(),
              title: Localization.of(context).support),
        );

      case 'tip':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => ScopedModelDescendant<WalletModel>(
            builder: (context, child, model) => BlockWidget(wallet.network,
                maxWidth: maxWidth, loadingWidget: loadingWidget),
          ),
        );

      case 'transaction':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => ScopedModelDescendant<WalletModel>(
              builder: (context, child, model) {
            Transaction transaction = wallet.transactionIds[page.arg];
            return transaction != null
                ? TransactionWidget(
                    wallet.network, WalletTransactionInfo(wallet, transaction),
                    maxWidth: maxWidth,
                    loadingWidget: loadingWidget,
                    transaction: TransactionMessage(null, transaction))
                : TransactionWidget(wallet.network, TransactionInfo(),
                    maxWidth: maxWidth,
                    loadingWidget: loadingWidget,
                    transactionIdText: page.arg,
                    onHeightTap: (tx) =>
                        appState.navigateToHeight(context, tx.height));
          }),
        );

      default:
        return defaultRoute;
    }
  }
}
