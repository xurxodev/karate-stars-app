import 'package:flutter_driver/flutter_driver.dart';

class VideosContent {
  VideosContent(this.driver);

  FlutterDriver driver;

  final videosPageViewFinder = find.byValueKey('videos_page_view');

  Future<void> isVisible({Duration timeout}) =>
      driver.waitFor(videosPageViewFinder);
}
