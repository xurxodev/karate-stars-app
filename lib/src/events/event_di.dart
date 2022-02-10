import 'package:hive/hive.dart';
import 'package:karate_stars_app/app_di.dart';
import 'package:karate_stars_app/src/common/auth/credentials.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/local/database.dart';
import 'package:karate_stars_app/src/events/data/event_cached_repository.dart';
import 'package:karate_stars_app/src/events/data/local/event_db.dart';
import 'package:karate_stars_app/src/events/data/local/event_hive_data_source.dart';
import 'package:karate_stars_app/src/events/data/remote/event_api_data_source.dart';
import 'package:karate_stars_app/src/events/domain/boundaries/event_repository.dart';
import 'package:karate_stars_app/src/events/domain/entities/event.dart';
import 'package:karate_stars_app/src/events/domain/get_events.dart';
import 'package:karate_stars_app/src/events/presentation/blocs/events_bloc.dart';

void initAll(Database database, String apiUrl, Credentials apiCredentials) {
  _initDataDI(database, apiUrl, apiCredentials);

  initBlocAndUseCases();
}

void initBlocAndUseCases() {
  getIt.registerFactory(() => EventsBloc(getIt(), getIt(), getIt()));

  getIt.registerLazySingleton(() => GetEventsUseCase(getIt()));
}

void _initDataDI(Database database, String apiUrl, Credentials apiCredentials) {
  getIt.registerLazySingleton<ReadableDataSource<Event>>(
      () => EventApiDataSource(apiUrl, apiCredentials, getIt()));

  getIt.registerLazySingleton<Box<EventDB>>(() => database.eventsBox);

  getIt.registerLazySingleton<CacheableDataSource<Event>>(
      () => EventHiveDataSource(getIt(), largeCacheTimeMillis));

  getIt.registerLazySingleton<EventRepository>(
      () => EventCachedRepository(getIt(), getIt()));
}
