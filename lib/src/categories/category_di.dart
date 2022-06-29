import 'package:hive/hive.dart';
import 'package:karate_stars_app/app_di.dart';
import 'package:karate_stars_app/src/categories/data/category_cached_repository.dart';
import 'package:karate_stars_app/src/categories/data/local/category_db.dart';
import 'package:karate_stars_app/src/categories/data/local/category_hive_data_source.dart';
import 'package:karate_stars_app/src/categories/data/remote/category_api_data_source.dart';
import 'package:karate_stars_app/src/categories/domain/boundaries/category_repository.dart';
import 'package:karate_stars_app/src/categories/domain/entities/category.dart';
import 'package:karate_stars_app/src/categories/domain/get_categories.dart';
import 'package:karate_stars_app/src/categories/domain/get_categories_by_ids.dart';
import 'package:karate_stars_app/src/categories/domain/get_category_by_id.dart';
import 'package:karate_stars_app/src/common/auth/credentials.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/local/database.dart';

void initAll(Database database, String apiUrl, Credentials apiCredentials) {
  _initDataDI(database, apiUrl, apiCredentials);

  initBlocAndUseCases();
}

void initBlocAndUseCases() {
  getIt.registerLazySingleton(() => GetCategoriesUseCase(getIt()));
  getIt.registerLazySingleton(() => GetCategoriesByIdsUseCase(getIt()));
  getIt.registerLazySingleton(() => GetCategoryByIdUseCase(getIt()));
}

void _initDataDI(Database database, String apiUrl, Credentials apiCredentials) {
  getIt.registerLazySingleton<ReadableDataSource<Category>>(
      () => CategoryApiDataSource(apiUrl, apiCredentials, getIt()));

  getIt
      .registerLazySingleton<Box<CategoryDB>>(() => database.categoriesBox);

  getIt.registerLazySingleton<CacheableDataSource<Category>>(
      () => CategoryHiveDataSource(getIt(), largeCacheTimeMillis));

  getIt.registerLazySingleton<CategoryRepository>(
      () => CategoryCachedRepository(getIt(), getIt()));
}
