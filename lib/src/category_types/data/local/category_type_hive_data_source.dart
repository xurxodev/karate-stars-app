import 'package:hive/hive.dart';
import 'package:karate_stars_app/src/category_types/data/local/category_type_db.dart';
import 'package:karate_stars_app/src/category_types/data/local/category_type_mapper.dart';
import 'package:karate_stars_app/src/category_types/domain/entities/category_type.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/local/cache_data_source.dart';

class CategoryTypeHiveDataSource extends CacheDataSource
    implements CacheableDataSource<CategoryType> {
  final Box<CategoryTypeDB> _box;
  final _mapper = CategoryTypeMapper();

  CategoryTypeHiveDataSource(this._box, int maxCacheTime) : super(maxCacheTime);

  @override
  Future<List<CategoryType>> getAll() async {
    return _box.values.map(_mapper.mapToDomain).toList();
  }

  @override
  Future<void> save(List<CategoryType> entities) async {
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
