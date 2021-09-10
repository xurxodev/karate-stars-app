import 'package:flutter_test/flutter_test.dart';
import 'package:karate_stars_app/src/common/auth/api_credentials_loader.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/competitors/data/remote/competitor_api_data_source.dart';
import 'package:karate_stars_app/src/competitors/domain/entities/competitor.dart';

import '../../../common/api/mock_api.dart';
import '../../../common/data/remote/common_remote_data_source_test.dart';
import '../../../common/fake/fake_api_token_storage.dart';

ReadableDataSource<Competitor> remoteDataSourceFactory(String baseAddress){
  final Credentials fakeCredentials = Credentials('', '');

  return CompetitorApiDataSource(
      baseAddress, fakeCredentials, FakeApiTokenStorage());
}

void expectFirstItem(Competitor competitor) {
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

void main() {
  executeRemoteDataSourceTests(
      'competitors', remoteDataSourceFactory, getSocialNewsResponse,expectFirstItem);
}