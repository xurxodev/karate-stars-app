import 'package:hive/hive.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/local/cache_data_source.dart';
import 'package:karate_stars_app/src/events/data/local/event_db.dart';
import 'package:karate_stars_app/src/events/data/local/event_mapper.dart';
import 'package:karate_stars_app/src/events/domain/entities/event.dart';

class EventHiveDataSource extends CacheDataSource
    implements CacheableDataSource<Event> {
  final Box<EventDB> _box;
  final _mapper = EventMapper();

  EventHiveDataSource(this._box, int maxCacheTime) : super(maxCacheTime);

  @override
  Future<List<Event>> getAll() async {
    return _box.values.map(_mapper.mapToDomain).toList();
  }

  @override
  Future<void> save(List<Event> entities) async {
    await _box.addAll(entities.map(_mapper.mapToDB));
  }

  @override
  Future<bool> areValidValues() async {
    return !super.areDirty(_box.values.toList());
  }

  @override
  Future<void> invalidate() async {
    _box.clear();
  }
}
