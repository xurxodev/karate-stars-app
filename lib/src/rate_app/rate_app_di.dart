import 'package:karate_stars_app/src/global_di.dart';
import 'package:karate_stars_app/src/common/auth/credentials.dart';
import 'package:karate_stars_app/src/rate_app/data/rate_app_preferences_repository.dart';
import 'package:karate_stars_app/src/rate_app/domain/boundaries/rate_app_repository.dart';
import 'package:karate_stars_app/src/rate_app/domain/usecases/get_rate_app_use_case.dart';
import 'package:karate_stars_app/src/rate_app/domain/usecases/save_rate_app_use_case.dart';

void initAll(Credentials apiCredentials) {
  _initDataDI(apiCredentials);

  initUseCases();
}

void initUseCases() {
  getIt.registerLazySingleton(() => GetRateAppUseCase(getIt()));
  getIt.registerLazySingleton(() => SaveRateAppUseCase(getIt()));
}

void _initDataDI(Credentials apiCredentials) {
  getIt.registerLazySingleton<RateAppRepository>(
          () => RateAppPreferencesRepository());
}