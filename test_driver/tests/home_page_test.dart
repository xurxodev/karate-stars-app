import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../page_objects/home/home_page_object.dart';

void homePageTests() {
  group('home page', () {
    FlutterDriver driver;
    HomePageObject homePage;

    setUpAll(() async {
      driver = await FlutterDriver.connect();

      homePage = HomePageObject(driver);

      //Seems this sleep is necessary by driver bug with async main
      sleep(const Duration(milliseconds: 1000));
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('should have correct title to open app', () async {
      await homePage.assertTitle('Karate Stars');
      await homePage.newsContent.assertIsVisible();
    });

    test('should has news page view visible by default', () async {
      await homePage.newsContent.assertIsVisible();
      await homePage.assertTitle('Karate Stars');
    });

    test('should show competitors page view to click on the bottom tab',
        () async {
          await homePage.gotoCompetitors();
          await homePage.competitorsContent.assertIsVisible();
          await homePage.assertTitle('Competitors');
    });

    test('should show videos page view to click on the bottom tab', () async {
      await homePage.gotoVideos();
      await homePage.videosContent.assertIsVisible();
      await homePage.assertTitle('Videos');
    });

    test('should show settings page view to click on the bottom tab', () async {
      await homePage.gotoSettings();
      await homePage.settingsContent.assertIsVisible();
      await homePage.assertTitle('Settings');
    });
  });
}
