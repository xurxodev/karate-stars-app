import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

class NewsContent {
  final FlutterDriver _driver;

  NewsContent(this._driver);

  final newsPageViewFinder = find.byValueKey('news_page_view');
  final notificationFinder = find.byValueKey('notification_message');

  Future<void> assertIsVisible({Duration timeout}) =>
      _driver.waitFor(newsPageViewFinder);

  Future<void> assertNotificationMessage(String expectedMessage) async =>
      await _driver.runUnsynchronized(() async {
        expect(await _driver.getText(notificationFinder), expectedMessage);
      });
}
