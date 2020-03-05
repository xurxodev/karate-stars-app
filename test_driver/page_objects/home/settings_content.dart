import 'package:flutter_driver/flutter_driver.dart';

class SettingsContent {
  SettingsContent(this.driver);

  FlutterDriver driver;

  final videosPageViewFinder = find.byValueKey('settings_page_view');

  Future<void> assertIsVisible({Duration timeout}) =>
      driver.waitFor(videosPageViewFinder);
}
