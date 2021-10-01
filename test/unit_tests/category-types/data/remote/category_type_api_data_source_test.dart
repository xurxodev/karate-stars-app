import 'package:flutter_test/flutter_test.dart';
import 'package:karate_stars_app/src/category_types/data/remote/category_type_api_data_source.dart';
import 'package:karate_stars_app/src/category_types/domain/entities/category_type.dart';
import 'package:karate_stars_app/src/common/auth/credentials.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';

import '../../../common/api/mock_api.dart';
import '../../../common/data/remote/common_remote_data_source_test.dart';
import '../../../common/fake/fake_api_token_storage.dart';

ReadableDataSource<CategoryType> remoteDataSourceFactory(String baseAddress) {
  final Credentials fakeCredentials = Credentials('', '');

  return CategoryTypeApiDataSource(
      baseAddress, fakeCredentials, FakeApiTokenStorage());
}

void expectFirstItem(CategoryType categoryType) {
  expect(categoryType, isNotNull);
  expect(categoryType.id, 'qWPs4i1e78g');
  expect(categoryType.name, 'Kata');
}

void main() {
  executeRemoteDataSourceTests('category-types', remoteDataSourceFactory,
      getCategoryTypesResponse, expectFirstItem);
}
