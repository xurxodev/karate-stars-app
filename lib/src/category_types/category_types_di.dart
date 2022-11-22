import 'package:hive/hive.dart';
import 'package:karate_stars_app/src/category_types/data/category_type_cached_repository.dart';
import 'package:karate_stars_app/src/category_types/data/local/category_type_db.dart';
import 'package:karate_stars_app/src/category_types/data/local/category_type_hive_data_source.dart';
import 'package:karate_stars_app/src/category_types/data/remote/category_type_api_data_source.dart';
import 'package:karate_stars_app/src/category_types/domain/boundaries/category_type_repository.dart';
import 'package:karate_stars_app/src/category_types/domain/entities/category_type.dart';
import 'package:karate_stars_app/src/category_types/domain/get_category_types.dart';
import 'package:karate_stars_app/src/common/auth/credentials.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/local/database.dart';
import 'package:karate_stars_app/src/global_di.dart';

void initAll(Database database, String apiUrl, Credentials apiCredentials) {
  _initDataDI(database, apiUrl, apiCredentials);

  initBlocAndUseCases();
}

void initBlocAndUseCases() {
  getIt.registerLazySingleton(() => GetCategoryTypesUseCase(getIt()));
}

void _initDataDI(Database database, String apiUrl, Credentials apiCredentials) {
  getIt.registerLazySingleton<ReadableDataSource<CategoryType>>(
      () => CategoryTypeApiDataSource(apiUrl, apiCredentials, getIt()));

  getIt.registerLazySingleton<Box<CategoryTypeDB>>(
      () => database.categoryTypesBox);

  getIt.registerLazySingleton<CacheableDataSource<CategoryType>>(
      () => CategoryTypeHiveDataSource(getIt(), largeCacheTimeMillis));

  getIt.registerLazySingleton<CategoryTypeRepository>(
      () => CategoryTypeCachedRepository(getIt(), getIt()));
}
