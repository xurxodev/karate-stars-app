import 'package:karate_stars_app/src/common/data/cached_partial_repository.dart';
import 'package:karate_stars_app/src/common/data/local/cacheable_partial_hive_data_source.dart';
import 'package:karate_stars_app/src/common/data/remote/filterable_api_data_source.dart';
import 'package:karate_stars_app/src/rankings/data/local/ranking_entry_db.dart';
import 'package:karate_stars_app/src/rankings/data/ranking_entry_cached_repository.dart';
import 'package:karate_stars_app/src/rankings/domain/entities/rankingEntry.dart';

import '../../../common/mothers/ranking_entries_mother.dart';
import '../../common/data/repositories/common_cached_partial_repository_test.dart';

final filters = {
  'rankingId': wkfRankingKataMaleRank1().rankingId,
  'categoryId': wkfRankingKataMaleRank1().categoryId
};

List<RankingEntry> _localData() {
  return [wkfRankingKataMaleRank1()];
}

List<RankingEntry> _remoteData() {
  return [wkfRankingKataMaleRank1(), wkfRankingKataMaleRank2()];
}

CachedPartialRepository<RankingEntry, RankingEntryDB> repositoryFactory(
    CacheablePartialDataSource<RankingEntry, RankingEntryDB> cache,
    FilterableApiDataSource<RankingEntry> remote) {
  return RankingEntryCachedRepository(cache, remote);
}

void main() {
  executePartialRepositoryTests(repositoryFactory, _localData(), _remoteData(), filters);
}
