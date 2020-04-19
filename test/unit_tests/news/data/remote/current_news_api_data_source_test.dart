import 'package:flutter_test/flutter_test.dart';
import 'package:karate_stars_app/src/common/auth/api_credentials_loader.dart';
import 'package:karate_stars_app/src/common/data/remote/api_exceptions.dart';
import 'package:karate_stars_app/src/news/data/remote/current_news_api_data_source.dart';
import 'package:karate_stars_app/src/news/domain/entities/current.dart';
import 'package:karate_stars_app/src/news/domain/entities/pub_date.dart';

import '../../../common/api/mock_api.dart';
import '../../../common/fake/fake_api_token_storage.dart';

CurrentNewsApiDataSource _currentNewsApiDataSource;

MockApi mockApi;

void main() {
  setUp(()  {

    mockApi = MockApi();
    mockApi.start().then((_) {
      final Credentials fakeCredentials = Credentials('', '');
      _currentNewsApiDataSource = CurrentNewsApiDataSource(
          mockApi.baseAddress, fakeCredentials, FakeApiTokenStorage());
    });
  });

  tearDown(() {
    mockApi.shutdown();
  });

  group('CurrentNewsApiDataSource should', () {
    test('sends get request to the correct endpoint', () async {
      await mockApi.enqueueMockResponse(fileName: getCurrentNewsResponse);

      await _currentNewsApiDataSource.getAll();

      mockApi.expectRequestSentTo('/currentnews');
    });
    test('sends accept header', () async {
      await mockApi.enqueueMockResponse(fileName: getCurrentNewsResponse);

      await _currentNewsApiDataSource.getAll();

      mockApi.expectRequestContainsHeader('accept', 'application/json');
    });
    test('parse current news properly getting all current news', () async {
      await mockApi.enqueueMockResponse(fileName: getCurrentNewsResponse);

      final currentNews = await _currentNewsApiDataSource.getAll();

      expectCurrentNewsContainsExpectedValues(currentNews[0]);
    });
/*    test('sends request with token after renew token using the new Token',
        () async {
      await mockApi.enqueueUnauthorizedResponse();
      await mockApi.enqueueLoginResponse();
      await mockApi.enqueueMockResponse(fileName: getCurrentNewsResponse);

      await _currentNewsApiDataSource.getAll();

      mockApi.expectRequestContainsHeader('authorization', anyTokenHeader, 2);
    });*/
    test(
        'throws UnknownErrorException if there is not handled error getting news',
        () async {
      await mockApi.enqueueMockResponse(httpCode: 454);

      expect(() => _currentNewsApiDataSource.getAll(),
          throwsA(isInstanceOf<UnKnowApiException>()));
    });
    test(
        'throws RenewTokenException if the server returns unauthorized response twice',
        () async {
      await mockApi.enqueueUnauthorizedResponse();
      await mockApi.enqueueUnauthorizedResponse();

      expect(() => _currentNewsApiDataSource.getAll(),
          throwsA(isInstanceOf<RenewTokenException>()));
    });
  });
}

void expectCurrentNewsContainsExpectedValues(CurrentNews currentNews) {
  expect(currentNews, isNotNull);
  expect(currentNews.summary.title,
      'Lotfy clinches third consecutive title at African Karate Championships');
  expect(currentNews.summary.image,
      'https://www.insidethegames.biz/media/image/169838/o/1581271334719.jpg');
  expect(currentNews.summary.pubDate,
      PubDate(DateTime.parse('2020-02-10T14:45:53.000Z')));
  expect(currentNews.summary.link,
      'https://www.insidethegames.biz/articles/1090343/lotfy-african-karate-championships-gold');
  expect(currentNews.source.name, 'Inside The Games');
  expect(currentNews.source.image,
      'http://www.karatestarsapp.com/app/logos/inside_the_games.gif');
  expect(currentNews.source.url,
      'http://fetchrss.com/rss/59baa0d28a93f8a1048b4567627850382.xml');
}

