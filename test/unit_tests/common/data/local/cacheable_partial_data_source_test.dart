import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:karate_stars_app/src/common/data/local/cacheable_partial_hive_data_source.dart';

import '../../../../common/in_memory_box.dart';
import '../../../../common/mothers/test_mother.dart';
import '../../domain/entities/TestEntity.dart';
import 'TestMapper.dart';
import 'TestModelDB.dart';

final allData = [testEntity1(), testEntity2(),testEntity3(),testEntity4()];
final partialData1 = [testEntity1(), testEntity2()];
final partialData2 = [testEntity3(),testEntity4()];

final filters1 = {
  'relatedId1': testEntity1().relatedId1,
  'relatedId2': testEntity1().relatedId2
};

final filters2 = {
  'relatedId1': testEntity3().relatedId1,
  'relatedId2': testEntity3().relatedId2
};

void main() {
  group('local data source should', () {
    test('return empty news list first time', () async {
      final cache = await givenACacheWithoutData();

      final currentData = await cache.getByFilters(filters1);

      expect(currentData.length, 0);
    });
    test('returns equal data after to refresh', () async {
      final cache = await givenACacheWithoutData();

      await cache.save(allData);

      final savedData = await cache.getByFilters(filters1);

      expect(savedData, partialData1);
    });
    test('return are valid values equal to true if cache is not dirty',
        () async {
      final cache = await givenACacheWithData(500);

      sleep(const Duration(milliseconds: 100));

      final partial = await cache.getByFilters(filters1);

      expect(await cache.areValidValues(partial), true);
    });
    test('return are valid values equal to false if cache is  dirty', () async {
      final cache = await givenACacheWithData(100);

      sleep(const Duration(milliseconds: 200));

      final partial = await cache.getByFilters(filters1);

      expect(await cache.areValidValues(partial), false);
    });
    test('return empty list if cache is invalidated', () async {
      final cache = await givenACacheWithData(100);

      final partial = await cache.getByFilters(filters1);

      await cache.invalidate(partial);

      final expectedEmptyData = await cache.getByFilters(filters1);

      expect(expectedEmptyData, []);

      final restData = await cache.getByFilters(filters2);

      expect(restData, partialData2);
    });
  });
}

Future<CacheablePartialDataSource<TestEntity, TestModelDB>> givenACacheWithoutData(
    [int millis = 100]) async {
  final box =  InMemoryBox<TestModelDB>([]);

  return CacheablePartialDataSource(
      box, TestMapper(), Duration(milliseconds: millis).inMilliseconds);
}

Future<CacheablePartialDataSource<TestEntity, TestModelDB>> givenACacheWithData(
    [int millis = 100]) async {
  final mapper = TestMapper();
  final dataDB = allData.map((entity) => mapper.mapToDB(entity)).toList();

  final box =  InMemoryBox<TestModelDB>(dataDB);

  return CacheablePartialDataSource(
      box, mapper, Duration(milliseconds: millis).inMilliseconds);
}
