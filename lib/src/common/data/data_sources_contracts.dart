abstract class ReadableDataSource<T> {
  Future<List<T>> getAll();
}

abstract class CacheableDataSource<T> implements ReadableDataSource<T> {
  Future<void> save(List<T> items);

  Future<bool> areValidValues();

  Future<void> invalidate();
}
