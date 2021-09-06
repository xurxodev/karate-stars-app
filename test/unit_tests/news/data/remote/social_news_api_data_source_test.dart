import 'package:flutter_test/flutter_test.dart';
import 'package:karate_stars_app/src/common/auth/api_credentials_loader.dart';
import 'package:karate_stars_app/src/common/data/remote/api_exceptions.dart';
import 'package:karate_stars_app/src/news/data/remote/social_news_api_data_source.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';
import 'package:karate_stars_app/src/news/domain/entities/pub_date.dart';

import '../../../common/api/mock_api.dart';
import '../../../common/fake/fake_api_token_storage.dart';

late SocialNewsApiDataSource _socialNewsApiDataSource;

late MockApi mockApi;

void main() {
  setUp(()  {

    mockApi = MockApi();
    mockApi.start().then ((_){
      final Credentials fakeCredentials = Credentials('', '');

      _socialNewsApiDataSource = SocialNewsApiDataSource(
          mockApi.baseAddress, fakeCredentials, FakeApiTokenStorage());
    });
  });

  tearDown(() {
    mockApi.shutdown();
  });

  group('SocialNewsApiDataSource should', () {
    test('sends get request to the correct endpoint', () async {
      await mockApi.enqueueMockResponse(fileName: getSocialNewsResponse);

      await _socialNewsApiDataSource.getAll();

      mockApi.expectRequestSentTo('/socialnews');
    });
    test('sends accept header', () async {
      await mockApi.enqueueMockResponse(fileName: getSocialNewsResponse);

      await _socialNewsApiDataSource.getAll();

      mockApi.expectRequestContainsHeader('accept', 'application/json');
    });
    test('parse social news properly getting all social news', () async {
      await mockApi.enqueueMockResponse(fileName: getSocialNewsResponse);

      final socialNews = await _socialNewsApiDataSource.getAll();

      expectSocialNewsContainsExpectedValues(socialNews[0]);
    });
/*    test('sends request with token after renew token using the new Token',
            () async {
          await mockApi.enqueueUnauthorizedResponse();
          await mockApi.enqueueLoginResponse();
          await mockApi.enqueueMockResponse(fileName: getSocialNewsResponse);

          await _socialNewsApiDataSource.getAll();

          mockApi.expectRequestContainsHeader('authorization', anyTokenHeader, 2);
        });*/
    test(
        'throws UnknownErrorException if there is not handled error getting news',
            () async {
          await mockApi.enqueueMockResponse(httpCode: 454);

          expect(() => _socialNewsApiDataSource.getAll(),
              throwsA(isInstanceOf<UnKnowApiException>()));
        });
    test(
        'throws RenewTokenException if the server returns unauthorized response twice',
            () async {
          await mockApi.enqueueUnauthorizedResponse();
          await mockApi.enqueueUnauthorizedResponse();

          expect(() => _socialNewsApiDataSource.getAll(),
              throwsA(isInstanceOf<RenewTokenException>()));
        });
  });
}

void expectSocialNewsContainsExpectedValues(SocialNews socialNews) {
  expect(socialNews, isNotNull);
  expect(socialNews.network, Network.twitter);
  expect(socialNews.summary.title,
      'Only 3⃣ days to the start of #Karate1Salzburg');
  expect(socialNews.summary.image,
      'http://pbs.twimg.com/media/ERpGJzkUcAACS38.jpg');
  expect(socialNews.summary.pubDate,
      PubDate(DateTime.parse('2020-02-25T16:11:42.000Z')));
  expect(socialNews.summary.link,
      'https://twitter.com/worldkarate_wkf/status/1232337381111533600');
  expect(socialNews.user.name, 'World Karate Federation');
  expect(socialNews.user.userName, 'worldkarate_wkf');
  expect(socialNews.user.image,
      'http://pbs.twimg.com/profile_images/1229708688597880833/PiQoEC9T_normal.jpg');
  expect(socialNews.user.url,
      'https://t.co/gi0CtXBjdr');
}

