import 'package:karate_stars_app/app_di.dart';
import 'package:karate_stars_app/src/common/auth/credentials.dart';
import 'package:karate_stars_app/src/common/data/database.dart';
import 'package:karate_stars_app/src/settings/data/settings_preferences_repository.dart';
import 'package:karate_stars_app/src/settings/domain/boundaries/settings_repository.dart';
import 'package:karate_stars_app/src/settings/domain/get_settings_use_case.dart';
import 'package:karate_stars_app/src/settings/domain/save_settings_use_case.dart';
import 'package:karate_stars_app/src/settings/presentation/blocs/settings_bloc.dart';

void initAll(
    AppDatabase appDatabase, String apiUrl, Credentials apiCredentials) {
  _initDataDI(appDatabase, apiUrl, apiCredentials);

  initBlocAndUseCases();
}

void initBlocAndUseCases() {
  getIt.registerFactory(() => SettingsBloc(getIt(), getIt(), getIt()));

  getIt.registerLazySingleton(() => GetSettingsUseCase(getIt()));
  getIt.registerLazySingleton(() => SaveSettingsUseCase(getIt()));

}

void _initDataDI(
    AppDatabase appDatabase, String apiUrl, Credentials apiCredentials) {
  getIt.registerLazySingleton<SettingsRepository>(
      () => SettingsPreferencesRepository());
}
