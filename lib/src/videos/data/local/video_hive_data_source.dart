import 'package:hive/hive.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/local/cache_data_source.dart';
import 'package:karate_stars_app/src/videos/data/local/models/video_db.dart';
import 'package:karate_stars_app/src/videos/data/local/video_mapper.dart';
import 'package:karate_stars_app/src/videos/domain/entities/video.dart';

class VideoHiveDataSource extends CacheDataSource
    implements CacheableDataSource<Video> {
  final Box<VideoDB> _box;
  final _mapper = VideoMapper();

  VideoHiveDataSource(this._box, int maxCacheTime) : super(maxCacheTime);

  @override
  Future<List<Video>> getAll() async {
    return _box.values.map(_mapper.mapToDomain).toList();
  }

  @override
  Future<void> save(List<Video> entities) async {
    await _box.addAll(entities.map(_mapper.mapToDB));
  }

  @override
  Future<bool> areValidValues() async {
    return !super.areDirty(_box.values.toList());
  }

  @override
  Future<void> invalidate() async {
    _box.clear();
  }
}
