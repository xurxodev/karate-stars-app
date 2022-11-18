import 'package:hive/hive.dart';
import 'package:karate_stars_app/src/global_di.dart';
import 'package:karate_stars_app/src/common/auth/credentials.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/local/database.dart';
import 'package:karate_stars_app/src/countries/data/country_cached_repository.dart';
import 'package:karate_stars_app/src/countries/data/local/country_db.dart';
import 'package:karate_stars_app/src/countries/data/local/country_hive_data_source.dart';
import 'package:karate_stars_app/src/countries/data/remote/country_api_data_source.dart';
import 'package:karate_stars_app/src/countries/domain/boundaries/country_repository.dart';
import 'package:karate_stars_app/src/countries/domain/entities/country.dart';
import 'package:karate_stars_app/src/countries/domain/get_countries_use_case.dart';

void initAll(Database database, String apiUrl, Credentials apiCredentials) {
  _initDataDI(database, apiUrl, apiCredentials);

  initBlocAndUseCases();
}

void initBlocAndUseCases() {
  getIt.registerLazySingleton(() => GetCountriesUseCase(getIt()));
}

void _initDataDI(Database database, String apiUrl, Credentials apiCredentials) {
  getIt.registerLazySingleton<ReadableDataSource<Country>>(
      () => CountryApiDataSource(apiUrl, apiCredentials, getIt()));

  getIt.registerLazySingleton<Box<CountryDB>>(() => database.countriesBox);

  getIt.registerLazySingleton<CacheableDataSource<Country>>(
      () => CountryHiveDataSource(getIt(), largeCacheTimeMillis));

  getIt.registerLazySingleton<CountryRepository>(
      () => CountryCachedRepository(getIt(), getIt()));
}
