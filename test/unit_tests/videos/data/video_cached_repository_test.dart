import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/videos/data/video_cached_repository.dart';
import 'package:karate_stars_app/src/videos/domain/entities/video.dart';

import '../../../common/mothers/videos_mother.dart';
import '../../common/data/repositories/common_cached_repository_test.dart';

List<Video> _localData() {
  return [sandraTokyo2020()];
}

List<Video> _remoteData() {
  return [sandraTokyo2020(), ryoKiyuna2020()];
}

VideoCachedRepository repositoryFactory(
    CacheableDataSource<Video> cache,
    ReadableDataSource<Video> remote) {
  return VideoCachedRepository(cache, remote);
}

void main() {
  executeRepositoryTests(repositoryFactory, _localData(), _remoteData());
}
