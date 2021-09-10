import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/local/cache_data_source.dart';
import 'package:karate_stars_app/src/competitors/domain/entities/competitor.dart';

class CompetitorInMemoryDataSource extends CacheDataSource
    implements CacheableDataSource<Competitor> {
  final List<Competitor> _competitors = [];

  CompetitorInMemoryDataSource(int maxCacheTime) : super(maxCacheTime);

  @override
  Future<List<Competitor>> getAll() async {
    return _competitors;
  }

  @override
  Future<void> save(List<Competitor> items) async {
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
