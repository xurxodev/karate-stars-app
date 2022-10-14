import 'dart:async';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc.dart';
import 'package:karate_stars_app/src/common/presentation/boundaries/analytics.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/purchases/domain/product.dart';
import 'package:karate_stars_app/src/purchases/domain/usecases/get_products.dart';
import 'package:karate_stars_app/src/purchases/domain/usecases/is_premium.dart';
import 'package:karate_stars_app/src/purchases/domain/usecases/is_store_available.dart';
import 'package:karate_stars_app/src/purchases/domain/usecases/purchase.dart';
import 'package:karate_stars_app/src/purchases/domain/usecases/restore_purchases.dart';
import 'package:karate_stars_app/src/purchases/presentation/state/purchases_state.dart';

class PurchasesBloc extends Bloc<PurchasesState> {
  static const screen_name = 'purchases';

  final IsStoreAvailableUseCase _isStoreAvailableUseCase;
  final GetProductsUseCase _getProductsUseCase;
  final IsPremiumUseCase _isPremiumUseCase;
  final RestorePurchasesUseCase _restorePurchasesUseCase;
  final PurchaseUseCase _purchaseUseCase;

  final AnalyticsService _analyticsService;

  late Stream<List<ProductDetails>>? purchasesStream;

  PurchasesBloc(
      this._isStoreAvailableUseCase,
      this._getProductsUseCase,
      this._isPremiumUseCase,
      this._restorePurchasesUseCase,
      this._purchaseUseCase,
      this._analyticsService) {
    changeState(
        PurchasesState.loading(Strings.purchase_loading_is_store_available));
    _load();
  }

  Future<void> _load() async {
    try {
      final isAvailable = await _isStoreAvailableUseCase.execute();

      if (isAvailable) {
        _loadProducts();
      } else {
        changeState(PurchasesState.notAvailable());
      }
    } on Exception {
      changeState(PurchasesState.error(Strings.network_error_message));
    }
  }

  Future<void> _loadProducts() async {
    try {
      changeState(PurchasesState.loading(Strings.purchase_loading_products));

      final products = await _getProductsUseCase.execute();

      changeState(PurchasesState.productsLoaded(products));
    } on Exception {
      changeState(PurchasesState.error(Strings.network_error_message));
    }
  }

  Future<void> restorePurchases() async {
    _restorePurchasesUseCase.execute();
  }

  Future<void> purchase(Product product) async {
    _purchaseUseCase.execute(product);
  }
}
