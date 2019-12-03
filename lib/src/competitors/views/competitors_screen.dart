import 'package:flutter/material.dart';

class CompetitorsPageView extends StatefulWidget {
  const CompetitorsPageView() : super(key: const Key(id));

  static const id = 'competitors_page_view';

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
