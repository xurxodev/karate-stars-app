import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter/material.dart';
import 'package:karate_stars_app/app_di.dart' as app_di;
import 'package:karate_stars_app/src/common/keys.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_provider.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/platform_alert_dialog.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/competitors/widgets/competitors_page_view.dart';
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
      bloc: app_di.getIt<NewsBloc>(),
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

  int _currentTab = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    final leading = getLeading();
    final title = getTitle();
    final actions = getActions();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading:  leading,
        title: title,
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
              key: const Key(Keys.home_news_tab),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
              key: const Key(Keys.home_competitors_tab),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.video_library,
              key: const Key(Keys.home_videos_tab),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              key: const Key(Keys.home_settings_tab),
            ),
          ),
        ],
      ),
    );
  }

  Widget getTitle() {
    String titleText = '';

    if (_currentTab == 0) {
      titleText = Strings.home_appbar_title_default;
    } else if (_currentTab == 1) {
      titleText = Strings.home_appbar_title_competitors;
    } else if (_currentTab == 2) {
      titleText = Strings.home_appbar_title_videos;
    } else {
      titleText = Strings.home_appbar_title_settings;
    }
    const Key titleKey = Key(Keys.home_appbar_title);

    if (_currentTab == 0){
      return Text(titleText,
          key: titleKey,
          style: const TextStyle(fontFamily: 'Billabong', fontSize: 30));
    }else {
      return Text(titleText,
          key: titleKey,
          style:
          TextStyle(fontSize: Theme.of(context).textTheme.title.fontSize));
    }
  }

  List<cupertino.Widget> getActions() {
    if (_currentTab == 0) {
      return [
        IconButton(
          key: Key(Keys.home_filter),
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

  Widget getLeading() {
    if (_currentTab == 0) {
      return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/logo.png'));
    } else {
      return null;
    }
  }
}
