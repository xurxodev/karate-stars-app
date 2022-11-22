import 'package:karate_stars_app/src/common/auth/credentials.dart';
import 'package:karate_stars_app/src/global_di.dart';
import 'package:karate_stars_app/src/purchases/data/purchases_revenuecat_repository.dart';
import 'package:karate_stars_app/src/purchases/domain/repositories/purchases_repository.dart';
import 'package:karate_stars_app/src/purchases/domain/usecases/get_products.dart';
import 'package:karate_stars_app/src/purchases/domain/usecases/is_premium.dart';
import 'package:karate_stars_app/src/purchases/domain/usecases/purchase.dart';
import 'package:karate_stars_app/src/purchases/domain/usecases/restore_purchases.dart';
import 'package:karate_stars_app/src/purchases/presentation/blocs/purchases_bloc.dart';

void initAll(String apiUrl, Credentials apiCredentials) {
  _initDataDI(apiUrl, apiCredentials);

  initBlocAndUseCases();
}

void initBlocAndUseCases() {
  getIt.registerFactory(() =>
      PurchasesBloc(getIt(), getIt(), getIt(), getIt()));

  getIt.registerLazySingleton(() => GetProductsUseCase(getIt()));
  getIt.registerLazySingleton(() => IsPremiumUseCase(getIt()));
  getIt.registerLazySingleton(() => RestorePurchasesUseCase(getIt()));
  getIt.registerLazySingleton(() => PurchaseUseCase(getIt()));
}

void _initDataDI(String apiUrl, Credentials apiCredentials) {
  getIt.registerLazySingleton<PurchaseRepository>(
      () => PurchaseRevenueCatRepository());
}
