import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/local/DataBaseMapper.dart';

import '../../../../common/in_memory_box.dart';

void executeCacheTests<Entity, ModelDB>(
    Function(Box<ModelDB> box, int millis) cacheFactory,
    List<Entity> data,
    DataBaseMapper<Entity, ModelDB> mapper) {
  Future<CacheableDataSource<Entity>> givenACacheWithoutData(
      [int millis = 100]) {
    final box = InMemoryBox<ModelDB>([]);

    return cacheFactory(box, millis);
  }

  Future<CacheableDataSource<Entity>> givenACacheWithData(
      [int millis = 100]) async {
    final dataDB = data.map((entity) => mapper.mapToDB(entity)).toList();

    final _box = InMemoryBox<ModelDB>(dataDB);

    return cacheFactory(_box, millis);
  }

  group('local data source should', () {
    test('return empty news list first time', () async {
      final cache = await givenACacheWithoutData();

      final currentData = await cache.getAll();

      expect(currentData.length, 0);
    });
    test('returns equal data after to refresh', () async {
      final cache = await givenACacheWithoutData();

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

      await cache.invalidate();

      final currentData = await cache.getAll();

      expect(currentData, []);
    });
  });
}

// To avoid method main not found
void main() {}
