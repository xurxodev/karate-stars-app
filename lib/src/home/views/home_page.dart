import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/common/widgets/app_bar_title.dart';
import 'package:karate_stars_app/src/competitors/views/competitors_screen.dart';
import 'package:karate_stars_app/src/news/views/news_page_view.dart';
import 'package:karate_stars_app/src/settings/views/settings_page_view.dart';
import 'package:karate_stars_app/src/videos/views/videos_page_view.dart';

class HomePage extends StatefulWidget {
  const HomePage() : super(key: const Key(id));

  static const id = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const newsTabId = 'news_tab';
  static const competitorTabId = 'competitor_tab';
  static const videosTabId = 'videos_tab';
  static const settingsTabId = 'settings_tab';

  int _currentTab = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    final title = getTitle();

    return Scaffold(
      appBar: AppBar(title: AppBarTitle(title, _currentTab == 0)),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          children: const <Widget>[
            NewsPageView(),
            CompetitorsPageView(),
            VideosPageView(),
            SettingsPageView(),
          ],
          onPageChanged: (int index) {
            setState(() {
              _currentTab = index;
            });
          },
        ),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _currentTab,
        onTap: (int index) {
          setState(() {
            _currentTab = index;
          });
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeIn,
          );
        },
        activeColor: Colors.red,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.view_quilt,
              key: const Key(newsTabId),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
              key: const Key(competitorTabId),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.video_library,
              key: const Key(videosTabId),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              key: const Key(settingsTabId),
            ),
          ),
        ],
      ),
    );
  }

  String getTitle() {
    if (_currentTab == 0) {
      return Strings.home_appbar_title_default;
    } else if (_currentTab == 1) {
      return Strings.home_appbar_title_competitors;
    } else if (_currentTab == 2) {
      return Strings.home_appbar_title_videos;
    } else {
      return Strings.home_appbar_title_settings;
    }
  }
}
