import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:karate_stars_app/src/common/custom_colors.dart';
import 'package:karate_stars_app/src/home/presentation/pages/home_page.dart';
import 'package:karate_stars_app/src/videos/presentation/pages/video_player_page.dart';

class App extends StatelessWidget {
  static const String title = 'Karate Stars';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: whiteMaterial)
            .copyWith(secondary: Colors.red),
        scaffoldBackgroundColor: Colors.grey[300],
      ),
      darkTheme: ThemeData.dark().copyWith(
          colorScheme:
              const ColorScheme.dark().copyWith(secondary: Colors.red)),
      themeMode: ThemeMode.system,
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => HomePage.create(),
        VideoPlayerPage.routeName: (context) => VideoPlayerPage.create()
      },
    );
  }
}
