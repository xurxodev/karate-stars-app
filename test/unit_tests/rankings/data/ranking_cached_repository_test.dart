import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/rankings/data/ranking_cached_repository.dart';
import 'package:karate_stars_app/src/rankings/domain/entities/ranking.dart';

import '../../../common/mothers/rankings_mother.dart';
import '../../common/data/repositories/common_cached_repository_test.dart';

List<Ranking> _localData() {
  return [wkfRanking()];
}

List<Ranking> _remoteData() {
  return [wkfRanking(), europeanGamesStanding()];
}

RankingCachedRepository repositoryFactory(
    CacheableDataSource<Ranking> cache, ReadableDataSource<Ranking> remote) {
  return RankingCachedRepository(cache, remote);
}

void main() {
  executeRepositoryTests(repositoryFactory, _localData(), _remoteData());
}
