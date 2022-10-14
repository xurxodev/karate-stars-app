import 'dart:async';
import 'dart:io';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:karate_stars_app/src/purchases/domain/product.dart';
import 'package:karate_stars_app/src/purchases/domain/repositories/purchases_repository.dart';

class PurchaseInAppRepository implements PurchaseRepository {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;

  final _premiumController = StreamController<bool>.broadcast();

  late StreamSubscription<List<PurchaseDetails>> _subscription;

  PurchaseInAppRepository() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;

    _subscription =
        purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (Object error) {
      throw Exception('An error has occurred listening purchases: $error');
    });

    restorePurchases();
  }

  @override
  Stream<bool> isPremium() {
    return _premiumController.stream;
  }

  @override
  Future<List<Product>> getProducts(List<String> productIds) async {
    final ProductDetailsResponse productDetailResponse =
        await _inAppPurchase.queryProductDetails(productIds.toSet());

    if (productDetailResponse.error != null) {
      throw Exception(productDetailResponse.error?.message);
    } else if (productDetailResponse.notFoundIDs.isNotEmpty) {
      throw Exception(
          'An error has occurred retrieving the next products: ${productDetailResponse.notFoundIDs.join(",")}');
    } else {
      return productDetailResponse.productDetails
          .map((productDetails) => Product(
              id: productDetails.id,
              title: productDetails.title,
              description: productDetails.description,
              formattedPrice: productDetails.price,
              price: productDetails.rawPrice,
              currencyCode: productDetails.currencyCode))
          .toList();
    }
  }

  @override
  Future<bool> isStoreAvailable() {
    return _inAppPurchase.isAvailable();
  }

  @override
  Future<void> restorePurchases() {
    return _inAppPurchase.restorePurchases();
  }

  @override
  Future<bool> purchase(Product product) {
    final productDetails = ProductDetails(
      id: product.id,
      title: product.title,
      description: product.description,
      price: product.formattedPrice,
      rawPrice: product.price,
      currencyCode: product.currencyCode,
    );

    late PurchaseParam purchaseParam;

    if (Platform.isAndroid) {
      // NOTE: If you are making a subscription purchase/upgrade/downgrade, we recommend you to
      // verify the latest status of you your subscription by using server side receipt validation
      // and update the UI accordingly. The subscription purchase status shown
      // inside the app may not be accurate.

      purchaseParam = GooglePlayPurchaseParam(
          productDetails: productDetails, changeSubscriptionParam: null);
    } else {
      purchaseParam = PurchaseParam(
        productDetails: productDetails,
      );
    }

    return _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
  }

  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        print('-------------------------------> Pending purchase');
        //showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          print('-------------------------------> Handle error purchase');
          //handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          _verifyPurchaseAndEnablePremium(purchaseDetails);
        }
        if (purchaseDetails.pendingCompletePurchase) {
          print('-------------------------------> completing purchase');
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
  }

  Future<void> _verifyPurchaseAndEnablePremium(
      PurchaseDetails purchaseDetails) async {
    // check if the purchase is valid by calling your server including the receipt data.
    final valid = await _verifyPurchase(purchaseDetails);

    if (valid) {
      _enablePremiumFeatures();
    } else {
      // The receipt is not valid. Don't enable any subscription features.
      _handleInvalidPurchase(purchaseDetails);
    }
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    print('-------------------------------> Verifying purchase');
    print(purchaseDetails.status);
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    return Future<bool>.value(true);
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    print('-------------------------------> Handling invalid purchase');
    // handle invalid purchase here if  _verifyPurchase` failed.
  }

  void _enablePremiumFeatures() {
    print('-------------------------------> Is Premium !!!!');
    _premiumController.sink.add(true);
  }

  void _disablePremiumFeatures() {
    print('-------------------------------> Is not Premium !!!!');
    _premiumController.sink.add(false);
  }

  void dispose() {
    _premiumController.close();
    _subscription.cancel();
  }
}
