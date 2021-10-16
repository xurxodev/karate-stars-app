import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/database.dart';
import 'package:karate_stars_app/src/news/data/local/social_news_floor_data_source.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';

import '../../../../common/mothers/social_news_mother.dart';
import '../../../common/data/local/common_local_data_source_test.dart';

Future<CacheableDataSource<SocialNews>> cacheFactory(int millis) async {
  final appDatabase = await $FloorAppDatabase.inMemoryDatabaseBuilder().build();

  // Delete data because its a unique instance database for all tests
  final socialNewsDao = appDatabase.socialNewsDao..deleteAll();
  final socialUsersDao = appDatabase.socialUsersDao..deleteAll();

  return SocialNewsFloorDataSource(socialNewsDao, socialUsersDao,
      Duration(milliseconds: millis).inMilliseconds);
}

void main() {
  executeCacheTests(
      cacheFactory, [newVideoInKarateStars(), countDownMadrid2018()]);
}
