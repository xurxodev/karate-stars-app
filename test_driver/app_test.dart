// Imports the Flutter Driver API

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('home screen ', () {
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
      await driver.waitFor(find.byValueKey('home_screen'));
    });

    test('should has news page view visible by default', () async {
      await driver.waitFor(find.byValueKey('news_page_view'));
    });

  });
}