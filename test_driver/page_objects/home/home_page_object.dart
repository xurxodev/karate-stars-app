import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'competitors_content.dart';
import 'news_content.dart';
import 'settings_content.dart';
import 'videos_content.dart';

class HomePageObject {
  final FlutterDriver _driver;

  NewsContent newsContent;
  CompetitorsContent competitorsContent;
  VideosContent videosContent;
  SettingsContent settingsContent;

  HomePageObject(this._driver) {
    newsContent = NewsContent(_driver);
    competitorsContent = CompetitorsContent(_driver);
    videosContent = VideosContent(_driver);
    settingsContent = SettingsContent(_driver);
  }

  final _titleFinder = find.byValueKey('app_bar_title');

  Future<void> assertTitle(String expectedTitle) async =>
      await _driver.runUnsynchronized(() async {
        expect(await _driver.getText(_titleFinder), expectedTitle);
      });

  Future<void> gotoNews() => _driver.tap(find.byValueKey('news_tab'));

  Future<void> gotoCompetitors() =>
      _driver.tap(find.byValueKey('competitor_tab'));

  Future<void> gotoVideos() => _driver.tap(find.byValueKey('videos_tab'));

  Future<void> gotoSettings() => _driver.tap(find.byValueKey('settings_tab'));
}
