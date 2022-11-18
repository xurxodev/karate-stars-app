import 'package:karate_stars_app/src/purchases/domain/repositories/purchases_repository.dart';

class RestorePurchasesUseCase {
  final PurchaseRepository _purchaseRepository;

  RestorePurchasesUseCase(this._purchaseRepository);

  Future<void> execute() {
    return _purchaseRepository.restorePurchases();
  }
}