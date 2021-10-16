import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/local/cache_data_source.dart';
import 'package:karate_stars_app/src/countries/domain/entities/country.dart';

class CountryInMemoryDataSource extends CacheDataSource
    implements CacheableDataSource<Country> {
  final List<Country> _competitors = [];

  CountryInMemoryDataSource(int maxCacheTime) : super(maxCacheTime);

  @override
  Future<List<Country>> getAll() async {
    return _competitors;
  }

  @override
  Future<void> save(List<Country> items) async {
    _competitors.addAll(items);
  }

  @override
  Future<bool> areValidValues() async {
    return true;
  }

  @override
  Future<void> invalidate() async {
    _competitors.clear();
  }
}
