import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter/material.dart';
import 'package:karate_stars_app/app_di.dart' as app_di;
import 'package:karate_stars_app/src/common/keys.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_provider.dart';
import 'package:karate_stars_app/src/competitors/presentation/blocs/competitors_bloc.dart';
import 'package:karate_stars_app/src/competitors/presentation/widgets/competitors_app_bar.dart';
import 'package:karate_stars_app/src/competitors/presentation/widgets/competitors_page_view.dart';
import 'package:karate_stars_app/src/home/presentation/blocs/home_bloc.dart';
import 'package:karate_stars_app/src/home/presentation/widgets/home_page_view.dart';
import 'package:karate_stars_app/src/news/presentation/widgets/news_app_bar.dart';
import 'package:karate_stars_app/src/push_notifications/push_notification_handler.dart';
import 'package:karate_stars_app/src/videos/presentation/blocs/videos_bloc.dart';
import 'package:karate_stars_app/src/videos/presentation/widgets/videos_app_bar.dart';
import 'package:karate_stars_app/src/videos/presentation/widgets/videos_page_view.dart';

class MainPage extends StatefulWidget {
  static const routeName = '/';
  static const id = 'home_page';

  const MainPage() : super(key: const Key(id));

  static Widget create(bool testing) {
    final providersAndHome = BlocProvider(
        bloc: app_di.getIt<HomeBloc>(),
        child: BlocProvider(
            bloc: app_di.getIt<CompetitorsBloc>(),
            child: BlocProvider(
                bloc: app_di.getIt<VideosBloc>(), child: const MainPage())));

    return !testing
        ? PushNotificationsHandler(child: providersAndHome)
        : providersAndHome;
  }

  @override
  _MainPageState createState() => _MainPageState();

  static _MainPageState? of(BuildContext context) {
    return context.findAncestorStateOfType();
  }
}

class _MainPageState extends State<MainPage> {
  int _currentTab = 0;
  late PageController _pageController;
  final ScrollController _newsScrollController = ScrollController();
  final ScrollController _competitorsScrollController = ScrollController();
  final ScrollController _videosScrollController = ScrollController();

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
          children: <Widget>[
            HomePageView(controller: _newsScrollController, onTapShowAllVideos: (){
              _pageController.jumpToPage(2);
            },),
            //SearchPageView(),
            CompetitorsPageView(controller: _competitorsScrollController),
            VideosPageView(controller: _videosScrollController),
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
          if (_currentTab == index) {
            _scrollUp(index);
          }

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
      return NewsAppBar();
/*    } else if (_currentTab == 1) {
      return  SearchAppBar();*/
    } else if (_currentTab == 1) {
      return CompetitorsAppBar();
    } else {
      return VideosAppBar();
    }
  }

  void _scrollUp(index) {
    switch (index) {
      case 0:
        if (_newsScrollController.hasClients) {
          _newsScrollController.animateTo(
              _newsScrollController.position.minScrollExtent,
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn);
        }
        break;
      case 1:
        if (_competitorsScrollController.hasClients) {
          _competitorsScrollController.animateTo(
              _competitorsScrollController.position.minScrollExtent,
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn);
        }
        break;
      case 2:
        if (_videosScrollController.hasClients) {
          _videosScrollController.animateTo(
              _videosScrollController.position.minScrollExtent,
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn);
          break;
        }
    }
  }
}
