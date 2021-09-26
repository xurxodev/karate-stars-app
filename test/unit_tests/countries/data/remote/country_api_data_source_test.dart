import 'package:flutter_test/flutter_test.dart';
import 'package:karate_stars_app/src/common/auth/credentials.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/countries/data/remote/country_api_data_source.dart';
import 'package:karate_stars_app/src/countries/domain/entities/country.dart';

import '../../../common/api/mock_api.dart';
import '../../../common/data/remote/common_remote_data_source_test.dart';
import '../../../common/fake/fake_api_token_storage.dart';

ReadableDataSource<Country> remoteDataSourceFactory(String baseAddress) {
  final Credentials fakeCredentials = Credentials('', '');

  return CountryApiDataSource(
      baseAddress, fakeCredentials, FakeApiTokenStorage());
}

void expectFirstItem(Country country) {
  expect(country, isNotNull);
  expect(country.id, 'UCyMZcbtB4u');
  expect(country.name, 'Spain');
  expect(country.iso2, 'es');
  expect(country.image, 'http://www.karatestarsapp.com/app/flags/es.png');
}

void main() {
  executeRemoteDataSourceTests('countries', remoteDataSourceFactory,
      getCountriesResponse, expectFirstItem);
}
