
import 'package:karate_stars_app/src/category_types/domain/entities/category_type.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/local/cache_data_source.dart';

class CategoryTypeInMemoryDataSource extends CacheDataSource
    implements CacheableDataSource<CategoryType> {
  final List<CategoryType> _items = [];

  CategoryTypeInMemoryDataSource(int maxCacheTime) : super(maxCacheTime);

  @override
  Future<List<CategoryType>> getAll() async {
    return _items;
  }

  @override
  Future<void> save(List<CategoryType> items) async {
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
