import 'package:karate_stars_app/src/category_types/data/category_type_cached_repository.dart';
import 'package:karate_stars_app/src/category_types/domain/entities/category_type.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import '../../../common/mothers/category_types_mother.dart';
import '../../common/data/repositories/common_cached_repository_test.dart';

List<CategoryType> _localData() {
  return [kata()];
}

List<CategoryType> _remoteData() {
  return [kata(), kumite()];
}

CategoryTypeCachedRepository repositoryFactory(
    CacheableDataSource<CategoryType> cache, ReadableDataSource<CategoryType> remote) {
  return CategoryTypeCachedRepository(cache, remote);
}

void main() {
  executeRepositoryTests(repositoryFactory, _localData(), _remoteData());
}
