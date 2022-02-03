import 'package:hive/hive.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/local/cache_data_source.dart';
import 'package:karate_stars_app/src/countries/data/local/country_db.dart';
import 'package:karate_stars_app/src/countries/data/local/country_mapper.dart';
import 'package:karate_stars_app/src/countries/domain/entities/country.dart';

class CountryHiveDataSource extends CacheDataSource
    implements CacheableDataSource<Country> {
  final Box<CountryDB> _box;
  final _mapper = CountryMapper();

  CountryHiveDataSource(this._box, int maxCacheTime) : super(maxCacheTime);

  @override
  Future<List<Country>> getAll() async {
    return _box.values.map(_mapper.mapToDomain).toList();
  }

  @override
  Future<void> save(List<Country> entities) async {
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
