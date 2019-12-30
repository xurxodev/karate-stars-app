import 'package:karate_stars_app/dependencies_provider.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/database.dart';
import 'package:karate_stars_app/src/news/data/local/current_news_floor_data_source.dart';
import 'package:karate_stars_app/src/news/data/remote/current_news_api_data_source.dart';
import 'package:karate_stars_app/src/news/data/remote/social_news_api_data_source.dart';
import 'package:karate_stars_app/src/news/data/repositories/current_news_cached_repository.dart';
import 'package:karate_stars_app/src/news/data/repositories/social_news_cached_repository.dart';
import 'package:karate_stars_app/src/news/domain/entities/current.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';
import 'package:karate_stars_app/src/news/domain/get_news_use_case.dart';
import 'package:karate_stars_app/src/news/presentation/blocs/news_bloc.dart';
import 'package:karate_stars_app/src/news/domain/current_news_repository.dart';
import 'package:karate_stars_app/src/news/domain/social_news_repository.dart';

void init(AppDatabase appDatabase) {
  getIt.registerLazySingleton<ReadableDataSource<CurrentNews>>(
      () => CurrentNewsApiDataSource());

  getIt.registerLazySingleton(
          () => appDatabase.currentNewsDao);

  getIt.registerLazySingleton(
          () => appDatabase.currentNewsSourcesDao);

  getIt.registerLazySingleton<CacheDataSource<CurrentNews>>(
          () => CurrentNewsFloorDataSource(getIt(),getIt()));

  getIt.registerLazySingleton<ReadableDataSource<SocialNews>>(
      () => SocialNewsApiDataSource());

  getIt.registerLazySingleton<CurrentNewsRepository>(
      () => CurrentNewsCachedRepository(getIt(),getIt()));

  getIt.registerLazySingleton<SocialNewsRepository>(
      () => SocialNewsCachedRepository(getIt()));

  getIt.registerLazySingleton(() => GetNewsUseCase(getIt(), getIt()));

  getIt.registerFactory(() => NewsBloc(getIt()));
}
