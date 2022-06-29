import 'package:karate_stars_app/src/common/data/cached_partial_repository.dart';
import 'package:karate_stars_app/src/common/data/local/cacheable_partial_hive_data_source.dart';
import 'package:karate_stars_app/src/common/data/remote/filterable_api_data_source.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/rankings/data/local/ranking_entry_db.dart';
import 'package:karate_stars_app/src/rankings/domain/boundaries/ranking_entry_repository.dart';
import 'package:karate_stars_app/src/rankings/domain/entities/rankingEntry.dart';

class RankingEntryCachedRepository
    extends CachedPartialRepository<RankingEntry, RankingEntryDB>
    implements RankingEntryRepository {
  RankingEntryCachedRepository(
      CacheablePartialDataSource<RankingEntry, RankingEntryDB> cacheDataSource,
      FilterableApiDataSource<RankingEntry> remoteDataSource)
      : super(cacheDataSource, remoteDataSource);

  @override
  Future<List<RankingEntry>> getByRankingAndCategory(
      ReadPolicy readPolicy, String rankingId, String categoryId) {
    final filters = {'rankingId': rankingId, 'categoryId': categoryId};
    return super.getByFilters(readPolicy, filters);
  }
}
