import 'package:karate_stars_app/src/purchases/domain/product.dart';
import 'package:karate_stars_app/src/purchases/domain/repositories/purchases_repository.dart';

class PurchaseUseCase {
  final PurchaseRepository _purchaseRepository;

  PurchaseUseCase(this._purchaseRepository);

  Future<void> execute(Product product) {
    return _purchaseRepository.purchase(product);
  }
}