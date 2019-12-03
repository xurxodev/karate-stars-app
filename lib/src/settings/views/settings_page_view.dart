import 'package:flutter/material.dart';

class SettingsPageView extends StatefulWidget {
  const SettingsPageView() : super(key: const Key(id));

  static const id = 'settings_page_view';

  @override
  _SettingsPageViewState createState() => _SettingsPageViewState();
}

class _SettingsPageViewState extends State<SettingsPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: const Center(
        child: Text('Settings'),
        ),
    );
  }
}
