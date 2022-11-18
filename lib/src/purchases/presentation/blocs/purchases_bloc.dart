import 'dart:async';

import 'package:karate_stars_app/src/common/presentation/blocs/bloc.dart';
import 'package:karate_stars_app/src/common/presentation/boundaries/analytics.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/purchases/domain/product.dart';
import 'package:karate_stars_app/src/purchases/domain/usecases/get_products.dart';
import 'package:karate_stars_app/src/purchases/domain/usecases/purchase.dart';
import 'package:karate_stars_app/src/purchases/domain/usecases/restore_purchases.dart';
import 'package:karate_stars_app/src/purchases/presentation/state/purchases_state.dart';

class PurchasesBloc extends Bloc<PurchasesState> {
  static const screen_name = 'purchases';

  final GetProductsUseCase _getProductsUseCase;
  final RestorePurchasesUseCase _restorePurchasesUseCase;
  final PurchaseUseCase _purchaseUseCase;

  final AnalyticsService _analyticsService;

  PurchasesBloc(this._getProductsUseCase, this._restorePurchasesUseCase,
      this._purchaseUseCase, this._analyticsService) {

    _analyticsService.sendScreenName('$screen_name');

    changeState(PurchasesState.loading());

    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final products = await _getProductsUseCase.execute();

      changeState(
          PurchasesState.loaded(PurchasesStateData(products: products)));
    } on Exception {
      changeState(PurchasesState.error(Strings.network_error_message));
    }
  }

  Future<void> restorePurchases() async {
    try {
      _restorePurchasesUseCase.execute();
    } on Exception {
      changeState(PurchasesState.error(Strings.purchase_restore_error));
    }
  }

  Future<void> purchase(Product product) async {
    _purchaseUseCase.execute(product);
  }
}
