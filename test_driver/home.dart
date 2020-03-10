import 'package:flutter_driver/driver_extension.dart';
import 'package:karate_stars_app/main.dart' as main_app;

import 'snecarios/news_scenarios.dart';

void main() {
  // This line enables the extension
  enableFlutterDriverExtension();

  givenThereAreNoNews();

  // Call the `main()` function of your app or call `runApp` with any widget you
  // are interested in testing.
  main_app.main();
}


