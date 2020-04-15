import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/keys.dart';

class CompetitorsPageView extends StatefulWidget {
  const CompetitorsPageView()
      : super(key: const Key(Keys.competitors_page_view));

  @override
  _CompetitorsPageViewState createState() => _CompetitorsPageViewState();
}

class _CompetitorsPageViewState extends State<CompetitorsPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: const Center(
        child: Text('Competitors'),
      ),
    );
  }
}
