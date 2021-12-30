import 'package:karate_stars_app/app_di.dart';
import 'package:karate_stars_app/src/category_types/data/category_type_cached_repository.dart';
import 'package:karate_stars_app/src/category_types/data/local/category_type_in_memory_data_source.dart';
import 'package:karate_stars_app/src/category_types/data/remote/category_type_api_data_source.dart';
import 'package:karate_stars_app/src/category_types/domain/boundaries/category_type_repository.dart';
import 'package:karate_stars_app/src/category_types/domain/entities/category_type.dart';
import 'package:karate_stars_app/src/category_types/domain/get_category_types.dart';
import 'package:karate_stars_app/src/common/auth/credentials.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';

void initAll(String apiUrl, Credentials apiCredentials) {
  _initDataDI(apiUrl, apiCredentials);

  initBlocAndUseCases();
}

void initBlocAndUseCases() {
  getIt.registerLazySingleton(() => GetCategoryTypesUseCase(getIt()));
}

void _initDataDI(String apiUrl, Credentials apiCredentials) {
  getIt.registerLazySingleton<ReadableDataSource<CategoryType>>(
      () => CategoryTypeApiDataSource(apiUrl, apiCredentials, getIt()));

  getIt.registerLazySingleton<CacheableDataSource<CategoryType>>(
      () => CategoryTypeInMemoryDataSource(largeCacheTimeMillis));

  getIt.registerLazySingleton<CategoryTypeRepository>(
      () => CategoryTypeCachedRepository(getIt(), getIt()));
}
