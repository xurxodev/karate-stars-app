abstract class ReadableDataSource<T> {
  Future<List<T>> getAll();
}

abstract class CacheDataSource<T> implements ReadableDataSource<T> {
  void save(List<T> items);

  bool areValidValues();

  void invalidate();
}
