import 'package:karate_stars_app/src/categories/data/category_cached_repository.dart';
import 'package:karate_stars_app/src/categories/domain/entities/category.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import '../../../common/mothers/categories_mother.dart';
import '../../common/data/repositories/common_cached_repository_test.dart';

List<Category> _localData() {
  return [maleKata(), femaleKata()];
}

List<Category> _remoteData() {
  return [maleKata(), femaleKata(), maleTeamKumite(), femaleTeamKumite()];
}

CategoryCachedRepository repositoryFactory(
    CacheableDataSource<Category> cache, ReadableDataSource<Category> remote) {
  return CategoryCachedRepository(cache, remote);
}

void main() {
  executeRepositoryTests(repositoryFactory, _localData(), _remoteData());
}
