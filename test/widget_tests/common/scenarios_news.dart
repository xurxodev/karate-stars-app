import 'package:karate_stars_app/app_di.dart' as app_di;
import 'package:karate_stars_app/src/common/data/remote/api_exceptions.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/news/domain/boundaries/current_news_repository.dart';
import 'package:karate_stars_app/src/news/domain/boundaries/social_news_repository.dart';
import 'package:karate_stars_app/src/news/domain/entities/news.dart';
import 'package:mocktail/mocktail.dart';

import '../../common/mothers/social_news_mother.dart';
import 'mocks.dart';

void givenThereAreNoNews() {
  final mockCurrentNewsRepository = MockCurrentNewsRepository();
  when(() => mockCurrentNewsRepository.getAll(ReadPolicy.cache_first))
      .thenAnswer((_) => Future.value([]));
  app_di.getIt.registerLazySingleton<CurrentNewsRepository>(
      () => mockCurrentNewsRepository);

  final mockSocialNewsRepository = MockSocialNewsRepository();
  when(() => mockSocialNewsRepository.getAll(ReadPolicy.cache_first))
      .thenAnswer((_) => Future.value([]));
  app_di.getIt.registerLazySingleton<SocialNewsRepository>(
      () => mockSocialNewsRepository);
}

void givenThatNewsDataThrowNetworkException() {
  final mockCurrentNewsRepository = MockCurrentNewsRepository();
  when(() => mockCurrentNewsRepository.getAll(ReadPolicy.cache_first))
      .thenAnswer((_) async => throw NetworkException());

  app_di.getIt.registerLazySingleton<CurrentNewsRepository>(
      () => mockCurrentNewsRepository);

  final mockSocialNewsRepository = MockSocialNewsRepository();
  when(() => mockSocialNewsRepository.getAll(ReadPolicy.cache_first))
      .thenAnswer((_) async => throw NetworkException());

  app_di.getIt.registerLazySingleton<SocialNewsRepository>(
      () => mockSocialNewsRepository);
}

List<News> givenThereAreNews() {
  final List<News> allNews = [];

  //allNews.addAll(allCurrentNews());
  allNews.addAll(allSocialNews());

  allNews
      .sort((a, b) => b.summary.pubDate.date.compareTo(a.summary.pubDate.date));

  final mockCurrentNewsRepository = MockCurrentNewsRepository();

/*  when(() => mockCurrentNewsRepository.getAll(ReadPolicy.cache_first))
      .thenAnswer((_) => Future.value(allCurrentNews()));*/
  when(() => mockCurrentNewsRepository.getAll(ReadPolicy.cache_first))
      .thenAnswer((_) => Future.value([]));

  app_di.getIt.registerLazySingleton<CurrentNewsRepository>(
      () => mockCurrentNewsRepository);

  final mockSocialNewsRepository = MockSocialNewsRepository();

  when(() => mockSocialNewsRepository.getAll(ReadPolicy.cache_first))
      .thenAnswer((_) => Future.value(allSocialNews()));

  app_di.getIt.registerLazySingleton<SocialNewsRepository>(
      () => mockSocialNewsRepository);

  return allNews;
}
