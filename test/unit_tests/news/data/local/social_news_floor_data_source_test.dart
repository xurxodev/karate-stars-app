import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/news/data/local/social_news_floor_data_source.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';

import '../../../../common/mothers/social_news_mother.dart';
import '../../../common/data/local/common_local_data_source_test.dart';
import 'fake/fake_database.dart';

CacheableDataSource<SocialNews> cacheFactory(int millis) {
  final appDatabase = FakeDatabase();

  final socialNewsDao = appDatabase.socialNewsDao;
  final socialUsersDao = appDatabase.socialUsersDao;

  return SocialNewsFloorDataSource(socialUsersDao, socialNewsDao,
      Duration(milliseconds: millis).inMilliseconds);
}

void main() {
  executeCacheTests(cacheFactory, [
    SocialNewsMother.newVideoInKarateStars(),
    SocialNewsMother.countDownMadrid2018()
  ]);
}
