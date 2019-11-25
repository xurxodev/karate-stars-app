import 'package:flutter/material.dart';

class NewsScreen extends StatefulWidget {
  static final String id = 'feed_screen';

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Text('News'),
        ),
    );
  }
}
