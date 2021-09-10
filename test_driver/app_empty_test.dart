// Imports the Flutter Driver API

import 'package:flutter_driver/flutter_driver.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:test/test.dart';

import 'page_objects/home/home_page_object.dart';



void main() {
  group('app empty', () {
    late FlutterDriver driver;
    late HomePageObject homePage;

    setUpAll(() async {
      driver = await FlutterDriver.connect();

      homePage = HomePageObject(driver);
    });

    tearDownAll(() async {
        driver.close();
    });

    group('news', () {
      test('should have correct title to open app', () async {
        await homePage.assertTitle(Strings.home_appbar_title_default);
        await homePage.newsContent.assertIsVisible();
      });

      test('should has news page view visible by default', () async {
        await homePage.newsContent.assertIsVisible();
        await homePage.assertTitle(Strings.home_appbar_title_default);
      });

      test('should show empty message', () async {
        await homePage.assertTitle('Karate Stars');
        await homePage.newsContent
            .assertNotificationMessage(Strings.news_empty_message);
      });
    });

    group('competitors', () {
      test('should show competitors page view to click on the bottom tab',
          () async {
        await homePage.gotoCompetitors();
        await homePage.competitorsContent.assertIsVisible();
        await homePage.assertTitle('Competitors');
      });
    });

    group('videos', () {
      test('should show videos page view to click on the bottom tab', () async {
        await homePage.gotoVideos();
        await homePage.videosContent.assertIsVisible();
        await homePage.assertTitle('Videos');
      });
    });

    group('settings', () {
      test('should show settings page view to click on the bottom tab',
          () async {
        await homePage.gotoSettings();
        await homePage.settingsContent.assertIsVisible();
        await homePage.assertTitle('Settings');
      });
    });
  });
}
