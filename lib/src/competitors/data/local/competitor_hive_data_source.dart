import 'package:hive/hive.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/local/cache_data_source.dart';
import 'package:karate_stars_app/src/competitors/data/local/competitor_mapper.dart';
import 'package:karate_stars_app/src/competitors/data/local/models/competitor_db.dart';
import 'package:karate_stars_app/src/competitors/domain/entities/competitor.dart';

class CompetitorHiveDataSource extends CacheDataSource
    implements CacheableDataSource<Competitor> {
  final Box<CompetitorDB> _box;
  final _mapper = CompetitorMapper();

  CompetitorHiveDataSource(this._box, int maxCacheTime) : super(maxCacheTime);

  @override
  Future<List<Competitor>> getAll() async {
    return _box.values.map(_mapper.mapToDomain).toList();
  }

  @override
  Future<void> save(List<Competitor> entities) async {
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
