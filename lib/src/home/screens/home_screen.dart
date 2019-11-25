import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/widgets/app_bar_title.dart';
import 'package:karate_stars_app/src/competitors/screens/competitors_screen.dart';
import 'package:karate_stars_app/src/news/screens/news_screen.dart';
import 'package:karate_stars_app/src/settings/screens/settings_screen.dart';
import 'package:karate_stars_app/src/videos/screens/videos_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTab = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: AppBarTitle()),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          NewsScreen(),
          CompetitorsScreen(),
          VideosScreen(),
          SettingsScreen(),
        ],
        onPageChanged: (int index) {
          setState(() {
            _currentTab = index;
          });
        },
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _currentTab,
        onTap: (int index) {
          setState(() {
            _currentTab = index;
          });
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeIn,
          );
        },
        activeColor: Colors.red,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.view_quilt,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.video_library,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
          ),
        ],
      ),
    );
  }
}
