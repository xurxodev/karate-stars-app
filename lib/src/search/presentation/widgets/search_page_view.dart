import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/keys.dart';
import 'package:karate_stars_app/src/common/strings.dart';

class SearchPageView extends StatefulWidget {
  const SearchPageView() : super(key: const Key(Keys.search_page_view));

  @override
  _SearchPageViewState createState() => _SearchPageViewState();
}

class _SearchPageViewState extends State<SearchPageView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: Strings.search_news_title),
                Tab(text: Strings.search_competitor_title),
                Tab(text: Strings.search_videos_title),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              Text(Strings.search_news_title),
              Text(Strings.search_competitor_title),
              Text(Strings.search_videos_title),
            ],
          ),
        ));
  }
}
