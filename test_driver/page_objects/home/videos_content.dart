import 'package:flutter_driver/flutter_driver.dart';
import 'package:karate_stars_app/src/common/keys.dart';

class VideosContent {
  VideosContent(this.driver);

  FlutterDriver driver;

  final videosPageViewFinder = find.byValueKey(Keys.videos_page_view);

  Future<void> assertIsVisible({Duration timeout}) =>
      driver.waitFor(videosPageViewFinder);
}
