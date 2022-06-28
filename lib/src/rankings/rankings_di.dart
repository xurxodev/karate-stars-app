import 'package:hive/hive.dart';
import 'package:karate_stars_app/app_di.dart';
import 'package:karate_stars_app/src/common/auth/credentials.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/local/database.dart';
import 'package:karate_stars_app/src/rankings/data/local/ranking_db.dart';
import 'package:karate_stars_app/src/rankings/data/local/ranking_hive_data_source.dart';
import 'package:karate_stars_app/src/rankings/data/ranking_cached_repository.dart';
import 'package:karate_stars_app/src/rankings/data/remote/ranking_api_data_source.dart';
import 'package:karate_stars_app/src/rankings/domain/boundaries/ranking_repository.dart';
import 'package:karate_stars_app/src/rankings/domain/entities/ranking.dart';
import 'package:karate_stars_app/src/rankings/domain/get_ranking_by_id.dart';
import 'package:karate_stars_app/src/rankings/domain/get_rankings.dart';
import 'package:karate_stars_app/src/rankings/presentation/blocs/rankings_bloc.dart';
import 'package:karate_stars_app/src/rankings/presentation/blocs/rankings_categories_bloc.dart';

void initAll(Database database, String apiUrl, Credentials apiCredentials) {
  _initDataDI(database, apiUrl, apiCredentials);

  initBlocAndUseCases();
}

void initBlocAndUseCases() {
  getIt.registerFactory(() => RankingsBloc(getIt(), getIt()));
  getIt.registerFactory(() => RankingCategoriesBloc(getIt(), getIt(), getIt()));

  getIt.registerLazySingleton(() => GetRankingsUseCase(getIt()));
  getIt.registerLazySingleton(() => GetRankingByIdUseCase(getIt()));
}

void _initDataDI(Database database, String apiUrl, Credentials apiCredentials) {
  getIt.registerLazySingleton<ReadableDataSource<Ranking>>(
      () => RankingApiDataSource(apiUrl, apiCredentials, getIt()));

  getIt.registerLazySingleton<Box<RankingDB>>(() => database.rankingsBox);

  getIt.registerLazySingleton<CacheableDataSource<Ranking>>(
      () => RankingHiveDataSource(getIt(), largeCacheTimeMillis));

  getIt.registerLazySingleton<RankingRepository>(
      () => RankingCachedRepository(getIt(), getIt()));
}
