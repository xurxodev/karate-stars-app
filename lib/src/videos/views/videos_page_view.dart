import 'package:flutter/material.dart';

class VideosPageView extends StatefulWidget {
  const VideosPageView() : super(key: const Key(id));

  static const id = 'videos_page_view';

  @override
  _VideosPageViewState createState() => _VideosPageViewState();
}

class _VideosPageViewState extends State<VideosPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: const Center(
        child: Text('Videos'),
        ),
    );
  }
}
