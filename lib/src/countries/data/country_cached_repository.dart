import 'package:karate_stars_app/src/common/data/cached_repository.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/countries/domain/boundaries/country_repository.dart';
import 'package:karate_stars_app/src/countries/domain/entities/country.dart';

class CountryCachedRepository extends CachedRepository<Country>
    implements CountryRepository {
  CountryCachedRepository(CacheableDataSource<Country> cacheDataSource,
      ReadableDataSource<Country> remoteDataSource)
      : super(cacheDataSource, remoteDataSource);

  @override
  Future<List<Country>> getAll(ReadPolicy readPolicy) {
    return super.getAll(readPolicy);
  }
}
