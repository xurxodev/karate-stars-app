import 'package:karate_stars_app/src/categories/domain/entities/category.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/local/cache_data_source.dart';

class CategoryInMemoryDataSource extends CacheDataSource
    implements CacheableDataSource<Category> {
  final List<Category> _items = [];

  CategoryInMemoryDataSource(int maxCacheTime) : super(maxCacheTime);

  @override
  Future<List<Category>> getAll() async {
    return _items;
  }

  @override
  Future<void> save(List<Category> items) async {
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
