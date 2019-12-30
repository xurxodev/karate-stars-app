import 'package:flutter/material.dart';
import 'package:karate_stars_app/dependencies_provider.dart' as di;
import 'package:karate_stars_app/src/app.dart';
import 'package:karate_stars_app/src/common/data/database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final AppDatabase appDatabase =
      await $FloorAppDatabase.databaseBuilder('karate_stars.db').build();

  di.init(appDatabase);

  runApp(App());
}
