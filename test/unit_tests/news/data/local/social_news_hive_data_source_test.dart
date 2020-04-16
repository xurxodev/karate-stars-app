import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:karate_stars_app/src/news/data/local/models/social_news_db.dart';
import 'package:karate_stars_app/src/news/data/local/data_sources/social_news_hive_data_source.dart';

import '../../../../common/mothers/social_news_mother.dart';

void main() {
  group('SocialNewsHiveDataSource should', () {
    test('return empty news list first time', () async {
      final cache = await givenACacheWithoutData();

      final currentNews = await cache.getAll();

      expect(currentNews.length, 0);
    });
    test('returns equal data after to refresh', () async {
      final cache = await givenACacheWithoutData();

      final socialNewsToSave = [
        SocialNewsMother.newVideoInKarateStars(),
        SocialNewsMother.countDownMadrid2018()
      ];

      await cache.save(socialNewsToSave);

      final savedCurrentNews = await cache.getAll();

      expect(savedCurrentNews, socialNewsToSave);
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

Future<SocialNewsHiveDataSource> givenACacheWithData([int millis]) async {
  final currentNewsCache = await givenACacheWithoutData(millis);

  await currentNewsCache.save([
    SocialNewsMother.newVideoInKarateStars(),
    SocialNewsMother.countDownMadrid2018()
  ]);

  return currentNewsCache;
}

Future<SocialNewsHiveDataSource> givenACacheWithoutData(
    [int millis = 100]) async {
  final socialNewsBox = await Hive.openBox<SocialNewsDB>(
      //assign a unique name for every test to avoid hive box singleton
      DateTime.now().millisecondsSinceEpoch.toString(),
      bytes: Uint8List(0));

  return SocialNewsHiveDataSource(
      socialNewsBox, Duration(milliseconds: millis).inMilliseconds);
}
