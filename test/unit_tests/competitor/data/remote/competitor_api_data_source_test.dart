import 'package:flutter_test/flutter_test.dart';
import 'package:karate_stars_app/src/common/auth/api_credentials_loader.dart';
import 'package:karate_stars_app/src/common/data/remote/api_exceptions.dart';
import 'package:karate_stars_app/src/competitors/data/remote/competitor_api_data_source.dart';
import 'package:karate_stars_app/src/competitors/domain/entities/competitor.dart';

import '../../../common/api/mock_api.dart';
import '../../../common/fake/fake_api_token_storage.dart';

CompetitorApiDataSource _competitorApiDataSource;

MockApi mockApi;

void main() {
  setUp(()  {

    mockApi = MockApi();
    mockApi.start().then((_) {
      final Credentials fakeCredentials = Credentials('', '');
      _competitorApiDataSource = CompetitorApiDataSource(
          mockApi.baseAddress, fakeCredentials, FakeApiTokenStorage());
    });
  });

  tearDown(() {
    mockApi.shutdown();
  });

  group('CompetitorApiDataSource should', () {
    test('sends get request to the correct endpoint', () async {
      await mockApi.enqueueMockResponse(fileName: getCompetitorsResponse);

      await _competitorApiDataSource.getAll();

      mockApi.expectRequestSentTo('/competitors');
    });
    test('sends accept header', () async {
      await mockApi.enqueueMockResponse(fileName: getCompetitorsResponse);

      await _competitorApiDataSource.getAll();

      mockApi.expectRequestContainsHeader('accept', 'application/json');
    });
    test('parse current news properly getting all current news', () async {
      await mockApi.enqueueMockResponse(fileName: getCompetitorsResponse);

      final competitors = await _competitorApiDataSource.getAll();

      expectCompetitorContainsExpectedValues(competitors[0]);
    });
    test('sends request with token after renew token using the new Token',
        () async {
      await mockApi.enqueueUnauthorizedResponse();
      await mockApi.enqueueLoginResponse();
      await mockApi.enqueueMockResponse(fileName: getCompetitorsResponse);

      await _competitorApiDataSource.getAll();

      mockApi.expectRequestContainsHeader('authorization', anyTokenHeader, 2);
    });
    test(
        'throws UnknownErrorException if there is not handled error getting news',
        () async {
      await mockApi.enqueueMockResponse(httpCode: 454);

      expect(() => _competitorApiDataSource.getAll(),
          throwsA(isInstanceOf<UnKnowApiException>()));
    });
    test(
        'throws RenewTokenException if the server returns unauthorized response twice',
        () async {
      await mockApi.enqueueUnauthorizedResponse();
      await mockApi.enqueueUnauthorizedResponse();

      expect(() => _competitorApiDataSource.getAll(),
          throwsA(isInstanceOf<RenewTokenException>()));
    });
  });
}

void expectCompetitorContainsExpectedValues(Competitor competitor) {
  expect(competitor, isNotNull);
  expect(competitor.identifier,'gCvaLu3B');
  expect(competitor.name,'Rika Usami');
  expect(competitor.biography,'Rika Usami (宇佐美 里香, born February 20, 1986) is a Japanese practitioner in Shōrin-ryū Karate. She had said in an interview that she started karate when she was 10 years old by joining a Goju-ryu-style dojo located near her family’s house in Tokyo, after seeing a female fighter on television. Her older brother has been practicing karate to which he even let Usami wear his karate gi on occasions, so that helped her a lot when she decided to eventually start practicing Karate herself.\n\nHer first karate tournament was when she was a green belt at 12 years old in elementary school. She didn\'t participate in big tournaments until at age 15. She first won a big tournament at 17 years old at the national high school championship.');
  expect(competitor.countryId,'jp');
  expect(competitor.categoryId,'1xSqqSPN');
  expect(competitor.mainImage,'http://www.karatestarsapp.com/app/images/rika-usami.jpg');
  expect(competitor.isStar,false);
  expect(competitor.isLegend,true);
  expect(competitor.links.web,'fakeWeb');
  expect(competitor.links.twitter,'fakeTitter');
  expect(competitor.links.facebook,'https://www.facebook.com/Rika-Usami-513277155360507/');
  expect(competitor.links.instagram,'https://www.instagram.com/rikausami');
  expect(competitor.achievements.length,3);
  expect(competitor.achievements[0].name,'Asian Championships');
  expect(competitor.achievements[0].details.length,3);
  expect(competitor.achievements[0].details[0].category,'Individual Kata');
  expect(competitor.achievements[0].details[0].name,'Foshan 2009');
  expect(competitor.achievements[0].details[0].position,1);
}