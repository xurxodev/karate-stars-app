import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/keys.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/platform/platform_icons.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/platform/platform_single_menu.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/events/presentation/pages/events_page.dart';
import 'package:karate_stars_app/src/rankings/presentation/pages/rankings_page.dart';
import 'package:karate_stars_app/src/search/presentation/page/search_page.dart';
import 'package:karate_stars_app/src/settings/presentation/page/settings_page.dart';

class NewsAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
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
                SearchPage.navigate(context);
              }),
          PlatformSingleMenu(menuItems: [
            SingleMenuItem(Strings.home_menu_events, Icons.calendar_today,
                () => EventsPage.navigate(context)),
            SingleMenuItem(Strings.home_menu_rankings, Icons.leaderboard_outlined,
                () => RankingsPage.navigate(context)),
            SingleMenuItem(Strings.home_menu_settings, PlatformIcons.settings,
                () => SettingsPage.navigate(context)),
          ]),
        ]);
  }
}
