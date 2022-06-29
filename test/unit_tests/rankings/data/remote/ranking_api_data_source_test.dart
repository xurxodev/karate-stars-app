import 'package:flutter_test/flutter_test.dart';
import 'package:karate_stars_app/src/common/auth/credentials.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/rankings/data/remote/ranking_api_data_source.dart';
import 'package:karate_stars_app/src/rankings/domain/entities/ranking.dart';

import '../../../common/api/mock_api.dart';
import '../../../common/data/remote/common_remote_data_source_test.dart';
import '../../../common/fake/fake_api_token_storage.dart';

ReadableDataSource<Ranking> remoteDataSourceFactory(String baseAddress) {
  final Credentials fakeCredentials = Credentials('', '');

  return RankingApiDataSource(
      baseAddress, fakeCredentials, FakeApiTokenStorage());
}

void expectFirstItem(Ranking ranking) {
  expect(ranking, isNotNull);
  expect(ranking.id, 'vnsabLUirBx');
  expect(ranking.name, 'WKF Ranking');
  expect(ranking.image, 'https://storage.googleapis.com/karatestars-1261.appspot.com/feeds/l1oxUWoZhdL.png');
  expect(ranking.webUrl, 'https://setopen.sportdata.org/wkfranking/ranking_main.php');
  expect(ranking.apiUrl, 'http://setopen.sportdata.org/wkfranking/ranking_main_xml.php');
  expect(ranking.categoryParameter, 'ranking_category_id');
  expect(ranking.categories, ['X4CZx1DLFPc', 'TmnEeLzo5ZC']);

}

void main() {
  executeRemoteDataSourceTests(
      'rankings', remoteDataSourceFactory, getRankingsResponse, expectFirstItem);
}
