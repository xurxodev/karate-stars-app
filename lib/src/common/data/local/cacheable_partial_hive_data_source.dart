import 'package:hive/hive.dart';
import 'package:karate_stars_app/src/common/data/local/DataBaseMapper.dart';
import 'package:karate_stars_app/src/common/data/local/cache_data_source.dart';
import 'package:karate_stars_app/src/common/domain/types.dart';

class CacheablePartialDataSource<Entity extends Identifiable,
    ModelDB extends CacheablePartialModelDB> {
  final Box<ModelDB> _box;
  final int _maxCacheTime;
  final DataBaseMapper<Entity, ModelDB> _mapper;

  CacheablePartialDataSource(this._box, this._mapper, this._maxCacheTime);

  Future<List<Entity>> getByFilters(Map<String, dynamic> filters) async {
    final modelDBs = _box.values.where((modelDB) {
      final modelMap = modelDB.toMap();

      return filters.keys.every((prop) => modelMap[prop] == filters[prop]);
    }).toList();

    return modelDBs.map(_mapper.mapToDomain).toList();
  }

  Future<void> save(List<Entity> entities) async {
    await _box.addAll(entities.map(_mapper.mapToDB));
  }

  Future<bool> areValidValues(List<Entity> entities) async {
    final entityIds = entities.map((entity) => entity.id).toList();
    final modelDBs =
        _box.values.where((modelDB) => entityIds.contains(modelDB.id)).toList();

    return !_areDirty(modelDBs);
  }

  Future<void> invalidate(List<Entity> entities) async {
    final entityIds = entities.map((entity) => entity.id).toList();
    final modelsToMaintain = _box.values
        .where((modelDB) => !entityIds.contains(modelDB.id)).toList();

    _box.clear();

    _box.addAll(modelsToMaintain);
  }

  bool _areDirty(List<ModelDB> models) {
    return models.any((model) => _isDirty(model));
  }

  bool _isDirty(ModelDB model) {
    final int lastCacheUpdateMillis =
        DateTime.parse(model.lastUpdate).millisecondsSinceEpoch;

    final int currentMillis = DateTime.now().millisecondsSinceEpoch;

    final bool isDirty = currentMillis - lastCacheUpdateMillis > _maxCacheTime;

    return isDirty;
  }
}
