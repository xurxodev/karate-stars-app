import 'package:karate_stars_app/src/purchases/domain/product.dart';
import 'package:karate_stars_app/src/purchases/domain/repositories/purchases_repository.dart';

const String _yearlySubscriptionId = 'karate_stars_pro_yearly';
const List<String> _productIds = <String>[
  _yearlySubscriptionId,
];

class GetProductsUseCase {
  final PurchaseRepository _purchaseRepository;

  GetProductsUseCase(this._purchaseRepository);

  Future<List<Product>> execute() {
    return _purchaseRepository.getProducts(_productIds);
  }
}
