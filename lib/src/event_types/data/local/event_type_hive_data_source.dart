import 'package:hive/hive.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/local/cache_data_source.dart';
import 'package:karate_stars_app/src/event_types/data/local/event_type_db.dart';
import 'package:karate_stars_app/src/event_types/data/local/event_type_mapper.dart';
import 'package:karate_stars_app/src/event_types/domain/entities/event_type.dart';

class EventTypeHiveDataSource extends CacheDataSource
    implements CacheableDataSource<EventType> {
  final Box<EventTypeDB> _box;
  final _mapper = EventTypeMapper();

  EventTypeHiveDataSource(this._box, int maxCacheTime) : super(maxCacheTime);

  @override
  Future<List<EventType>> getAll() async {
    return _box.values.map(_mapper.mapToDomain).toList();
  }

  @override
  Future<void> save(List<EventType> entities) async {
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
