import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/news/domain/current_news_repository.dart';
import 'package:karate_stars_app/src/news/domain/social_news_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:karate_stars_app/app_di.dart' as app_di;

import '../mocks/mocks.dart';

void givenThereAreNoNews() {
  final mockCurrentNewsRepository = MockCurrentNewsRepository();
  when(mockCurrentNewsRepository.getCurrentNews(ReadPolicy.cache_first))
      .thenAnswer((_) => Future.value([]));
  app_di.getIt.registerLazySingleton<CurrentNewsRepository>(
          () => mockCurrentNewsRepository);

  final mockSocialNewsRepository = MockSocialNewsRepository();
  when(mockSocialNewsRepository.getSocialNews(ReadPolicy.cache_first))
      .thenAnswer((_) => Future.value([]));
  app_di.getIt.registerLazySingleton<SocialNewsRepository>(
          () => mockSocialNewsRepository);
}