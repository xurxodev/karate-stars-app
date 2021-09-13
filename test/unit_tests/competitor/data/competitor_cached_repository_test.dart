import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/competitors/data/competitor_cached_repository.dart';
import 'package:karate_stars_app/src/competitors/domain/entities/competitor.dart';

import '../../../common/mothers/competitor_mother.dart';
import '../../common/data/repositories/common_cached_repository_test.dart';

List<Competitor> _localData() {
  return [stevenDaCosta(), joseEgea()];
}

List<Competitor> _remoteData() {
  return [stevenDaCosta(), joseEgea(), damianQuintero(), burakUygur()];
}

CompetitorCachedRepository repositoryFactory(
    CacheableDataSource<Competitor> cache,
    ReadableDataSource<Competitor> remote) {
  return CompetitorCachedRepository(cache, remote);
}

void main() {
  executeRepositoryTests(repositoryFactory, _localData(), _remoteData());
}
