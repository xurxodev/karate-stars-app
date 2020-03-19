import 'package:flutter_driver/driver_extension.dart';

import 'package:karate_stars_app/main.dart' as main_app;
import 'package:karate_stars_app/app_di.dart' as app_di;

import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/news/domain/current_news_repository.dart';
import 'package:karate_stars_app/src/news/domain/social_news_repository.dart';
import 'package:mockito/mockito.dart';

import 'mocks/mocks.dart';
import 'mocks/mothers/current_news_mother.dart';
import 'mocks/mothers/social_news_mother.dart';

void main() {
  // This line enables the extension
  enableFlutterDriverExtension();

  givenThereAreNoNews();

  // Call the `main()` function of your app or call `runApp` with any widget you
  // are interested in testing.
  main_app.main();
}

void givenThereAreNoNews() {
  final mockCurrentNewsRepository = MockCurrentNewsRepository();
  when(mockCurrentNewsRepository.getCurrentNews(ReadPolicy.cache_first))
      .thenAnswer((_) => Future.value(CurrentNewsMother.all()));
  app_di.getIt.registerLazySingleton<CurrentNewsRepository>(
          () => mockCurrentNewsRepository);

  final mockSocialNewsRepository = MockSocialNewsRepository();
  when(mockSocialNewsRepository.getSocialNews(ReadPolicy.cache_first))
      .thenAnswer((_) => Future.value(SocialNewsMother.all()));
  app_di.getIt.registerLazySingleton<SocialNewsRepository>(
          () => mockSocialNewsRepository);
}
