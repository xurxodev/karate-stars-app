import 'package:karate_stars_app/app_di.dart';
import 'package:karate_stars_app/src/common/auth/api_credentials_loader.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/database.dart';
import 'package:karate_stars_app/src/news/data/local/current_news_floor_data_source.dart';
import 'package:karate_stars_app/src/news/data/local/social_news_floor_data_source.dart';
import 'package:karate_stars_app/src/news/data/remote/current_news_api_data_source.dart';
import 'package:karate_stars_app/src/news/data/remote/social_news_api_data_source.dart';
import 'package:karate_stars_app/src/news/data/repositories/current_news_cached_repository.dart';
import 'package:karate_stars_app/src/news/data/repositories/social_news_cached_repository.dart';
import 'package:karate_stars_app/src/news/domain/boundaries/current_news_repository.dart';
import 'package:karate_stars_app/src/news/domain/boundaries/social_news_repository.dart';
import 'package:karate_stars_app/src/news/domain/entities/current.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';
import 'package:karate_stars_app/src/news/domain/get_news_use_case.dart';
import 'package:karate_stars_app/src/news/presentation/blocs/news_bloc.dart';

void initAll(AppDatabase appDatabase, Credentials apiCredentials) {
  _initCurrentNewsDataDI(appDatabase, apiCredentials);

  _initSocialNewsDataDI(appDatabase, apiCredentials);

  initBlocAndUseCases();
}

void initBlocAndUseCases() {
  getIt.registerFactory(() => NewsBloc(getIt(), getIt()));

  getIt.registerLazySingleton(() => GetNewsUseCase(getIt(), getIt()));
}

void _initCurrentNewsDataDI(
    AppDatabase appDatabase, Credentials apiCredentials) {
  getIt.registerLazySingleton<ReadableDataSource<CurrentNews>>(
      () => CurrentNewsApiDataSource(apiBaseAddress, apiCredentials, getIt()));

  getIt.registerLazySingleton(() => appDatabase.currentNewsDao);

  getIt.registerLazySingleton(() => appDatabase.currentNewsSourcesDao);

  getIt.registerLazySingleton<CacheableDataSource<CurrentNews>>(() =>
      CurrentNewsFloorDataSource(getIt(), getIt(), mediumCacheTimeMillis));

  getIt.registerLazySingleton<CurrentNewsRepository>(
      () => CurrentNewsCachedRepository(getIt(), getIt()));
}

void _initSocialNewsDataDI(
    AppDatabase appDatabase, Credentials apiCredentials) {
  getIt.registerLazySingleton<ReadableDataSource<SocialNews>>(
      () => SocialNewsApiDataSource(apiBaseAddress, apiCredentials, getIt()));

  getIt.registerLazySingleton(() => appDatabase.socialNewsDao);

  getIt.registerLazySingleton(() => appDatabase.socialUsersDao);

  getIt.registerLazySingleton<CacheableDataSource<SocialNews>>(
      () => SocialNewsFloorDataSource(getIt(), getIt(), mediumCacheTimeMillis));

  getIt.registerLazySingleton<SocialNewsRepository>(
      () => SocialNewsCachedRepository(getIt(), getIt()));
}
