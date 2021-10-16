import 'package:karate_stars_app/app_di.dart';
import 'package:karate_stars_app/src/common/auth/credentials.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/database.dart';
import 'package:karate_stars_app/src/event_types/data/event_type_cached_repository.dart';
import 'package:karate_stars_app/src/event_types/data/local/event_type_in_memory_data_source.dart';
import 'package:karate_stars_app/src/event_types/data/remote/event_type_api_data_source.dart';
import 'package:karate_stars_app/src/event_types/domain/boundaries/event_type_repository.dart';
import 'package:karate_stars_app/src/event_types/domain/entities/event_type.dart';
import 'package:karate_stars_app/src/event_types/domain/get_event_types.dart';

void initAll(
    AppDatabase appDatabase, String apiUrl, Credentials apiCredentials) {
  _initDataDI(appDatabase, apiUrl, apiCredentials);

  initBlocAndUseCases();
}

void initBlocAndUseCases() {
  getIt.registerLazySingleton(() => GetEventTypesUseCase(getIt()));
}

void _initDataDI(
    AppDatabase appDatabase, String apiUrl, Credentials apiCredentials) {
  getIt.registerLazySingleton<ReadableDataSource<EventType>>(
      () => EventTypeApiDataSource(apiUrl, apiCredentials, getIt()));

  getIt.registerLazySingleton<CacheableDataSource<EventType>>(
      () => EventTypeInMemoryDataSource(largeCacheTimeMillis));

  getIt.registerLazySingleton<EventTypeRepository>(
      () => EventTypeCachedRepository(getIt(), getIt()));
}
