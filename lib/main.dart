import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:karate_stars_app/app_di.dart' as app_di;
import 'package:karate_stars_app/src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //default filename is .env
  await dotenv.load();

  await app_di.init();

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(App.create());
}

void mainWithoutDataDependencies() {
  app_di.initWithoutDataDependencies();

  runApp(App.create());
}
