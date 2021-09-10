import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:karate_stars_app/app_di.dart' as app_di;
import 'package:karate_stars_app/src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await app_di.init();

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(App());
}

void mainWithoutDataDependencies() {
  app_di.initWithoutDataDependencies();

  runApp(App());
}
