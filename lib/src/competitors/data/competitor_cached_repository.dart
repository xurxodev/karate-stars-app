import 'package:karate_stars_app/src/common/data/cached_repository.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/competitors/domain/boundaries/competitor_repository.dart';
import 'package:karate_stars_app/src/competitors/domain/entities/competitor.dart';

class CompetitorCachedRepository extends CachedRepository<Competitor>
    implements CompetitorRepository {
  CompetitorCachedRepository(CacheableDataSource<Competitor> cacheDataSource,
      ReadableDataSource<Competitor> remoteDataSource)
      : super(cacheDataSource, remoteDataSource);

  @override
  Future<List<Competitor>> getAll(ReadPolicy readPolicy)  {
    return super.getAll(readPolicy);
  }
}
