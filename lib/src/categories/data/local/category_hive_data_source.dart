import 'package:hive/hive.dart';
import 'package:karate_stars_app/src/categories/data/local/category_db.dart';
import 'package:karate_stars_app/src/categories/data/local/category_mapper.dart';
import 'package:karate_stars_app/src/categories/domain/entities/category.dart'
    as category;
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/local/cache_data_source.dart';

class CategoryHiveDataSource extends CacheDataSource
    implements CacheableDataSource<category.Category> {
  final Box<CategoryDB> _box;
  final _mapper = CategoryMapper();

  CategoryHiveDataSource(this._box, int maxCacheTime) : super(maxCacheTime);

  @override
  Future<List<category.Category>> getAll() async {
    return _box.values.map(_mapper.mapToDomain).toList();
  }

  @override
  Future<void> save(List<category.Category> entities) async {
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
