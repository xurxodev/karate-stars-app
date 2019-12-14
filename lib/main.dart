import 'package:flutter/material.dart';
import 'package:karate_stars_app/dependencies_provider.dart' as di;
import 'package:karate_stars_app/src/app.dart';

void main() async {
  di.init();

  runApp(App());
}
