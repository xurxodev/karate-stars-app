import 'package:flutter/material.dart';

class CompetitorsScreen extends StatefulWidget {
  static final String id = 'feed_screen';

  @override
  _CompetitorsScreenState createState() => _CompetitorsScreenState();
}

class _CompetitorsScreenState extends State<CompetitorsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Text('Competitors'),
        ),
    );
  }
}
