import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/local/cache_data_source.dart';
import 'package:karate_stars_app/src/videos/domain/entities/video.dart';

class VideoInMemoryDataSource extends CacheDataSource
    implements CacheableDataSource<Video> {
  final List<Video> _videos = [];

  VideoInMemoryDataSource(int maxCacheTime) : super(maxCacheTime);

  @override
  Future<List<Video>> getAll() async {
    return _videos;
  }

  @override
  Future<void> save(List<Video> items) async {
    _videos.addAll(items);
  }

  @override
  Future<bool> areValidValues() async {
    return true;
  }

  @override
  Future<void> invalidate() async {
    _videos.clear();
  }
}
