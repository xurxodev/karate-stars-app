import 'package:flutter_driver/flutter_driver.dart';

class HomePageObject {
  final FlutterDriver _driver;

  HomePageObject(this._driver) {
/*    newsContent = NewsContent(_driver);
    competitorsContent = CompetitorsContent(_driver);
    videosContent = VideosContent(_driver);
    settingsContent = SettingsContent(_driver);*/
  }

/*
  NewsContent newsContent;
  CompetitorsContent competitorsContent;
  VideosContent videosContent;
  SettingsContent settingsContent;
*/

/*  final _homePageFinder = find.byValueKey('home_page');

  final _newsTabFinder = find.byValueKey('news_tab');
  final _competitorsTabFinder = find.byValueKey('competitor_tab');
  final _videosTabFinder = find.byValueKey('videos_tab');
  final _settingsTabFinder = find.byValueKey('settings_tab');*/

  final _titleFinder = find.byValueKey('app_bar_title');

  Future<String> title() => _driver.getText(_titleFinder);

/*  Future<void> isReady({Duration timeout}) =>
      _driver.waitFor(_homePageFinder, timeout: timeout);

  Future<void> gotoNews({Duration timeout}) =>
      _driver.tap(_newsTabFinder, timeout: timeout);

  Future<void> gotoCompetitors({Duration timeout}) =>
      _driver.tap(_competitorsTabFinder, timeout: timeout);

  Future<void> gotoVideos({Duration timeout}) =>
      _driver.tap(_videosTabFinder, timeout: timeout);

  Future<void> gotoSettings({Duration timeout}) =>
      _driver.tap(_settingsTabFinder, timeout: timeout);*/
}
