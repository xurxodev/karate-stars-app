import 'package:karate_stars_app/app_di.dart';
import 'package:karate_stars_app/src/categories/data/category_cached_repository.dart';
import 'package:karate_stars_app/src/categories/data/local/category_in_memory_data_source.dart';
import 'package:karate_stars_app/src/categories/data/remote/category_api_data_source.dart';
import 'package:karate_stars_app/src/categories/domain/boundaries/category_repository.dart';
import 'package:karate_stars_app/src/categories/domain/entities/category.dart';
import 'package:karate_stars_app/src/categories/domain/get_categories.dart';
import 'package:karate_stars_app/src/common/auth/credentials.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/database.dart';

void initAll(
    AppDatabase appDatabase, String apiUrl, Credentials apiCredentials) {
  _initDataDI(appDatabase, apiUrl, apiCredentials);

  initBlocAndUseCases();
}

void initBlocAndUseCases() {
  getIt.registerLazySingleton(() => GetCategoriesUseCase(getIt()));
}

void _initDataDI(
    AppDatabase appDatabase, String apiUrl, Credentials apiCredentials) {
  getIt.registerLazySingleton<ReadableDataSource<Category>>(
      () => CategoryApiDataSource(apiUrl, apiCredentials, getIt()));

  getIt.registerLazySingleton<CacheableDataSource<Category>>(
      () => CategoryInMemoryDataSource(largeCacheTimeMillis));

  getIt.registerLazySingleton<CategoryRepository>(
      () => CategoryCachedRepository(getIt(), getIt()));
}
