import 'package:karate_stars_app/src/common/data/cached_repository.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/events/domain/boundaries/event_repository.dart';
import 'package:karate_stars_app/src/events/domain/entities/event.dart';

class EventCachedRepository extends CachedRepository<Event>
    implements EventRepository {
  EventCachedRepository(CacheableDataSource<Event> cacheDataSource,
      ReadableDataSource<Event> remoteDataSource)
      : super(cacheDataSource, remoteDataSource);

  @override
  Future<List<Event>> getAll(ReadPolicy readPolicy) {
    return super.getAll(readPolicy);
  }
}
