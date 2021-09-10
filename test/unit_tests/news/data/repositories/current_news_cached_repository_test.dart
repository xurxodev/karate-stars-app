import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/news/data/repositories/current_news_cached_repository.dart';
import 'package:karate_stars_app/src/news/domain/entities/current.dart';

import '../../../../common/mothers/current_news_mother.dart';
import '../../../common/data/local/repositories/common_cached_repository_test.dart';

List<CurrentNews> _localData() {
  return [CurrentNewsMother.madridHost2018()];
}

List<CurrentNews> _remoteData() {
  return [
    CurrentNewsMother.madridHost2018(),
    CurrentNewsMother.quinteroNumber1(),
    CurrentNewsMother.stevenDaCostaVideo()
  ];
}

CurrentNewsCachedRepository repositoryFactory(CacheableDataSource<CurrentNews> cache, ReadableDataSource<CurrentNews> remote){
  return CurrentNewsCachedRepository(cache, remote);
}

void main() {
  executeRepositoryTests(repositoryFactory, _localData(), _remoteData());
}