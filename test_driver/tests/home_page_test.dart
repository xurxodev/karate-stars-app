import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../page_objects/home/home_page_object.dart';

void homePageTests() {
  const newsPageViewId = 'news_page_view';
  const competitorsPageViewId = 'competitors_page_view';
  const videosPageViewId = 'videos_page_view';
  const settingsPageViewId = 'settings_page_view';

  const newsTabId = 'news_tab';
  const competitorTabId = 'competitor_tab';
  const videosTabId = 'videos_tab';
  const settingsTabId = 'settings_tab';

  group('home page', () {
    FlutterDriver driver;
    HomePageObject homePage;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
      homePage = HomePageObject(driver);
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('should be visible', () async {
      homePage.isReady();
    });

    test('should has news page view visible by default', () async {
      await homePage.isReady();
      await homePage.newsContent.isVisible();
    });

    test('should show news page view to click on the bottom tab', () async {
      await homePage.isReady();

      await homePage.gotoCompetitors();
      await homePage.gotoNews();
      await homePage.newsContent.isVisible();
    });

    test('should show competitors page view to click on the bottom tab',
        () async {
          await homePage.isReady();

          await homePage.gotoCompetitors();
          await homePage.competitorsContent.isVisible();
    });

    test('should show videos page view to click on the bottom tab', () async {
      await homePage.isReady();

      await homePage.gotoVideos();
      await homePage.videosContent.isVisible();
    });

    test('should show settings page view to click on the bottom tab', () async {
      await homePage.isReady();

      await homePage.gotoSettings();
      await homePage.settingsContent.isVisible();
    });
  });
}
