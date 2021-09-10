import 'package:flutter_driver/driver_extension.dart';

import 'package:karate_stars_app/main.dart' as main_app;
import 'package:karate_stars_app/app_di.dart' as app_di;

import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/news/domain/boundaries/current_news_repository.dart';
import 'package:karate_stars_app/src/news/domain/boundaries/social_news_repository.dart';
import 'package:mocktail/mocktail.dart';

import 'mocks/mocks.dart';

void main() {
  // This line enables the extension
  enableFlutterDriverExtension();

  givenThereAreNoNews();

  // Call the `main()` function of your app or call `runApp` with any widget you
  // are interested in testing.
  main_app.mainWithoutDataDependencies();
}

void givenThereAreNoNews() {
  final mockCurrentNewsRepository = MockCurrentNewsRepository();
  when(()=> mockCurrentNewsRepository.getAll(ReadPolicy.cache_first))
      .thenAnswer((_) => Future.value([]));
  app_di.getIt.registerLazySingleton<CurrentNewsRepository>(
          () => mockCurrentNewsRepository);

  final mockSocialNewsRepository = MockSocialNewsRepository();
  when(()=> mockSocialNewsRepository.getAll(ReadPolicy.cache_first))
      .thenAnswer((_) => Future.value([]));
  app_di.getIt.registerLazySingleton<SocialNewsRepository>(
          () => mockSocialNewsRepository);
}
