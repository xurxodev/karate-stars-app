import 'package:flutter_driver/flutter_driver.dart';
import 'package:karate_stars_app/src/common/keys.dart';

class CompetitorsContent {
  CompetitorsContent(this.driver);

  FlutterDriver driver;

  final competitorsPageViewFinder = find.byValueKey(Keys.competitors_page_view);

  Future<void> assertIsVisible({Duration timeout}) =>
      driver.waitFor(competitorsPageViewFinder);
}
