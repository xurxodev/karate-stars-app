import 'package:karate_stars_app/src/common/data/cached_repository.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/rankings/domain/boundaries/ranking_repository.dart';
import 'package:karate_stars_app/src/rankings/domain/entities/ranking.dart';

class RankingCachedRepository extends CachedRepository<Ranking>
    implements RankingRepository {
  RankingCachedRepository(CacheableDataSource<Ranking> cacheDataSource,
      ReadableDataSource<Ranking> remoteDataSource)
      : super(cacheDataSource, remoteDataSource);

  @override
  Future<List<Ranking>> getAll(ReadPolicy readPolicy) {
    return super.getAll(readPolicy);
  }
}
