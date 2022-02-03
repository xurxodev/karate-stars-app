import 'package:hive_flutter/hive_flutter.dart';

import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/competitors/data/local/competitor_hive_data_source.dart';
import 'package:karate_stars_app/src/competitors/data/local/competitor_mapper.dart';
import 'package:karate_stars_app/src/competitors/data/local/models/competitor_db.dart';
import 'package:karate_stars_app/src/competitors/domain/entities/competitor.dart';

import '../../../../common/mothers/competitor_mother.dart';
import '../../../common/data/local/common_local_data_source_test.dart';

Future<CacheableDataSource<Competitor>> cacheFactory(
    Box<CompetitorDB> box, int millis) async {
  return CompetitorHiveDataSource(
      box, Duration(milliseconds: millis).inMilliseconds);
}

void main() {
  executeCacheTests(
      cacheFactory, [stevenDaCosta(), joseEgea(), damianQuintero(), burakUygur()], CompetitorMapper());
}
