import 'package:flutter_test/flutter_test.dart';
import 'package:karate_stars_app/src/common/auth/api_credentials_loader.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/news/data/remote/social_news_api_data_source.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';
import 'package:karate_stars_app/src/news/domain/entities/pub_date.dart';

import '../../../common/api/mock_api.dart';
import '../../../common/data/remote/common_remote_data_source_test.dart';
import '../../../common/fake/fake_api_token_storage.dart';

ReadableDataSource<SocialNews> remoteDataSourceFactory(String baseAddress) {
  final Credentials fakeCredentials = Credentials('', '');

  return SocialNewsApiDataSource(
      baseAddress, fakeCredentials, FakeApiTokenStorage());
}

void expectFirstItem(SocialNews socialNews) {
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
  expect(socialNews.user.url, 'https://t.co/gi0CtXBjdr');
}

void main() {
  executeRemoteDataSourceTests('socialnews', remoteDataSourceFactory,
      getSocialNewsResponse, expectFirstItem);
}
