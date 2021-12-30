import 'package:hive/hive.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/news/data/local/data_sources/social_news_hive_data_source.dart';
import 'package:karate_stars_app/src/news/data/local/mappers/social_news_mapper.dart';
import 'package:karate_stars_app/src/news/data/local/models/social_news_db.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';

import '../../../../common/mothers/social_news_mother.dart';
import '../../../common/data/local/common_local_data_source_test.dart';

Future<CacheableDataSource<SocialNews>> cacheFactory(
    Box<SocialNewsDB> box, int millis) async {
  return SocialNewsHiveDataSource(
      box, Duration(milliseconds: millis).inMilliseconds);
}

void main() {
  executeCacheTests(cacheFactory,
      [newVideoInKarateStars(), countDownMadrid2018()], SocialNewsMapper());
}
