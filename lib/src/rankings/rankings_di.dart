import 'package:hive/hive.dart';
import 'package:karate_stars_app/src/common/auth/credentials.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/local/cacheable_partial_hive_data_source.dart';
import 'package:karate_stars_app/src/common/data/local/database.dart';
import 'package:karate_stars_app/src/common/data/remote/filterable_api_data_source.dart';
import 'package:karate_stars_app/src/global_di.dart';
import 'package:karate_stars_app/src/rankings/data/local/ranking_db.dart';
import 'package:karate_stars_app/src/rankings/data/local/ranking_entry_db.dart';
import 'package:karate_stars_app/src/rankings/data/local/ranking_entry_mapper.dart';
import 'package:karate_stars_app/src/rankings/data/local/ranking_hive_data_source.dart';
import 'package:karate_stars_app/src/rankings/data/ranking_cached_repository.dart';
import 'package:karate_stars_app/src/rankings/data/ranking_entry_cached_repository.dart';
import 'package:karate_stars_app/src/rankings/data/remote/ranking_api_data_source.dart';
import 'package:karate_stars_app/src/rankings/data/remote/ranking_entry_parser.dart';
import 'package:karate_stars_app/src/rankings/domain/boundaries/ranking_entry_repository.dart';
import 'package:karate_stars_app/src/rankings/domain/boundaries/ranking_repository.dart';
import 'package:karate_stars_app/src/rankings/domain/entities/ranking.dart';
import 'package:karate_stars_app/src/rankings/domain/entities/rankingEntry.dart';
import 'package:karate_stars_app/src/rankings/domain/get_ranking_by_id.dart';
import 'package:karate_stars_app/src/rankings/domain/get_ranking_entries.dart';
import 'package:karate_stars_app/src/rankings/domain/get_rankings.dart';
import 'package:karate_stars_app/src/rankings/presentation/blocs/rankings_bloc.dart';
import 'package:karate_stars_app/src/rankings/presentation/blocs/rankings_categories_bloc.dart';
import 'package:karate_stars_app/src/rankings/presentation/blocs/rankings_entries_bloc.dart';

void initAll(Database database, String apiUrl, Credentials apiCredentials) {
  _initDataDI(database, apiUrl, apiCredentials);

  initBlocAndUseCases();
}

void initBlocAndUseCases() {
  getIt.registerFactory(() => RankingsBloc(getIt(), getIt()));
  getIt.registerFactory(() => RankingCategoriesBloc(getIt(), getIt(), getIt()));
  getIt.registerFactory(
      () => RankingEntriesBloc(getIt(), getIt(), getIt(), getIt()));

  getIt.registerLazySingleton(() => GetRankingsUseCase(getIt()));
  getIt.registerLazySingleton(() => GetRankingEntriesUseCase(getIt()));
  getIt.registerLazySingleton(() => GetRankingByIdUseCase(getIt()));
}

void _initDataDI(Database database, String apiUrl, Credentials apiCredentials) {
  getIt.registerLazySingleton<ReadableDataSource<Ranking>>(
      () => RankingApiDataSource(apiUrl, apiCredentials, getIt()));

  getIt.registerLazySingleton<FilterableApiDataSource<RankingEntry>>(() =>
      FilterableApiDataSource(apiUrl, 'ranking-entries', apiCredentials,
          getIt(), RankingEntryParser()));

  getIt.registerLazySingleton<Box<RankingDB>>(() => database.rankingsBox);

  getIt.registerLazySingleton<Box<RankingEntryDB>>(
      () => database.rankingEntriesBox);

  getIt.registerLazySingleton<CacheableDataSource<Ranking>>(
      () => RankingHiveDataSource(getIt(), largeCacheTimeMillis));

  getIt.registerLazySingleton<
          CacheablePartialDataSource<RankingEntry, RankingEntryDB>>(
      () => CacheablePartialDataSource<RankingEntry, RankingEntryDB>(
          getIt(), RankingEntryMapper(), mediumCacheTimeMillis));

  getIt.registerLazySingleton<RankingRepository>(
      () => RankingCachedRepository(getIt(), getIt()));

  getIt.registerLazySingleton<RankingEntryRepository>(
      () => RankingEntryCachedRepository(getIt(), getIt()));
}
