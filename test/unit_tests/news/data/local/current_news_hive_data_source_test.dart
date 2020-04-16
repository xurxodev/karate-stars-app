import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:karate_stars_app/src/news/data/local/data_sources/current_news_hive_data_source.dart';
import 'package:karate_stars_app/src/news/data/local/models/current_news_db.dart';

import '../../../../common/mothers/current_news_mother.dart';

void main() {
  group('CurrentNewsHiveDataSource should', () {
    test('return empty news list first time', () async {
      final cache = await givenACacheWithoutData();

      final currentNews = await cache.getAll();

      expect(currentNews.length, 0);
    });
    test('returns equal data after to refresh', () async {
      final cache = await givenACacheWithoutData();

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

      await cache.invalidate();

      final currentNews = await cache.getAll();

      expect(currentNews, []);
    });
  });
}

Future<CurrentNewsHiveDataSource> givenACacheWithData([int millis]) async {
  final currentNewsCache = await givenACacheWithoutData(millis);

  await currentNewsCache.save([
    CurrentNewsMother.quinteroNumber1(),
    CurrentNewsMother.madridHost2018()
  ]);

  return currentNewsCache;
}

Future<CurrentNewsHiveDataSource> givenACacheWithoutData(
    [int millis = 100]) async {
  final currentNewsBox = await Hive.openBox<CurrentNewsDB>(
      //assign a unique name for every test to avoid hive box singleton
      DateTime.now().millisecondsSinceEpoch.toString(),
      bytes: Uint8List(0));

  return CurrentNewsHiveDataSource(
      currentNewsBox, Duration(milliseconds: millis).inMilliseconds);
}
