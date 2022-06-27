import 'package:hive/hive.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/local/cache_data_source.dart';
import 'package:karate_stars_app/src/rankings/data/local/ranking_db.dart';
import 'package:karate_stars_app/src/rankings/data/local/ranking_mapper.dart';
import 'package:karate_stars_app/src/rankings/domain/entities/ranking.dart';

class RankingHiveDataSource extends CacheDataSource
    implements CacheableDataSource<Ranking> {
  final Box<RankingDB> _box;
  final _mapper = RankingMapper();

  RankingHiveDataSource(this._box, int maxCacheTime) : super(maxCacheTime);

  @override
  Future<List<Ranking>> getAll() async {
    return _box.values.map(_mapper.mapToDomain).toList();
  }

  @override
  Future<void> save(List<Ranking> entities) async {
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
