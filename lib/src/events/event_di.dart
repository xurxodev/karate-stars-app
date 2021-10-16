import 'package:karate_stars_app/app_di.dart';
import 'package:karate_stars_app/src/common/auth/credentials.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/database.dart';
import 'package:karate_stars_app/src/events/data/event_cached_repository.dart';
import 'package:karate_stars_app/src/events/data/local/event_in_memory_data_source.dart';
import 'package:karate_stars_app/src/events/data/remote/event_api_data_source.dart';
import 'package:karate_stars_app/src/events/domain/boundaries/event_repository.dart';
import 'package:karate_stars_app/src/events/domain/entities/event.dart';
import 'package:karate_stars_app/src/events/domain/get_events.dart';

void initAll(
    AppDatabase appDatabase, String apiUrl, Credentials apiCredentials) {
  _initDataDI(appDatabase, apiUrl, apiCredentials);

  initBlocAndUseCases();
}

void initBlocAndUseCases() {
  getIt.registerLazySingleton(() => GetEventsUseCase(getIt()));
}

void _initDataDI(
    AppDatabase appDatabase, String apiUrl, Credentials apiCredentials) {
  getIt.registerLazySingleton<ReadableDataSource<Event>>(
      () => EventApiDataSource(apiUrl, apiCredentials, getIt()));

  getIt.registerLazySingleton<CacheableDataSource<Event>>(
      () => EventInMemoryDataSource(largeCacheTimeMillis));

  getIt.registerLazySingleton<EventRepository>(
      () => EventCachedRepository(getIt(), getIt()));
}
