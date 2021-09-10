import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/keys.dart';

class SettingsPageView extends StatefulWidget {
  const SettingsPageView() : super(key: const Key(Keys.settings_page_view));

  @override
  _SettingsPageViewState createState() => _SettingsPageViewState();
}

class _SettingsPageViewState extends State<SettingsPageView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Text('Settings'),
      ),
    );
  }
}
