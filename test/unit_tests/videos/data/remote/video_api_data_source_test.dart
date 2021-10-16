import 'package:flutter_test/flutter_test.dart';
import 'package:karate_stars_app/src/common/auth/credentials.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/videos/data/remote/video_api_data_source.dart';
import 'package:karate_stars_app/src/videos/domain/entities/video.dart';

import '../../../common/api/mock_api.dart';
import '../../../common/data/remote/common_remote_data_source_test.dart';
import '../../../common/fake/fake_api_token_storage.dart';

ReadableDataSource<Video> remoteDataSourceFactory(String baseAddress) {
  final Credentials fakeCredentials = Credentials('', '');

  return VideoApiDataSource(
      baseAddress, fakeCredentials, FakeApiTokenStorage());
}

void expectFirstItem(Video video) {
  expect(video, isNotNull);
  expect(video.id, 'RB5VUcdkd1l');
  expect(video.title, 'Olympic Games 2020');
  expect(video.subtitle, 'S. Sanchez vs K. Shimizu');
  expect(video.description, 'Final Female Kata');
  expect(video.competitors, ['MDHfjXTLveS', 'P0KYRB8l5tH']);
  expect(video.eventDate, DateTime.parse('2021-08-05T00:00:00.000Z'));
  expect(video.createdDate, DateTime.parse('2021-08-08T15:03:16.110Z'));
  expect(video.order, 0);
  expect(video.links.length, 1);
  expect(video.links[0].id, 'qE18hRFs8V8');
  expect(video.links[0].type, VideoLinkType.youtube);
}

void main() {
  executeRemoteDataSourceTests(
      'videos', remoteDataSourceFactory, getVideosResponse, expectFirstItem);
}
