abstract class ModelDB {
  final String lastUpdate;

  ModelDB(this.lastUpdate);
}

abstract class CacheDataSource<T> {
  final int _maxCacheTime;

  CacheDataSource(this._maxCacheTime);

  bool areDirty(List<ModelDB> models) {
    return models.any((model) => isDirty(model));
  }

  bool isDirty(ModelDB model) {
    final int lastCacheUpdateMillis =
        DateTime.parse(model.lastUpdate).millisecondsSinceEpoch;

    final int currentMillis = DateTime.now().millisecondsSinceEpoch;

    final bool isDirty = currentMillis - lastCacheUpdateMillis > _maxCacheTime;

    return isDirty;
  }
}
