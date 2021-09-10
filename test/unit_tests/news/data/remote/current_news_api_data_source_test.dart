import 'package:flutter_test/flutter_test.dart';
import 'package:karate_stars_app/src/common/auth/api_credentials_loader.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/news/data/remote/current_news_api_data_source.dart';
import 'package:karate_stars_app/src/news/domain/entities/current.dart';
import 'package:karate_stars_app/src/news/domain/entities/pub_date.dart';

import '../../../common/api/mock_api.dart';
import '../../../common/data/remote/common_remote_data_source_test.dart';
import '../../../common/fake/fake_api_token_storage.dart';

ReadableDataSource<CurrentNews> remoteDataSourceFactory(String baseAddress){
  final Credentials fakeCredentials = Credentials('', '');

  return CurrentNewsApiDataSource(
      baseAddress, fakeCredentials, FakeApiTokenStorage());
}

void expectFirstItem(CurrentNews currentNews) {
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

void main() {
  executeRemoteDataSourceTests(
      'currentnews', remoteDataSourceFactory, getSocialNewsResponse,expectFirstItem);
}
