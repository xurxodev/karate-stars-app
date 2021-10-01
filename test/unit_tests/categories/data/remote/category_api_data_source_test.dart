import 'package:flutter_test/flutter_test.dart';
import 'package:karate_stars_app/src/categories/data/remote/category_api_data_source.dart';
import 'package:karate_stars_app/src/categories/domain/entities/category.dart';
import 'package:karate_stars_app/src/common/auth/credentials.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';

import '../../../common/api/mock_api.dart';
import '../../../common/data/remote/common_remote_data_source_test.dart';
import '../../../common/fake/fake_api_token_storage.dart';

ReadableDataSource<Category> remoteDataSourceFactory(String baseAddress) {
  final Credentials fakeCredentials = Credentials('', '');

  return CategoryApiDataSource(
      baseAddress, fakeCredentials, FakeApiTokenStorage());
}

void expectFirstItem(Category category) {
  expect(category, isNotNull);
  expect(category.id, 'KqVrbhbJ72W');
  expect(category.name, 'Male Kata');
  expect(category.typeId, 'qWPs4i1e78g');
}

void main() {
  executeRemoteDataSourceTests('categories', remoteDataSourceFactory,
      getCategoriesResponse, expectFirstItem);
}
