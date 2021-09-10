import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/news/data/repositories/social_news_cached_repository.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';
import '../../../../common/mothers/social_news_mother.dart';
import '../../../common/repositories/common_cached_repository_test.dart';

List<SocialNews> _localNews() {
  return [SocialNewsMother.countDownMadrid2018()];
}

List<SocialNews> _remoteNews() {
  return [
    SocialNewsMother.countDownMadrid2018(),
    SocialNewsMother.newVideoInKarateStars()
  ];
}

SocialNewsCachedRepository repositoryFactory(CacheableDataSource<SocialNews> cache, ReadableDataSource<SocialNews> remote){
  return SocialNewsCachedRepository(cache, remote);
}

void main() {
  executeRepositoryTests(repositoryFactory, _localNews(), _remoteNews());
}