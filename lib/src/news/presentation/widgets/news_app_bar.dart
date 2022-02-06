import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/keys.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_provider.dart';
import 'package:karate_stars_app/src/common/presentation/functions/showPlatformDialog.dart';
import 'package:karate_stars_app/src/common/presentation/functions/url.dart'
    as url_helper;
import 'package:karate_stars_app/src/common/presentation/widgets/actions/FilterAction.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/platform/platform_alert_dialog.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/platform/platform_menu.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/news/presentation/blocs/news_bloc.dart';
import 'package:karate_stars_app/src/news/presentation/widgets/news_filter.dart';
import 'package:karate_stars_app/src/search/presentation/page/search_page.dart';
import 'package:karate_stars_app/src/settings/presentation/page/settings_page.dart';

class NewsAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final NewsBloc bloc = BlocProvider.of<NewsBloc>(context);

    return AppBar(
        centerTitle: false,
        leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/logo.png')),
        title: const Text(Strings.home_appbar_title_default,
            key: Key(Keys.home_appbar_title),
            style: TextStyle(fontFamily: 'Billabong', fontSize: 30)),
        actions: [
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.pushNamed(context, SearchPage.routeName);
              }),
          FilterAction(
            key: const Key(Keys.news_filter_action),
            tooltip: Strings.news_filters_title,
            onPressed: () {
              showPlatformDialog(
                  context: context,
                  builder: (_) => PlatformAlertDialog(
                      title: Strings.news_filters_title,
                      content: NewsFilter(bloc: bloc)));
            },
          ),
          PlatformMenu(),
        ]);
  }
}
