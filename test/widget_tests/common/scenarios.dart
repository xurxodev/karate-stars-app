import 'package:karate_stars_app/app_di.dart' as app_di;
import 'package:karate_stars_app/src/news/domain/entities/news.dart';

import 'scenarios_competitors.dart';
import 'scenarios_news.dart';

void givenThereAreNoData() {
  app_di.reset();
  app_di.initWithoutDataDependencies();

  givenThereAreNoNews();
  givenThereAreNoCompetitors();
}

void givenThereAreOnlyNewsAndThrowNetworkException() {
  app_di.reset();
  app_di.initWithoutDataDependencies();

  givenThatNewsDataThrowNetworkException();
  givenThereAreNoCompetitors();
}

List<News>  givenThereAreOnlyNews() {
  app_di.reset();
  app_di.initWithoutDataDependencies();

  givenThereAreNoCompetitors();
  return givenThereAreNews();
}