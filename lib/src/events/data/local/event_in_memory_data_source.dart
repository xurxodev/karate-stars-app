import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/local/cache_data_source.dart';
import 'package:karate_stars_app/src/events/domain/entities/event.dart';

class EventInMemoryDataSource extends CacheDataSource
    implements CacheableDataSource<Event> {
  final List<Event> _items = [];

  EventInMemoryDataSource(int maxCacheTime) : super(maxCacheTime);

  @override
  Future<List<Event>> getAll() async {
    return _items;
  }

  @override
  Future<void> save(List<Event> items) async {
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
