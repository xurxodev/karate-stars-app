import 'package:flutter/material.dart';

class VideosScreen extends StatefulWidget {

  @override
  _VideosScreenState createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: const Text('Videos'),
        ),
    );
  }
}
