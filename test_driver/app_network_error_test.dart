// Imports the Flutter Driver API
import 'package:flutter_driver/flutter_driver.dart';
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
      test('should show connection error message', () async {
        await homePage.assertTitle('Karate Stars');
        await homePage.newsContent.assertIsVisible();
      });
    });
  });
}
