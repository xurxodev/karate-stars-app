import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:karate_stars_app/src/browser/presentation/pages/browser_page.dart';
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
          primarySwatch: whiteMaterial,
          accentColor: Colors.red,
          primaryIconTheme: IconThemeData(color: Colors.red),
          scaffoldBackgroundColor: Colors.grey[300]),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.red,
        primaryIconTheme: IconThemeData(color: Colors.red),
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => HomePage.create(),
        BrowserPage.routeName: (context) => BrowserPage.create(),
      },
    );
  }
}
