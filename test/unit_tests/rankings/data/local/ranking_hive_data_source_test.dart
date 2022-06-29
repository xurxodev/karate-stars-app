import 'package:hive_flutter/hive_flutter.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/rankings/data/local/ranking_db.dart';
import 'package:karate_stars_app/src/rankings/data/local/ranking_hive_data_source.dart';
import 'package:karate_stars_app/src/rankings/data/local/ranking_mapper.dart';
import 'package:karate_stars_app/src/rankings/domain/entities/ranking.dart';
import '../../../../common/mothers/rankings_mother.dart';
import '../../../common/data/local/common_local_data_source_test.dart';

Future<CacheableDataSource<Ranking>> cacheFactory(
    Box<RankingDB> box, int millis) async {
  return RankingHiveDataSource(
      box, Duration(milliseconds: millis).inMilliseconds);
}

void main() {
  executeCacheTests(
      cacheFactory, [wkfRanking(), europeanGamesStanding()], RankingMapper());
}
