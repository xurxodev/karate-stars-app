import 'package:flutter/material.dart';

class VideosScreen extends StatefulWidget {
  static final String id = 'feed_screen';

  @override
  _VideosScreenState createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Text('Videos'),
        ),
    );
  }
}
