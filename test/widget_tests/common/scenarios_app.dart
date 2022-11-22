import 'package:karate_stars_app/src/global_di.dart' as app_di;
import 'package:karate_stars_app/src/purchases/domain/repositories/purchases_repository.dart';
import 'package:mocktail/mocktail.dart';

import 'mocks.dart';

void givenIsPremium() {
  final mockPurchaseRepository = MockPurchasesRepository();
  when(() => mockPurchaseRepository.isPremium()).thenAnswer((_) =>
      Stream.value(true));
  app_di.getIt
      .registerLazySingleton<PurchaseRepository>(() => mockPurchaseRepository);
}
