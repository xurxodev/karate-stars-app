import 'package:flutter_test/flutter_test.dart';
import 'package:karate_stars_app/src/common/auth/credentials.dart';
import 'package:karate_stars_app/src/common/data/remote/api_exceptions.dart';
import 'package:karate_stars_app/src/common/data/remote/filterable_api_data_source.dart';
import '../../../common/api/mock_api.dart';
import '../../domain/entities/TestEntity.dart';
import '../../fake/fake_api_token_storage.dart';
import 'test_parser.dart';

late MockApi mockApi;

final filters = {
  'relatedId1': '1',
  'relatedId2': '2'
};

void main() {
  late FilterableApiDataSource<TestEntity> _remoteApiDataSource;

  setUp(() {
    mockApi = MockApi();
    mockApi.start().then((_) {
      _remoteApiDataSource = remoteDataSourceFactory(mockApi.baseAddress);
    });
  });

  tearDown(() {
    mockApi.shutdown();
  });

  group('Filtered test should', () {
    test('sends get request to the correct endpoint', () async {
      await mockApi.enqueueMockResponse(fileName: getTestResponse);

      await _remoteApiDataSource.getByFilters(filters);

      mockApi.expectRequestSentTo('/api-tests');
    });
    test('sends get request with correct query string', () async {
      await mockApi.enqueueMockResponse(fileName: getTestResponse);

      await _remoteApiDataSource.getByFilters(filters);

      mockApi.expectRequestSentWithParameters(filters);
    });
    test('sends accept header', () async {
      await mockApi.enqueueMockResponse(fileName: getTestResponse);

      await _remoteApiDataSource.getByFilters(filters);

      mockApi.expectRequestContainsHeader('accept', 'application/json');
    });
    test('parse properly getting all', () async {
      await mockApi.enqueueMockResponse(fileName: getTestResponse);

      final responseData = await _remoteApiDataSource.getByFilters(filters);

      expectFirstItem(responseData[0]);
    });
  /* test('sends request with token after renew token using the new Token',
            () async {
          await mockApi.enqueueUnauthorizedResponse();
          await mockApi.enqueueLoginResponse();
          await mockApi.enqueueMockResponse(fileName: getTestResponse);

          await _remoteApiDataSource.getByFilters(filters);

          mockApi.expectRequestContainsHeader('authorization', anyTokenHeader, 2);
        });*/
    test(
        'throws UnknownErrorException if there is not handled error getting news',
            () async {
          await mockApi.enqueueMockResponse(httpCode: 454);

          expect(() => _remoteApiDataSource.getByFilters(filters),
              throwsA(isInstanceOf<UnKnowApiException>()));
        });
    test(
        'throws RenewTokenException if the server returns unauthorized response twice',
            () async {
          await mockApi.enqueueUnauthorizedResponse();
          await mockApi.enqueueUnauthorizedResponse();

          expect(() => _remoteApiDataSource.getByFilters(filters),
              throwsA(isInstanceOf<RenewTokenException>()));
        });
  });
}

FilterableApiDataSource<TestEntity> remoteDataSourceFactory(String baseAddress) {
  final Credentials fakeCredentials = Credentials('', '');

  return FilterableApiDataSource(
      baseAddress, 'api-tests', fakeCredentials, FakeApiTokenStorage(), TestParser());
}

void expectFirstItem(TestEntity entity) {
  expect(entity, isNotNull);
  expect(entity.id, 'A');
  expect(entity.name, 'TestEntity 1');
  expect(entity.relatedId1, '1');
  expect(entity.relatedId2, '2');
}
