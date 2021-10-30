import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter/material.dart';
import 'package:karate_stars_app/app_di.dart' as app_di;
import 'package:karate_stars_app/src/common/keys.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_provider.dart';
import 'package:karate_stars_app/src/competitors/presentation/blocs/competitors_bloc.dart';
import 'package:karate_stars_app/src/competitors/presentation/widgets/competitors_app_bar.dart';
import 'package:karate_stars_app/src/competitors/presentation/widgets/competitors_page_view.dart';
import 'package:karate_stars_app/src/news/presentation/blocs/news_bloc.dart';
import 'package:karate_stars_app/src/news/presentation/widgets/news_app_bar.dart';
import 'package:karate_stars_app/src/news/presentation/widgets/news_page_view.dart';
import 'package:karate_stars_app/src/videos/presentation/blocs/videos_bloc.dart';
import 'package:karate_stars_app/src/videos/presentation/widgets/videos_app_bar.dart';
import 'package:karate_stars_app/src/videos/presentation/widgets/videos_page_view.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/';
  static const id = 'home_page';

  const HomePage() : super(key: const Key(id));

  static Widget create() {
    return BlocProvider(
        bloc: app_di.getIt<NewsBloc>(),
        child: BlocProvider(
            bloc: app_di.getIt<CompetitorsBloc>(),
            child: BlocProvider(
                bloc: app_di.getIt<VideosBloc>(), child: const HomePage())));
  }

  @override
  _HomePageState createState() => _HomePageState();

  static _HomePageState? of(BuildContext context) {
    return context.findAncestorStateOfType();
  }
}

class _HomePageState extends State<HomePage> {
  int _currentTab = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: getAppBar(),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          children: const <Widget>[
            NewsPageView(),
            //SearchPageView(),
            CompetitorsPageView(),
            VideosPageView(),
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
        activeColor: Theme.of(context).colorScheme.secondary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              key: Key(Keys.home_news_tab),
            ),
          ),
  /*        BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              key: Key(Keys.home_search_tab),
            ),
          ),*/
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
              key: Key(Keys.home_competitors_tab),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.video_library,
              key: Key(Keys.home_videos_tab),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget getAppBar() {
    if (_currentTab == 0) {
      return  NewsAppBar();
/*    } else if (_currentTab == 1) {
      return  SearchAppBar();*/
    } else if (_currentTab == 1) {
      return CompetitorsAppBar();
    } else {
      return VideosAppBar();
    }
  }
}
