import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:karate_stars_app/src/common/custom_colors.dart';
import 'package:karate_stars_app/src/home/presentation/pages/home_page.dart';

class App extends StatelessWidget {
  static const String title = 'Karate Stars';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          primaryIconTheme: const IconThemeData(color: Colors.red),
          scaffoldBackgroundColor: Colors.grey[300],
          colorScheme: ColorScheme.fromSwatch(primarySwatch: whiteMaterial)
              .copyWith(secondary: Colors.red, brightness: Brightness.light)),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryIconTheme: const IconThemeData(color: Colors.red),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: Colors.red, brightness: Brightness.dark),
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => HomePage.create(),
      },
    );
  }
}
