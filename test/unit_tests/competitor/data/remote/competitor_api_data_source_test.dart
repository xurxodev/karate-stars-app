import 'package:flutter_test/flutter_test.dart';
import 'package:karate_stars_app/src/common/auth/credentials.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/competitors/data/remote/competitor_api_data_source.dart';
import 'package:karate_stars_app/src/competitors/domain/entities/competitor.dart';

import '../../../common/api/mock_api.dart';
import '../../../common/data/remote/common_remote_data_source_test.dart';
import '../../../common/fake/fake_api_token_storage.dart';

ReadableDataSource<Competitor> remoteDataSourceFactory(String baseAddress) {
  final Credentials fakeCredentials = Credentials('', '');

  return CompetitorApiDataSource(
      baseAddress, fakeCredentials, FakeApiTokenStorage());
}

void expectFirstItem(Competitor competitor) {
  expect(competitor, isNotNull);
  expect(competitor.id, 'Lx1ChvOLNoS');
  expect(competitor.firstName, 'Rika');
  expect(competitor.lastName, 'Usami');
  expect(competitor.biography,
      'Rika Usami (宇佐美 里香, born February 20, 1986) is a Japanese practitioner in Shōrin-ryū Karate. She had said in an interview that she started karate when she was 10 years old by joining a Goju-ryu-style dojo located near her family’s house in Tokyo, after seeing a female fighter on television. Her older brother has been practicing karate to which he even let Usami wear his karate gi on occasions, so that helped her a lot when she decided to eventually start practicing Karate herself.\n\nHer first karate tournament was when she was a green belt at 12 years old in elementary school. She didn\'t participate in big tournaments until at age 15. She first won a big tournament at 17 years old at the national high school championship.');
  expect(competitor.countryId, 'rNx55g3iAjx');
  expect(competitor.categoryId, 'uAwCwvaoUgg');
  expect(competitor.mainImage,
      'https://storage.googleapis.com/karatestars-1261.appspot.com/competitors/VetRoM6JdGY.jpeg');
  expect(competitor.isActive, false);
  expect(competitor.isLegend, true);
  expect(competitor.links.length, 2);
  expect(competitor.links[0].url,
      'https://www.facebook.com/Rika-Usami-513277155360507/');
  expect(competitor.links[0].type, SocialLink.facebook);
  expect(competitor.achievements.length, 6);
  expect(competitor.achievements[0].eventId, 'hSEiLEWuxF1');
  expect(competitor.achievements[0].categoryId, 'uAwCwvaoUgg');
  expect(competitor.achievements[0].position, 1);
}

void main() {
  executeRemoteDataSourceTests('competitors', remoteDataSourceFactory,
      getCompetitorsResponse, expectFirstItem);
}
