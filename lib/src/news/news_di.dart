import 'package:hive/hive.dart';
import 'package:karate_stars_app/app_di.dart';
import 'package:karate_stars_app/src/common/analytics/firebase_analytics_service.dart';
import 'package:karate_stars_app/src/common/auth/api_credentials_loader.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/presentation/boundaries/analytics.dart';
import 'package:karate_stars_app/src/news/data/local/data_sources/current_news_hive_data_source.dart';
import 'package:karate_stars_app/src/news/data/local/models/current_news_db.dart';
import 'package:karate_stars_app/src/news/data/local/models/current_news_source_db.dart';
import 'package:karate_stars_app/src/news/data/local/models/social_news_db.dart';
import 'package:karate_stars_app/src/news/data/local/models/social_user_db.dart';
import 'package:karate_stars_app/src/news/data/local/data_sources/social_news_hive_data_source.dart';
import 'package:karate_stars_app/src/news/data/remote/current_news_api_data_source.dart';
import 'package:karate_stars_app/src/news/data/remote/social_news_api_data_source.dart';
import 'package:karate_stars_app/src/news/data/repositories/current_news_cached_repository.dart';
import 'package:karate_stars_app/src/news/data/repositories/social_news_cached_repository.dart';
import 'package:karate_stars_app/src/news/domain/boundaries/current_news_repository.dart';
import 'package:karate_stars_app/src/news/domain/entities/current.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';
import 'package:karate_stars_app/src/news/domain/get_news_use_case.dart';
import 'package:karate_stars_app/src/news/domain/boundaries/social_news_repository.dart';
import 'package:karate_stars_app/src/news/presentation/blocs/news_bloc.dart';

Future<void> initAll(Credentials apiCredentials) async {
  await _initCurrentNewsDataDI(apiCredentials);
  await _initSocialNewsDataDI(apiCredentials);

  initBlocAndUseCases();
}

void initBlocAndUseCases() {
  getIt.registerLazySingleton<AnalyticsService>(
      () => FirebaseAnalyticsService());

  getIt.registerFactory(() => NewsBloc(getIt(), getIt()));

  getIt.registerLazySingleton(() => GetNewsUseCase(getIt(), getIt()));
}

Future<void> _initCurrentNewsDataDI(Credentials apiCredentials) async {
  Hive.registerAdapter<CurrentNewsSourceDB>(CurrentNewsSourceDBAdapter());
  Hive.registerAdapter<CurrentNewsDB>(CurrentNewsDBAdapter());
  final currentNewsBox = await Hive.openBox<CurrentNewsDB>('CurrentNews');

  getIt.registerLazySingleton<ReadableDataSource<CurrentNews>>(
      () => CurrentNewsApiDataSource(apiBaseAddress, apiCredentials, getIt()));

  getIt.registerLazySingleton<Box<CurrentNewsDB>>(()=> currentNewsBox);

  getIt.registerLazySingleton<CacheableDataSource<CurrentNews>>(() =>
      CurrentNewsHiveDataSource(getIt(), mediumCacheTimeMillis));

  getIt.registerLazySingleton<CurrentNewsRepository>(
      () => CurrentNewsCachedRepository(getIt(), getIt()));
}

Future<void> _initSocialNewsDataDI(Credentials apiCredentials) async {
  Hive.registerAdapter<SocialUserDB>(SocialUserDBAdapter());
  Hive.registerAdapter<SocialNewsDB>(SocialNewsDBAdapter());
  final socialNewsBox = await Hive.openBox<SocialNewsDB>('SocialNews');

  getIt.registerLazySingleton<ReadableDataSource<SocialNews>>(
      () => SocialNewsApiDataSource(apiBaseAddress, apiCredentials, getIt()));

  getIt.registerLazySingleton<Box<SocialNewsDB>>(()=> socialNewsBox);

  getIt.registerLazySingleton<CacheableDataSource<SocialNews>>(
      () => SocialNewsHiveDataSource(getIt(), mediumCacheTimeMillis));

  getIt.registerLazySingleton<SocialNewsRepository>(
      () => SocialNewsCachedRepository(getIt(), getIt()));
}
