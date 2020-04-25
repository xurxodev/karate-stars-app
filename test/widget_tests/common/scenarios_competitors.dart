import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/app_di.dart' as app_di;
import 'package:karate_stars_app/src/competitors/domain/boundaries/competitor_repository.dart';
import 'package:mockito/mockito.dart';
import 'mocks.dart';

void givenThereAreNoCompetitors() {
  final mockCompetitorRepository = MockCompetitorRepository();

  when(mockCompetitorRepository.getAll(ReadPolicy.cache_first))
      .thenAnswer((_) => Future.value([]));

  app_di.getIt.registerLazySingleton<CompetitorRepository>(
          () => mockCompetitorRepository);
}

/*
void givenThatNewsDataThrowNetworkException() {
  app_di.reset();
  app_di.initWithoutDataDependencies();

  final mockCurrentNewsRepository = MockCurrentNewsRepository();
  when(mockCurrentNewsRepository.getCurrentNews(ReadPolicy.cache_first))
      .thenAnswer((_) async => throw NetworkException());

  app_di.getIt.registerLazySingleton<CurrentNewsRepository>(
          () => mockCurrentNewsRepository);

  final mockSocialNewsRepository = MockSocialNewsRepository();
  when(mockSocialNewsRepository.getSocialNews(ReadPolicy.cache_first))
      .thenAnswer((_) async => throw NetworkException());

  app_di.getIt.registerLazySingleton<SocialNewsRepository>(
          () => mockSocialNewsRepository);
}

List<News> givenThereAreNews() {
  app_di.reset();
  app_di.initWithoutDataDependencies();

  final List<News> allNews = [];

  allNews.addAll(CurrentNewsMother.all());
  allNews.addAll(SocialNewsMother.all());

  allNews.sort((a, b) => b.summary.pubDate.date.compareTo(a.summary.pubDate.date));

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

  return allNews;
}*/
