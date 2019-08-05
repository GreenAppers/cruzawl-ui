// Copyright 2019 cruzawl developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

import 'package:flutter_web/material.dart'
    if (dart.library.io) 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import 'package:cruzawl/currency.dart';
import 'package:cruzawl/wallet.dart';

import 'address.dart';
import 'block.dart';
import 'cruzbase.dart';
import 'localization.dart';
import 'model.dart';
import 'network.dart';
import 'settings.dart';
import 'transaction.dart';
import 'ui.dart';
import 'wallet/address.dart';

class CruzallRoutes {
  final Cruzawl appState;
  final double maxWidth;
  final Widget loadingWidget;
  final Route defaultRoute;
  final bool includeWalletRoutes;
  CruzallRoutes(this.appState,
      {this.maxWidth,
      this.loadingWidget,
      this.defaultRoute,
      this.includeWalletRoutes = false});

  Route onGenerateRoute(RouteSettings settings) {
    final PagePath page = parsePagePath(settings.name);
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
              if (page.arg == 'cruzbase')
                return ScopedModelDescendant<WalletModel>(
                    builder: (context, child, model) =>
                        CruzbaseWidget(wallet.currency));

              Address address = wallet.addresses[page.arg];
              return address != null
                  ? SimpleScaffold(AddressWidget(wallet, address),
                      title: Localization.of(context).address)
                  : ScopedModelDescendant<WalletModel>(
                      builder: (context, child, model) => ExternalAddressWidget(
                          wallet.currency, page.arg,
                          title: Localization.of(context).externalAddress,
                          maxWidth: maxWidth,
                          loadingWidget: loadingWidget));
            });

      case 'block':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => ScopedModelDescendant<WalletModel>(
            builder: (context, child, model) => BlockWidget(wallet.currency,
                blockId: page.arg,
                maxWidth: maxWidth,
                loadingWidget: loadingWidget),
          ),
        );

      case 'height':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => ScopedModelDescendant<WalletModel>(
            builder: (context, child, model) => BlockWidget(wallet.currency,
                blockHeight: int.parse(page.arg),
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
              CruzallSettings(walletSettings: includeWalletRoutes),
              title: Localization.of(context).settings),
        );

      case 'support':
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => SimpleScaffold(CruzallSupport(),
              title: Localization.of(context).support),
        );

      case 'tip':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => ScopedModelDescendant<WalletModel>(
            builder: (context, child, model) => BlockWidget(wallet.currency,
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
                    wallet.currency, WalletTransactionInfo(wallet, transaction),
                    maxWidth: maxWidth,
                    loadingWidget: loadingWidget,
                    transaction: transaction)
                : TransactionWidget(wallet.currency, TransactionInfo(),
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
