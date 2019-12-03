import 'package:flutter/material.dart';

class NewsPageView extends StatefulWidget {

  const NewsPageView() : super(key: const Key(id));

  static const id = 'news_page_view';

  @override
  _NewsPageViewState createState() => _NewsPageViewState();
}

class _NewsPageViewState extends State<NewsPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: const Center(
        child: Text('News'),
        ),
    );
  }
}
