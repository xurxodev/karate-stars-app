import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';

class CachedRepository<T> {
  CacheableDataSource<T> cache;
  ReadableDataSource<T> remoteDataSource;

  CachedRepository(this.cache, this.remoteDataSource);

  Future<List<T>> getAll(ReadPolicy readPolicy) {
    if (readPolicy == ReadPolicy.cache_first) {
      return getAllCacheFirst();
    } else if (readPolicy == ReadPolicy.network_first) {
      return getAllNetworkFirst();
    } else {
      return getAllOnlyCache();
    }
  }

  Future<List<T>> getAllCacheFirst() async {
    List<T> items = await cache.getAll();

    if (items.isEmpty || !await cache.areValidValues()) {
      try {
        items = await remoteDataSource.getAll();

        if (items.isNotEmpty) {
          await cache.invalidate();
          await cache.save(items);
        }
      } on Exception {
        if (items.isEmpty) {
          rethrow;
        }
      }
    }

    return items;
  }

  Future<List<T>> getAllNetworkFirst() async {
    List<T> items;

    try {
      items = await remoteDataSource.getAll();

      if (items.isNotEmpty) {
        await cache.invalidate();
        await cache.save(items);
      }
    } on Exception {
      items = await cache.getAll();

      if (items.isEmpty) {
        rethrow;
      }
    }

    return items;
  }

  Future<List<T>> getAllOnlyCache() {
    return cache.getAll();
  }
}
