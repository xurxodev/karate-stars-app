import 'package:flutter_driver/flutter_driver.dart';
import 'package:karate_stars_app/src/common/keys.dart';

class SearchContent {
  SearchContent(this.driver);

  FlutterDriver driver;

  final videosPageViewFinder = find.byValueKey(Keys.search_page_view);

  Future<void> assertIsVisible() => driver.waitFor(videosPageViewFinder);
}
