import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  static final String id = 'feed_screen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Text('Settings'),
        ),
    );
  }
}
