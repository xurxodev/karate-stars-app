import 'package:flutter_test/flutter_test.dart';
import 'package:karate_stars_app/src/common/auth/credentials.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/event_types/data/remote/event_type_api_data_source.dart';
import 'package:karate_stars_app/src/event_types/domain/entities/event_type.dart';
import '../../../common/api/mock_api.dart';
import '../../../common/data/remote/common_remote_data_source_test.dart';
import '../../../common/fake/fake_api_token_storage.dart';

ReadableDataSource<EventType> remoteDataSourceFactory(String baseAddress) {
  final Credentials fakeCredentials = Credentials('', '');

  return EventTypeApiDataSource(
      baseAddress, fakeCredentials, FakeApiTokenStorage());
}

void expectFirstItem(EventType categoryType) {
  expect(categoryType, isNotNull);
  expect(categoryType.id, 'Jr6N73CZWtE');
  expect(categoryType.name, 'World Championships');
}

void main() {
  executeRemoteDataSourceTests('event-types', remoteDataSourceFactory,
      getEventTypesResponse, expectFirstItem);
}
