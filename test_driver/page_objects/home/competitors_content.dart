import 'package:flutter_driver/flutter_driver.dart';

class CompetitorsContent {
  CompetitorsContent(this.driver);

  FlutterDriver driver;

  final competitorsPageViewFinder = find.byValueKey('competitors_page_view');

  Future<void> isVisible({Duration timeout}) =>
      driver.waitFor(competitorsPageViewFinder);
}
