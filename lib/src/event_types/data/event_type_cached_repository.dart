import 'package:karate_stars_app/src/common/data/cached_repository.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/event_types/domain/boundaries/event_type_repository.dart';
import 'package:karate_stars_app/src/event_types/domain/entities/event_type.dart';

class EventTypeCachedRepository extends CachedRepository<EventType>
    implements EventTypeRepository {
  EventTypeCachedRepository(CacheableDataSource<EventType> cacheDataSource,
      ReadableDataSource<EventType> remoteDataSource)
      : super(cacheDataSource, remoteDataSource);

  @override
  Future<List<EventType>> getAll(ReadPolicy readPolicy) {
    return super.getAll(readPolicy);
  }
}
