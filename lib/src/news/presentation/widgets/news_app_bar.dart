import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/app/app_bloc.dart';
import 'package:karate_stars_app/src/app/app_state.dart';
import 'package:karate_stars_app/src/common/keys.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_provider.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/RoundedCard.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/default_stream_builder.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/platform/platform_icons.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/platform/platform_single_menu.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/events/presentation/pages/events_page.dart';
import 'package:karate_stars_app/src/purchases/presentation/page/purchases_page.dart';
import 'package:karate_stars_app/src/rankings/presentation/pages/rankings_page.dart';
import 'package:karate_stars_app/src/search/presentation/page/search_page.dart';
import 'package:karate_stars_app/src/settings/presentation/page/settings_page.dart';

class NewsAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);

    return DefaultStateStreamBuilder<AppStateData>(
        initialData: appBloc.state,
        stream: appBloc.observableState,
        builder: (context, snapshot) {
          final isPremium =
              (snapshot.data as LoadedState<AppStateData>).data.isPremium;

          return _renderAppBar(context, isPremium);
        });
  }

  AppBar _renderAppBar(BuildContext context, bool isPremium) {
    return AppBar(
        centerTitle: false,
        leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/logo.png')),
        title: const Text(Strings.home_appbar_title_default,
            key: Key(Keys.home_appbar_title),
            style: TextStyle(fontFamily: 'Billabong', fontSize: 30)),
        actions: [
          RoundedCard(
              color: Colors.grey[100],
              padding: EdgeInsets.zero,
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              child: TextButton(
                  onPressed: () {
                    PurchasesPage.navigate(context);
                  },
                  child: isPremium
                      ? Text(Strings.home_appbar_premium_action,
                          style: Theme.of(context)
                              .textTheme
                              .button
                              ?.copyWith(color: Colors.green))
                      : Text(Strings.home_appbar_non_premium_action,
                          style: Theme.of(context)
                              .textTheme
                              .button
                              ?.copyWith(color: Colors.red)))),
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                SearchPage.navigate(context);
              }),
          PlatformSingleMenu(menuItems: [
            SingleMenuItem(Strings.home_menu_events, Icons.calendar_today,
                () => EventsPage.navigate(context)),
            SingleMenuItem(
                Strings.home_menu_rankings,
                Icons.leaderboard_outlined,
                () => RankingsPage.navigate(context)),
            SingleMenuItem(Strings.home_menu_settings, PlatformIcons.settings,
                () => SettingsPage.navigate(context)),
          ]),
        ]);
  }
}
