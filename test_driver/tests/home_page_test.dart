import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void homePageTests() {
  group('home page', () {
    FlutterDriver driver;
    //HomePageObject homePage;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
      //homePage = HomePageObject(driver);
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('should be visible', () async {
      //homePage.isReady();
    });

   /* test('should has news page view visible by default', () async {
      await homePage.isReady();
      await homePage.newsContent.isVisible();
    });

    test('should show news page view to click on the bottom tab', () async {
      await homePage.isReady();

      await homePage.gotoCompetitors();
      await homePage.gotoNews();
      await homePage.newsContent.isVisible();
      expect(await homePage.appBarTitle(), 'Karate Stars');
    });

    test('should show competitors page view to click on the bottom tab',
        () async {
          await homePage.isReady();

          await homePage.gotoCompetitors();
          await homePage.competitorsContent.isVisible();
          expect(await homePage.appBarTitle(), 'Competitors');
    });

    test('should show videos page view to click on the bottom tab', () async {
      await homePage.isReady();

      await homePage.gotoVideos();
      await homePage.videosContent.isVisible();
      expect(await homePage.appBarTitle(), 'Videos');
    });

    test('should show settings page view to click on the bottom tab', () async {
      await homePage.isReady();

      await homePage.gotoSettings();
      await homePage.settingsContent.isVisible();
      expect(await homePage.appBarTitle(), 'Settings');
    });*/
  });
}
