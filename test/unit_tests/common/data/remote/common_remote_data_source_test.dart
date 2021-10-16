import 'package:flutter_test/flutter_test.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/remote/api_exceptions.dart';
import '../../../common/api/mock_api.dart';

late MockApi mockApi;

void executeRemoteDataSourceTests<T>(
    String endpoint,
    Function(String baseAddress) remoteDataSourceFactory,
    stubResponseFile,
    Function(T item) expectFirstItem) {
  late ReadableDataSource<T> _remoteApiDataSource;

  setUp(() {
    mockApi = MockApi();
    mockApi.start().then((_) {
      _remoteApiDataSource = remoteDataSourceFactory(mockApi.baseAddress);
    });
  });

  tearDown(() {
    mockApi.shutdown();
  });

  group('$endpoint should', () {
    test('sends get request to the correct endpoint', () async {
      await mockApi.enqueueMockResponse(fileName: stubResponseFile);

      await _remoteApiDataSource.getAll();

      mockApi.expectRequestSentTo('/$endpoint');
    });
    test('sends accept header', () async {
      await mockApi.enqueueMockResponse(fileName: stubResponseFile);

      await _remoteApiDataSource.getAll();

      mockApi.expectRequestContainsHeader('accept', 'application/json');
    });
    test('parse social news properly getting all social news', () async {
      await mockApi.enqueueMockResponse(fileName: stubResponseFile);

      final responseData = await _remoteApiDataSource.getAll();

      expectFirstItem(responseData[0]);
    });
/*    test('sends request with token after renew token using the new Token',
            () async {
          await mockApi.enqueueUnauthorizedResponse();
          await mockApi.enqueueLoginResponse();
          await mockApi.enqueueMockResponse(fileName: getSocialNewsResponse);

          await _remoteApiDataSource.getAll();

          mockApi.expectRequestContainsHeader('authorization', anyTokenHeader, 2);
        });*/
    test(
        'throws UnknownErrorException if there is not handled error getting news',
        () async {
      await mockApi.enqueueMockResponse(httpCode: 454);

      expect(() => _remoteApiDataSource.getAll(),
          throwsA(isInstanceOf<UnKnowApiException>()));
    });
    test(
        'throws RenewTokenException if the server returns unauthorized response twice',
        () async {
      await mockApi.enqueueUnauthorizedResponse();
      await mockApi.enqueueUnauthorizedResponse();

      expect(() => _remoteApiDataSource.getAll(),
          throwsA(isInstanceOf<RenewTokenException>()));
    });
  });
}

// To avoid method main not found
void main() {}
