import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/database.dart';
import 'package:karate_stars_app/src/news/data/local/current_news_floor_data_source.dart';
import 'package:karate_stars_app/src/news/domain/entities/current.dart';

import '../../../../common/mothers/current_news_mother.dart';
import '../../../common/data/local/common_local_data_source_test.dart';

Future<CacheableDataSource<CurrentNews>> cacheFactory(int millis) async {
  final appDatabase =  await $FloorAppDatabase.inMemoryDatabaseBuilder().build();

  // Delete data because its a unique instance database for all tests
  final currentNewsDao = appDatabase.currentNewsDao..deleteAll();
  final currentNewsSourcesDao = appDatabase.currentNewsSourcesDao..deleteAll();

  return CurrentNewsFloorDataSource(currentNewsDao, currentNewsSourcesDao,
      Duration(milliseconds: millis).inMilliseconds);
}

void main() {
  executeCacheTests(cacheFactory, [quinteroNumber1(), madridHost2018()]);
}
