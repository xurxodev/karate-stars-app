import 'package:hive_flutter/hive_flutter.dart';
import 'package:karate_stars_app/src/global_di.dart';
import 'package:karate_stars_app/src/common/auth/credentials.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/local/database.dart';
import 'package:karate_stars_app/src/news/data/local/data_sources/current_news_hive_data_source.dart';
import 'package:karate_stars_app/src/news/data/local/data_sources/social_news_hive_data_source.dart';
import 'package:karate_stars_app/src/news/data/local/models/social_news_db.dart';
import 'package:karate_stars_app/src/news/data/remote/current_news_api_data_source.dart';
import 'package:karate_stars_app/src/news/data/remote/social_news_api_data_source.dart';
import 'package:karate_stars_app/src/news/data/repositories/current_news_cached_repository.dart';
import 'package:karate_stars_app/src/news/data/repositories/social_news_cached_repository.dart';
import 'package:karate_stars_app/src/news/domain/boundaries/current_news_repository.dart';
import 'package:karate_stars_app/src/news/domain/boundaries/social_news_repository.dart';
import 'package:karate_stars_app/src/news/domain/entities/current.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';
import 'package:karate_stars_app/src/news/domain/get_news_use_case.dart';
import 'package:karate_stars_app/src/news/presentation/blocs/current_news_bloc.dart';

import 'data/local/models/current_news_db.dart';

void initAll(Database database, String apiUrl, Credentials apiCredentials) {
  _initCurrentNewsDataDI(database, apiUrl, apiCredentials);

  _initSocialNewsDataDI(database, apiUrl, apiCredentials);

  initBlocAndUseCases();
}

void initBlocAndUseCases() {
  getIt.registerFactory(() => CurrentNewsBloc(getIt(), getIt()));

  getIt.registerLazySingleton(() => GetNewsUseCase(getIt(), getIt()));
}

void _initCurrentNewsDataDI(
    Database database, String apiUrl, Credentials apiCredentials) {
  getIt.registerLazySingleton<ReadableDataSource<CurrentNews>>(
      () => CurrentNewsApiDataSource(apiUrl, apiCredentials, getIt()));

  getIt
      .registerLazySingleton<Box<CurrentNewsDB>>(() => database.currentNewsBox);

  getIt.registerLazySingleton<CacheableDataSource<CurrentNews>>(
      () => CurrentNewsHiveDataSource(getIt(), mediumCacheTimeMillis));

  getIt.registerLazySingleton<CurrentNewsRepository>(
      () => CurrentNewsCachedRepository(getIt(), getIt()));
}

void _initSocialNewsDataDI(
    Database database, String apiUrl, Credentials apiCredentials) {
  getIt.registerLazySingleton<ReadableDataSource<SocialNews>>(
      () => SocialNewsApiDataSource(apiUrl, apiCredentials, getIt()));

  getIt.registerLazySingleton<Box<SocialNewsDB>>(() => database.socialNewsBox);

  getIt.registerLazySingleton<CacheableDataSource<SocialNews>>(
      () => SocialNewsHiveDataSource(getIt(), smallCacheTimeMillis));

  getIt.registerLazySingleton<SocialNewsRepository>(
      () => SocialNewsCachedRepository(getIt(), getIt()));
}
