import 'package:karate_stars_app/src/news/data/local/current_news_daos.dart';
import 'package:karate_stars_app/src/news/data/local/current_news_models.dart';

/// This fake database exists to testing floor data sources without to use
/// floor (SQLFLite) plugin that require execute tests against a device
class FakeDatabase {
  final CurrentNewsDao currentNewsDao = FakeCurrentNewsDao();
  final CurrentNewsSourcesDao currentNewsSourcesDao =
      FakeCurrentNewsSourcesDao();
}

abstract class FakeDao<T> {
  final List<T> _items = [];

  Future<void> deleteAll() {
    return Future.delayed(
        const Duration(milliseconds: 0), () => _items.clear());
  }

  Future<List<T>> findAll() {
    return Future.delayed(const Duration(milliseconds: 0), () => _items);
  }

  Future<void> insertAll(List<T> items) {
    return Future.delayed(const Duration(milliseconds: 0), () {
      _items.clear();
      _items.addAll(items);
    });
  }
}

class FakeCurrentNewsSourcesDao extends FakeDao<CurrentNewsSourceDB>
    implements CurrentNewsSourcesDao {
  @override
  Future<void> insertAll(List<CurrentNewsSourceDB> items) {
    items = items.asMap().entries.map((entry) {
      final int index = entry.key;
      final CurrentNewsSourceDB item = entry.value;

      return CurrentNewsSourceDB(
          index + 1, item.url, item.name, item.image, item.lastUpdate);
    }).toList();

    return super.insertAll(items);
  }
}

class FakeCurrentNewsDao extends FakeDao<CurrentNewsDB>
    implements CurrentNewsDao {
  @override
  Future<void> insertAll(List<CurrentNewsDB> items) {
    items = items.asMap().entries.map((entry) {
      final int index = entry.key;
      final CurrentNewsDB item = entry.value;

      return CurrentNewsDB(index + 1, item.link, item.title, item.image,
          item.pubDate, item.sourceId, item.lastUpdate);
    }).toList();

    return super.insertAll(items);
  }
}
