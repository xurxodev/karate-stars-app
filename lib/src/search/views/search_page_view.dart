import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/keys.dart';

class SearchPageView extends StatefulWidget {
  const SearchPageView() : super(key: const Key(Keys.search_page_view));

  @override
  _SearchPageViewState createState() => _SearchPageViewState();
}

class _SearchPageViewState extends State<SearchPageView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Text('Search'),
      ),
    );
  }
}
