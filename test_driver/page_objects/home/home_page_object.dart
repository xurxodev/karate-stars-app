import 'package:flutter_driver/flutter_driver.dart';

import 'competitors_content.dart';
import 'news_content.dart';
import 'settings_content.dart';
import 'videos_content.dart';

class HomePageObject {
  HomePageObject(this._driver) {
    newsContent = NewsContent(_driver);
    competitorsContent = CompetitorsContent(_driver);
    videosContent = VideosContent(_driver);
    settingsContent = SettingsContent(_driver);
  }

  NewsContent newsContent;
  CompetitorsContent competitorsContent;
  VideosContent videosContent;
  SettingsContent settingsContent;

  final FlutterDriver _driver;

  final _homePageFinder = find.byValueKey('home_page');

  final _newsTabFinder = find.byValueKey('news_tab');
  final _competitorsTabFinder = find.byValueKey('competitor_tab');
  final _videosTabFinder = find.byValueKey('videos_tab');
  final _settingsTabFinder = find.byValueKey('settings_tab');

  Future<void> isReady({Duration timeout}) =>
      _driver.waitFor(_homePageFinder, timeout: timeout);

  Future<void> gotoNews({Duration timeout}) =>
      _driver.tap(_newsTabFinder, timeout: timeout);

  Future<void> gotoCompetitors({Duration timeout}) =>
      _driver.tap(_competitorsTabFinder, timeout: timeout);

  Future<void> gotoVideos({Duration timeout}) =>
      _driver.tap(_videosTabFinder, timeout: timeout);

  Future<void> gotoSettings({Duration timeout}) =>
      _driver.tap(_settingsTabFinder, timeout: timeout);
}
