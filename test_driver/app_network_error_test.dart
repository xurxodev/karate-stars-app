// Imports the Flutter Driver API

import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'page_objects/home/home_page_object.dart';


void main() {
  group('app empty', () {
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

    group('news', () {
      test('should show connection error message', () async {
        await homePage.assertTitle('Karate Stars');
        await homePage.newsContent.assertIsVisible();
      });
    });
  });
}
