import 'package:karate_stars_app/app_di.dart' as app_di;
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/videos/domain/boundaries/video_repository.dart';
import 'package:mocktail/mocktail.dart';

import 'mocks.dart';

void givenThereAreNoVideos() {
  final mockVideoRepository = MockVideoRepository();
  when(() => mockVideoRepository.getAll(ReadPolicy.cache_first))
      .thenAnswer((_) => Future.value([]));
  app_di.getIt
      .registerLazySingleton<VideoRepository>(() => mockVideoRepository);
}
