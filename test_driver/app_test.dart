// Imports the Flutter Driver API

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  const homePageId = 'home_page';

  const newsPageViewId = 'news_page_view';
  const competitorsPageViewId = 'competitors_page_view';
  const videosPageViewId = 'videos_page_view';
  const settingsPageViewId = 'settings_page_view';

  const newsTabId = 'news_tab';
  const competitorTabId = 'competitor_tab';
  const videosTabId = 'videos_tab';
  const settingsTabId = 'settings_tab';

  group('home page ', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('should be visible', () async {
      await driver.waitFor(find.byValueKey(homePageId));
    });

    test('should has news page view visible by default', () async {
      await driver.waitFor(find.byValueKey(newsPageViewId));
    });

    test('should show news page view to click on the bottom tab', () async {
      await driver.waitFor(find.byValueKey(homePageId));

      await driver.tap(find.byValueKey(competitorTabId));
      await driver.tap(find.byValueKey(newsTabId));

      await driver.waitFor(find.byValueKey(newsPageViewId));
    });

    test('should show competitors page view to click on the bottom tab', () async {
      await driver.waitFor(find.byValueKey(homePageId));

      await driver.tap(find.byValueKey(competitorTabId));

      await driver.waitFor(find.byValueKey(competitorsPageViewId));
    });

    test('should show videos page view to click on the bottom tab', () async {
      await driver.waitFor(find.byValueKey(homePageId));

      await driver.tap(find.byValueKey(videosTabId));

      await driver.waitFor(find.byValueKey(videosPageViewId));
    });

    test('should show settings page view to click on the bottom tab', () async {
      await driver.waitFor(find.byValueKey(homePageId));

      await driver.tap(find.byValueKey(settingsTabId));

      await driver.waitFor(find.byValueKey(settingsPageViewId));
    });
  });
}