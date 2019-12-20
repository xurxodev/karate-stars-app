import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter/material.dart';
import 'package:karate_stars_app/dependencies_provider.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_provider.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/app_bar_title.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/platform_alert_dialog.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/competitors/views/competitors_screen.dart';
import 'package:karate_stars_app/src/news/presentation/blocs/news_bloc.dart';
import 'package:karate_stars_app/src/news/presentation/widgets/news_filter.dart';
import 'package:karate_stars_app/src/news/presentation/widgets/news_page_view.dart';
import 'package:karate_stars_app/src/settings/views/settings_page_view.dart';
import 'package:karate_stars_app/src/videos/widgets/videos_page_view.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/';
  static const id = 'home_page';

  const HomePage() : super(key: const Key(id));

  static Widget create() {
    return BlocProvider<NewsBloc>(
      bloc: getIt<NewsBloc>(),
      child: const HomePage(),
    );
  }

  @override
  _HomePageState createState() => _HomePageState();

  static _HomePageState of(BuildContext context) {
    return context.findAncestorStateOfType();
  }
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
    final actions = getActions();

    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(title, _currentTab == 0),
        actions: actions,
      ),
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
      bottomNavigationBar: cupertino.CupertinoTabBar(
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
        activeColor: Theme.of(context).accentColor,
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

  List<cupertino.Widget> getActions() {
    if (_currentTab == 0) {
      return [
        IconButton(
          icon: Icon(Icons.filter_list),
          onPressed: () {
            final NewsBloc bloc = BlocProvider.of<NewsBloc>(context);

            showDialog(
                context: context,
                builder: (_) => PlatformAlertDialog(
                    title:  Strings.news_filters_title,
                    content: NewsFilter(bloc: bloc)));
          },
        ),
      ];
    } else if (_currentTab == 1) {
      return [];
    } else if (_currentTab == 2) {
      return [];
    } else {
      return [];
    }
  }
}
