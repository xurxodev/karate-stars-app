import 'package:flutter/material.dart';

class CompetitorsScreen extends StatefulWidget {
  @override
  _CompetitorsScreenState createState() => _CompetitorsScreenState();
}

class _CompetitorsScreenState extends State<CompetitorsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: const Text('Competitors'),
        ),
    );
  }
}
