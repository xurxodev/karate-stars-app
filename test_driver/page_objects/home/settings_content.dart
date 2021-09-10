import 'package:flutter_driver/flutter_driver.dart';
import 'package:karate_stars_app/src/common/keys.dart';

class SettingsContent {
  SettingsContent(this.driver);

  FlutterDriver driver;

  final videosPageViewFinder = find.byValueKey(Keys.settings_page_view);

  Future<void> assertIsVisible() => driver.waitFor(videosPageViewFinder);
}
