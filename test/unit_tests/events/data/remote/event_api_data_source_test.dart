import 'package:flutter_test/flutter_test.dart';
import 'package:karate_stars_app/src/common/auth/credentials.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/events/data/remote/event_api_data_source.dart';
import 'package:karate_stars_app/src/events/domain/entities/event.dart';

import '../../../common/api/mock_api.dart';
import '../../../common/data/remote/common_remote_data_source_test.dart';
import '../../../common/fake/fake_api_token_storage.dart';

ReadableDataSource<Event> remoteDataSourceFactory(String baseAddress) {
  final Credentials fakeCredentials = Credentials('', '');

  return EventApiDataSource(
      baseAddress, fakeCredentials, FakeApiTokenStorage());
}

void expectFirstItem(Event event) {
  expect(event, isNotNull);
  expect(event.id, 'W9p4KDNo1Vi');
  expect(event.name, 'European Championships Porec 2021');
  expect(event.typeId, 'FEJ08kkHhqi');
  expect(event.year, 2021);
}

void main() {
  executeRemoteDataSourceTests(
      'events', remoteDataSourceFactory, getEventsResponse, expectFirstItem);
}
