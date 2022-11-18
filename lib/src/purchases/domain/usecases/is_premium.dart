import 'package:karate_stars_app/src/purchases/domain/repositories/purchases_repository.dart';

class IsPremiumUseCase {
  final PurchaseRepository _purchaseRepository;

  IsPremiumUseCase(this._purchaseRepository);

  Stream<bool> execute() {
    return _purchaseRepository.isPremium();
  }
}
