import 'package:flutter_driver/flutter_driver.dart';
import 'package:karate_stars_app/src/common/keys.dart';
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

    _driver.waitUntilNoTransientCallbacks();
  }

  final _titleFinder = find.byValueKey(Keys.home_appbar_title);

  Future<void> assertTitle(String expectedTitle) async =>
      await _driver.runUnsynchronized(() async {
        expect(await _driver.getText(_titleFinder), expectedTitle);
      });

  Future<void> gotoNews() => _driver.tap(find.byValueKey(Keys.home_news_tab));

  Future<void> gotoCompetitors() =>
      _driver.tap(find.byValueKey(Keys.home_competitors_tab));

  Future<void> gotoVideos() => _driver.tap(find.byValueKey(Keys.home_videos_tab));

  Future<void> gotoSettings() => _driver.tap(find.byValueKey(Keys.home_settings_tab));
}
