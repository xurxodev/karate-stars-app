import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';

void executeCacheTests<T>(Function(int millis) cacheFactory, List<T> data) {
  CacheableDataSource<T> givenACacheWithoutData([int millis = 100]) {
    return cacheFactory(millis);
  }

  Future<CacheableDataSource<T>> givenACacheWithData([int millis = 100]) async {
    final currentNewsCache = givenACacheWithoutData(millis);

    await currentNewsCache.save(data);

    return currentNewsCache;
  }

  group('local data source should', () {
    test('return empty news list first time', () async {
      final cache = givenACacheWithoutData();

      final currentData = await cache.getAll();

      expect(currentData.length, 0);
    });
    test('returns equal data after to refresh', () async {
      final cache = givenACacheWithoutData();

      await cache.save(data);

      final savedData = await cache.getAll();

      expect(savedData, data);
    });
    test('return are valid values equal to true if cache is not dirty',
        () async {
      final cache = await givenACacheWithData(200);

      sleep(const Duration(milliseconds: 100));

      expect(await cache.areValidValues(), true);
    });
    test('return are  valid values equal to false if cache is  dirty',
        () async {
      final cache = await givenACacheWithData(100);

      sleep(const Duration(milliseconds: 200));

      expect(await cache.areValidValues(), false);
    });
    test('return empty list if cache is invalidated', () async {
      final cache = await givenACacheWithData(100);

      cache.invalidate();

      final currentData = await cache.getAll();

      expect(currentData, []);
    });
  });
}

// To avoid method main not found
void main() {
}
