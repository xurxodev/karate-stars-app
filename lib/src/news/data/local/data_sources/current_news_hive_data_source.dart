import 'package:hive/hive.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/local/cache_data_source.dart';
import 'package:karate_stars_app/src/news/data/local/mappers/current_news_mapper.dart';
import 'package:karate_stars_app/src/news/data/local/models/current_news_db.dart';
import 'package:karate_stars_app/src/news/domain/entities/current.dart';

class CurrentNewsHiveDataSource extends CacheDataSource
    implements CacheableDataSource<CurrentNews> {
  final Box<CurrentNewsDB> _box;
  final _mapper = CurrentNewsMapper();

  CurrentNewsHiveDataSource(this._box, int maxCacheTime) : super(maxCacheTime);

  @override
  Future<List<CurrentNews>> getAll() async {
    return _box.values.map(_mapper.mapToDomain).toList();
  }

  @override
  Future<void> save(List<CurrentNews> items) async {
    await _box.addAll(items.map(_mapper.mapToDB));
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
