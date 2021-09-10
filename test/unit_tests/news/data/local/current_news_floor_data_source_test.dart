import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/news/data/local/current_news_floor_data_source.dart';
import 'package:karate_stars_app/src/news/domain/entities/current.dart';

import '../../../../common/mothers/current_news_mother.dart';
import '../../../common/data/local/common_local_data_source_test.dart';
import 'fake/fake_database.dart';

CacheableDataSource<CurrentNews> cacheFactory(int millis) {
  final appDatabase = FakeDatabase();

  final currentNewsDao = appDatabase.currentNewsDao;
  final currentNewsSourcesDao = appDatabase.currentNewsSourcesDao;

  return CurrentNewsFloorDataSource(currentNewsDao, currentNewsSourcesDao,
      Duration(milliseconds: millis).inMilliseconds);
}

void main() {
  executeCacheTests(cacheFactory, [
    CurrentNewsMother.quinteroNumber1(),
    CurrentNewsMother.madridHost2018()
  ]);
}
