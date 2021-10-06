import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter/material.dart';
import 'package:karate_stars_app/app_di.dart' as app_di;
import 'package:karate_stars_app/src/common/keys.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_provider.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/actions/FilterAction.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/platform/platform_alert_dialog.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/competitors/presentation/blocs/competitors_bloc.dart';
import 'package:karate_stars_app/src/competitors/presentation/widgets/competitor_filters.dart';
import 'package:karate_stars_app/src/competitors/presentation/widgets/competitors_page_view.dart';
import 'package:karate_stars_app/src/news/presentation/blocs/news_bloc.dart';
import 'package:karate_stars_app/src/news/presentation/widgets/news_filter.dart';
import 'package:karate_stars_app/src/news/presentation/widgets/news_page_view.dart';
import 'package:karate_stars_app/src/settings/views/settings_page_view.dart';
import 'package:karate_stars_app/src/videos/presentation/blocs/videos_bloc.dart';
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
    final leading = getLeading();
    final title = getTitle();
    final actions = getActions();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: leading,
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
        activeColor: Theme.of(context).colorScheme.secondary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.view_quilt,
              key: Key(Keys.home_news_tab),
            ),
          ),
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
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              key: Key(Keys.home_settings_tab),
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

    if (_currentTab == 0) {
      return Text(titleText,
          key: titleKey,
          style: const TextStyle(fontFamily: 'Billabong', fontSize: 30));
    } else {
      return Text(titleText,
          key: titleKey,
          style: TextStyle(
              fontSize: Theme.of(context).textTheme.headline6!.fontSize));
    }
  }

  List<cupertino.Widget> getActions() {
    if (_currentTab == 0) {
      return [
        FilterAction(
          key: const Key(Keys.news_filter_action),
          tooltip: Strings.news_filters_title,
          onPressed: () {
            final NewsBloc bloc = BlocProvider.of<NewsBloc>(context);

            showDialog(
                context: context,
                builder: (_) => PlatformAlertDialog(
                    title: Strings.news_filters_title,
                    content: NewsFilter(bloc: bloc)));
          },
        ),
      ];
    } else if (_currentTab == 1) {
      return [
        FilterAction(
          key: const Key(Keys.competitor_filter_action),
          tooltip: Strings.competitor_filters_title,
          onPressed: () {
            final CompetitorsBloc bloc =
                BlocProvider.of<CompetitorsBloc>(context);

            showDialog(
                context: context,
                builder: (_) => PlatformAlertDialog(
                    title: Strings.competitor_filters_title,
                    content: CompetitorFilters(bloc: bloc)));
          },
        ),
      ];
    } else if (_currentTab == 2) {
      return [];
    } else {
      return [];
    }
  }

  Widget? getLeading() {
    if (_currentTab == 0) {
      return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/logo.png'));
    } else {
      return null;
    }
  }
}
