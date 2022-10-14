import 'dart:async';

import 'package:karate_stars_app/src/purchases/domain/product.dart';

abstract class PurchaseRepository {
  Future<bool> isStoreAvailable();
  Future<List<Product>> getProducts(List<String> productIds);
  Stream<bool> isPremium();
  Future<void> restorePurchases();
  Future<bool> purchase(Product product);
}
