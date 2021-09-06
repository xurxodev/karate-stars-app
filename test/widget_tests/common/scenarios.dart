import 'package:karate_stars_app/app_di.dart' as app_di;
import 'package:karate_stars_app/src/news/domain/entities/news.dart';

import 'scenarios_competitors.dart';
import 'scenarios_news.dart';

Future<void> givenThereAreNoData() async {
  await app_di.reset();
  app_di.initWithoutDataDependencies();

  givenThereAreNoNews();
  givenThereAreNoCompetitors();
}

Future<void> givenThereAreOnlyNewsAndThrowNetworkException() async {
  await app_di.reset();
  app_di.initWithoutDataDependencies();

  givenThatNewsDataThrowNetworkException();
  givenThereAreNoCompetitors();
}

Future<List<News>>  givenThereAreOnlyNews() async {
  await app_di.reset();
  app_di.initWithoutDataDependencies();

  givenThereAreNoCompetitors();
  return givenThereAreNews();
}