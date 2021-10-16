import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/local/cache_data_source.dart';
import 'package:karate_stars_app/src/event_types/domain/entities/event_type.dart';

class EventTypeInMemoryDataSource extends CacheDataSource
    implements CacheableDataSource<EventType> {
  final List<EventType> _items = [];

  EventTypeInMemoryDataSource(int maxCacheTime) : super(maxCacheTime);

  @override
  Future<List<EventType>> getAll() async {
    return _items;
  }

  @override
  Future<void> save(List<EventType> items) async {
    _items.addAll(items);
  }

  @override
  Future<bool> areValidValues() async {
    return true;
  }

  @override
  Future<void> invalidate() async {
    _items.clear();
  }
}
