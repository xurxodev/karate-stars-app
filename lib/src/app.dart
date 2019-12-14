import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:karate_stars_app/dependencies_provider.dart';
import 'package:karate_stars_app/src/common/custom_colors.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_provider.dart';
import 'package:karate_stars_app/src/home/presentation/pages/home_page.dart';
import 'package:karate_stars_app/src/news/presentation/blocs/news_bloc.dart';

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
          scaffoldBackgroundColor: Colors.grey[300]),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.red,
      ),
      home: homePage(),
    );
  }

  Widget homePage() {
    return BlocProvider<NewsBloc>(
      bloc: getIt<NewsBloc>(),
      child: const HomePage(),
    );
  }
}
