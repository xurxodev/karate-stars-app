import 'package:karate_stars_app/src/purchases/domain/repositories/purchases_repository.dart';

class IsStoreAvailableUseCase {
  final PurchaseRepository _purchaseRepository;

  IsStoreAvailableUseCase(this._purchaseRepository);

  Future<bool> execute() {
    return _purchaseRepository.isStoreAvailable();
  }
}