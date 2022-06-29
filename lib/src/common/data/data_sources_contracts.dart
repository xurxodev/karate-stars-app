abstract class ReadableDataSource<T> {
  Future<List<T>> getAll();
}

abstract class FilterableReadableDataSource<T> {
  Future<List<T>> getByFilters(Map<String, dynamic> filters);
}

abstract class CacheableDataSource<T> implements ReadableDataSource<T> {
  Future<void> save(List<T> items);

  Future<bool> areValidValues();

  Future<void> invalidate();
}
