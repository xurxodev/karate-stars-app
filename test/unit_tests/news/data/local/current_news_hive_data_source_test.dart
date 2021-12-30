import 'package:hive_flutter/hive_flutter.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/news/data/local/data_sources/current_news_hive_data_source.dart';
import 'package:karate_stars_app/src/news/data/local/mappers/current_news_mapper.dart';
import 'package:karate_stars_app/src/news/data/local/models/current_news_db.dart';
import 'package:karate_stars_app/src/news/domain/entities/current.dart';

import '../../../../common/mothers/current_news_mother.dart';
import '../../../common/data/local/common_local_data_source_test.dart';

Future<CacheableDataSource<CurrentNews>> cacheFactory(
    Box<CurrentNewsDB> box, int millis) async {
  return CurrentNewsHiveDataSource(
      box, Duration(milliseconds: millis).inMilliseconds);
}

void main() {
  executeCacheTests(
      cacheFactory, [quinteroNumber1(), madridHost2018()], CurrentNewsMapper());
}
