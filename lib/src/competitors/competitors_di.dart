import 'package:karate_stars_app/app_di.dart';
import 'package:karate_stars_app/src/common/auth/credentials.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/competitors/data/competitor_cached_repository.dart';
import 'package:karate_stars_app/src/competitors/data/local/competitors_in_memory_data_source.dart';
import 'package:karate_stars_app/src/competitors/data/remote/competitor_api_data_source.dart';
import 'package:karate_stars_app/src/competitors/domain/boundaries/competitor_repository.dart';
import 'package:karate_stars_app/src/competitors/domain/entities/competitor.dart';
import 'package:karate_stars_app/src/competitors/domain/get_competitor_by_id_use_case.dart';
import 'package:karate_stars_app/src/competitors/domain/get_competitors_use_case.dart';
import 'package:karate_stars_app/src/competitors/presentation/blocs/competitor_detail_bloc.dart';
import 'package:karate_stars_app/src/competitors/presentation/blocs/competitors_bloc.dart';

void initAll(String apiUrl, Credentials apiCredentials) {
  _initDataDI(apiUrl, apiCredentials);

  initBlocAndUseCases();
}

void initBlocAndUseCases() {
  getIt.registerFactory(
      () => CompetitorsBloc(getIt(), getIt(), getIt(), getIt(), getIt()));
  getIt.registerFactory(
      () => CompetitorDetailBloc(getIt(), getIt(), getIt(), getIt(), getIt()));

  getIt.registerLazySingleton(() => GetCompetitorsUseCase(getIt(), getIt()));
  getIt.registerLazySingleton(() => GetCompetitorByIdUseCase(getIt()));
}

void _initDataDI(String apiUrl, Credentials apiCredentials) {
  getIt.registerLazySingleton<ReadableDataSource<Competitor>>(
      () => CompetitorApiDataSource(apiUrl, apiCredentials, getIt()));

  getIt.registerLazySingleton<CacheableDataSource<Competitor>>(
      () => CompetitorInMemoryDataSource(largeCacheTimeMillis));

  getIt.registerLazySingleton<CompetitorRepository>(
      () => CompetitorCachedRepository(getIt(), getIt()));
}
