import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/countries/data/country_cached_repository.dart';
import 'package:karate_stars_app/src/countries/domain/entities/country.dart';

import '../../../common/mothers/countries_mother.dart';
import '../../common/data/repositories/common_cached_repository_test.dart';

List<Country> _localData() {
  return [spain(), croatia()];
}

List<Country> _remoteData() {
  return [spain(), croatia(), austria(), azerbaijan()];
}

CountryCachedRepository repositoryFactory(
    CacheableDataSource<Country> cache, ReadableDataSource<Country> remote) {
  return CountryCachedRepository(cache, remote);
}

void main() {
  executeRepositoryTests(repositoryFactory, _localData(), _remoteData());
}
