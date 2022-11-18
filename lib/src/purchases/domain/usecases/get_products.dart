import 'package:karate_stars_app/src/purchases/domain/product.dart';
import 'package:karate_stars_app/src/purchases/domain/repositories/purchases_repository.dart';

class GetProductsUseCase {
  final PurchaseRepository _purchaseRepository;

  GetProductsUseCase(this._purchaseRepository);

  Future<List<Product>> execute() {
    return _purchaseRepository.getProducts();
  }
}
