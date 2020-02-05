import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:karate_stars_app/src/news/data/local/current_news_floor_data_source.dart';

import 'fake/current_news_mother.dart';
import 'fake/fake_database.dart';

void main() {
  group('CurrentNewsFloorDataSource should', () {
    test('return empty news list first time', () async {
      final cache = givenACacheWithoutData();

      final currentNews = await cache.getAll();

      expect(currentNews.length, 0);
    });
    test('returns equal data after to refresh', () async {
      final cache = givenACacheWithoutData();

      final currentNewsToSave = [
        CurrentNewsMother.madridHost2018(),
        CurrentNewsMother.quinteroNumber1()
      ];

      await cache.save(currentNewsToSave);

      final savedCurrentNews = await cache.getAll();

      expect(savedCurrentNews, currentNewsToSave);
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

      final currentNews = await cache.getAll();

      expect(currentNews, []);
    });
  });
}

Future<CurrentNewsFloorDataSource> givenACacheWithData([int millis]) async {
  final currentNewsCache = givenACacheWithoutData(millis);

  await currentNewsCache.save([
    CurrentNewsMother.quinteroNumber1(),
    CurrentNewsMother.madridHost2018()
  ]);

  return currentNewsCache;
}

CurrentNewsFloorDataSource givenACacheWithoutData([int millis = 100]) {
  final appDatabase = FakeDatabase();

  final currentNewsDao = appDatabase.currentNewsDao;
  final currentNewsSourcesDao = appDatabase.currentNewsSourcesDao;

  return CurrentNewsFloorDataSource(currentNewsDao, currentNewsSourcesDao,
      Duration(milliseconds: millis).inMilliseconds);
}
