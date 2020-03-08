import 'package:flutter/material.dart';
import 'package:karate_stars_app/dependencies_provider.dart' as di;
import 'package:karate_stars_app/src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  runApp(App());
}

