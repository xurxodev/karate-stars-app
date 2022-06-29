import 'package:karate_stars_app/src/common/data/local/cache_data_source.dart';
import 'package:karate_stars_app/src/common/data/local/cacheable_partial_hive_data_source.dart';
import 'package:karate_stars_app/src/common/data/remote/filterable_api_data_source.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/common/domain/types.dart';

class CachedPartialRepository<Entity extends Identifiable,
ModelDB extends CacheablePartialModelDB> {
  CacheablePartialDataSource<Entity,ModelDB> cache;
  FilterableApiDataSource<Entity> remoteDataSource;

  CachedPartialRepository(this.cache, this.remoteDataSource);

  Future<List<Entity>> getByFilters(ReadPolicy readPolicy, Map<String, dynamic> filters) {
    if (readPolicy == ReadPolicy.cache_first) {
      return getAllCacheFirst(filters);
    } else if (readPolicy == ReadPolicy.network_first) {
      return getAllNetworkFirst(filters);
    } else {
      return getAllOnlyCache(filters);
    }
  }

  Future<List<Entity>> getAllCacheFirst(Map<String, dynamic> filters) async {
    List<Entity> items = await cache.getByFilters(filters);

    if (items.isEmpty || !await cache.areValidValues(items)) {
      try {
        items = await remoteDataSource.getByFilters(filters);

        if (items.isNotEmpty) {
          await cache.invalidate(items);
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

  Future<List<Entity>> getAllNetworkFirst(Map<String, dynamic> filters) async {
    List<Entity> items;

    try {
      items = await remoteDataSource.getByFilters(filters);

      if (items.isNotEmpty) {
        await cache.invalidate(items);
        await cache.save(items);
      }
    } on Exception {
      items = await cache.getByFilters(filters);

      if (items.isEmpty) {
        rethrow;
      }
    }

    return items;
  }

  Future<List<Entity>> getAllOnlyCache(Map<String, dynamic> filters) {
    return cache.getByFilters(filters);
  }
}
