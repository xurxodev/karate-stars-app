import 'dart:async';

import 'package:karate_stars_app/src/purchases/domain/product.dart';

abstract class PurchaseRepository {
  Future<List<Product>> getProducts();
  Stream<bool> isPremium();
  Future<void> restorePurchases();
  Future<void> purchase(Product product);
}
