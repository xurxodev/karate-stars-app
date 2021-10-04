import 'package:karate_stars_app/src/common/data/cached_repository.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/videos/domain/boundaries/video_repository.dart';
import 'package:karate_stars_app/src/videos/domain/entities/video.dart';

class VideoCachedRepository extends CachedRepository<Video>
    implements VideoRepository {
  VideoCachedRepository(CacheableDataSource<Video> cacheDataSource,
      ReadableDataSource<Video> remoteDataSource)
      : super(cacheDataSource, remoteDataSource);

  @override
  Future<List<Video>> getAll(ReadPolicy readPolicy) {
    return super.getAll(readPolicy);
  }
}
