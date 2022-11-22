import 'dart:async';
import 'dart:io';

import 'package:karate_stars_app/src/purchases/domain/product.dart';
import 'package:karate_stars_app/src/purchases/domain/repositories/purchases_repository.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

const entitlementID = 'pro';

class PurchaseRevenueCatRepository implements PurchaseRepository {
  final _premiumController = StreamController<bool>.broadcast();

  PurchaseRevenueCatRepository() {
    _init();
  }

  @override
  Stream<bool> isPremium() {
    return _premiumController.stream;
  }

  @override
  Future<List<Product>> getProducts() async {
    try {
      final packages = await _getPackages();

      return packages
          .map((package) => Product(
              id: package.storeProduct.identifier,
              title: package.storeProduct.title,
              description: package.storeProduct.description,
              formattedPrice: package.storeProduct.priceString,
              price: package.storeProduct.price,
              currencyCode: package.storeProduct.currencyCode))
          .toList();
    } on Exception {
      throw Exception('An error has occurred retrieving the products');
    }
  }

  @override
  Future<void> restorePurchases() async {
    try {
      final customerInfo = await Purchases.restorePurchases();

      _validateIsPremium(customerInfo);
    } on Exception {
      throw Exception(
          'An error has occurred restoring purchases');
    }
  }

  @override
  Future<void> purchase(Product product) async {
    final packages = await _getPackages();

    final package = packages.firstWhereOrNull(
        (package) => package.storeProduct.identifier == product.id);

    if (package == null) {
      throw Exception(
          'An error has occurred retrieving associated package for the product');
    }

    await Purchases.purchasePackage(package);
  }

  Future<void> _init() async {
    // Enable debug logs before calling `configure`.
    await Purchases.setDebugLogsEnabled(true);

    PurchasesConfiguration configuration;

    if (Platform.isAndroid) {
      configuration = PurchasesConfiguration('goog_dqziGYeZiwLVbJhBKBorKLyLcTM')
        ..appUserID = null
        ..observerMode = false;
    } else {
      configuration = PurchasesConfiguration('appl_zpfUfxfSCJyGECkjzdRHftlvYbb')
        ..appUserID = null
        ..observerMode = false;
    }
    await Purchases.configure(configuration);

    Purchases.addCustomerInfoUpdateListener((customerInfo) async {
      final customerInfo = await Purchases.getCustomerInfo();

      _validateIsPremium(customerInfo);
    });
  }

  void _validateIsPremium(CustomerInfo customerInfo)  {
    final isPremium = customerInfo.entitlements.all[entitlementID] != null &&
        customerInfo.entitlements.all[entitlementID]!.isActive;

    if (isPremium){
      _enablePremiumFeatures();
    } else{
      _disablePremiumFeatures();
    }
  }

  Future<List<Package>> _getPackages() async {
    final offerings = await Purchases.getOfferings();

    return offerings.current?.availablePackages ?? [];
  }

  void _enablePremiumFeatures() {
    print('-------------------------------> Is Premium !!!!');
    _premiumController.sink.add(true);
  }

  void _disablePremiumFeatures() {
    print('-------------------------------> Is not Premium !!!!');
    _premiumController.sink.add(false);
  }
}
