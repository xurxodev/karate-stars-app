import 'package:karate_stars_app/app_di.dart' as app_di;
import 'package:karate_stars_app/src/news/domain/entities/news.dart';

import 'scenarios_category.dart';
import 'scenarios_category_types.dart';
import 'scenarios_competitors.dart';
import 'scenarios_countries.dart';
import 'scenarios_news.dart';
import 'scenarios_settings.dart';
import 'scenarios_videos.dart';

Future<void> givenThereAreNoData() async {
  await app_di.reset();
  app_di.initWithoutDataDependencies();

  givenThereAreSettings();
  givenThereAreNoNews();
  givenThereAreNoCompetitors();
  givenThereAreNoCountries();
  givenThereAreNoCategoryTypes();
  givenThereAreNoCategories();
  givenThereAreNoVideos();
}

Future<void> givenThereAreOnlyNewsAndThrowNetworkException() async {
  await app_di.reset();
  app_di.initWithoutDataDependencies();

  givenThereAreSettings();
  givenThatNewsDataThrowNetworkException();
  givenThereAreNoCompetitors();
  givenThereAreNoCountries();
  givenThereAreNoCategoryTypes();
  givenThereAreNoCategories();
  givenThereAreNoVideos();
}

Future<List<News>> givenThereAreOnlyNews() async {
  await app_di.reset();
  app_di.initWithoutDataDependencies();

  givenThereAreSettings();
  givenThereAreNoCompetitors();
  givenThereAreNoCountries();
  givenThereAreNoCategoryTypes();
  givenThereAreNoCategories();
  givenThereAreNoVideos();

  return givenThereAreNews();
}
