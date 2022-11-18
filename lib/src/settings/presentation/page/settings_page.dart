import 'dart:io';

import 'package:app_review/app_review.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/app/app_bloc.dart';
import 'package:karate_stars_app/src/app/app_state.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_provider.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/Progress.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/default_stream_builder.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/filters/SegmentedFilter.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/notification_message.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/platform/platform_icons.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/purchases/presentation/page/purchases_page.dart';
import 'package:karate_stars_app/src/settings/presentation/blocs/settings_bloc.dart';
import 'package:karate_stars_app/src/settings/presentation/states/settings_state.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:share_plus/share_plus.dart';

class SettingsPage extends StatelessWidget {
  static const routeName = '/settings';

  static void navigate(BuildContext context) {
    Navigator.pushNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    final settingsBloc = BlocProvider.of<SettingsBloc>(context);
    final appBloc = BlocProvider.of<AppBloc>(context);

    settingsBloc.visitScreen();

    return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            titleSpacing: 0,
            title: Text(Strings.settings_title,
                style: TextStyle(
                    fontSize:
                        Theme.of(context).textTheme.headline6!.fontSize))),
        body: SafeArea(child: renderContent(appBloc, settingsBloc)));
  }

  DefaultStateStreamBuilder<SettingsStateData> renderContent(
      AppBloc appBloc, SettingsBloc settingsBloc) {
    return DefaultStateStreamBuilder<SettingsStateData>(
        initialData: settingsBloc.state,
        stream: settingsBloc.observableState,
        builder: (context, snapshot) {
          final settingsState =
              (snapshot.data as LoadedState<SettingsStateData>).data;

          return DefaultStateStreamBuilder<AppStateData>(
              initialData: appBloc.state,
              stream: appBloc.observableState,
              builder: (context, snapshot) {
                final isPremium =
                    (snapshot.data as LoadedState<AppStateData>).data.isPremium;

                return _renderSettings(
                    context, isPremium, settingsState, settingsBloc);
              });
        });
  }

  Widget _renderSettings(BuildContext context, bool isPremium,
      SettingsStateData stateData, SettingsBloc bloc) {
    return SettingsList(
      lightTheme: const SettingsThemeData(
          titleTextColor: Color.fromRGBO(109, 109, 114, 1)),
      darkTheme:
          const SettingsThemeData(titleTextColor: CupertinoColors.systemGrey),
      sections: [
        SettingsSection(
          title: const Text('Karate Stars Pro'),
          tiles: [
            SettingsTile.navigation(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Yearly'),
              onPressed: (BuildContext context) async {
                //PurchasesExamplePage.navigate(context);
                PurchasesPage.navigate(context);
              },
              trailing: isPremium
                  ? const Icon(CupertinoIcons.check_mark_circled_solid,
                      color: Colors.green)
                  : Container(),
            ),
          ],
        ),
        SettingsSection(
          title: Text(Strings.settings_app_section.toUpperCase()),
          tiles: [
            SettingsTile(
              leading: const Icon(CupertinoIcons.app),
              title: const Text(Strings.settings_app_version),
              value: Text(stateData.version),
            ),
            SettingsTile.navigation(
              leading: const Icon(CupertinoIcons.heart_fill),
              title: const Text(Strings.settings_app_rate),
              onPressed: (BuildContext context) async {
                AppReview.storeListing;
                bloc.requestReview();
              },
            ),
            SettingsTile.navigation(
              leading: Icon(PlatformIcons.share),
              title: const Text(Strings.settings_app_share),
              onPressed: (BuildContext context) async {
                final box = context.findRenderObject() as RenderBox?;

                final url = Platform.isAndroid
                    ? 'https://play.google.com/store/apps/details?id=com.xurxodev.karatestars'
                    : 'https://apps.apple.com/app/karate-stars/id1611034977';

                bloc.shareApp(url);

                await Share.share(url,
                    sharePositionOrigin:
                        box!.localToGlobal(Offset.zero) & box.size);
              },
            ),
          ],
        ),
        SettingsSection(
          title: Text(Strings.settings_appearance_section.toUpperCase()),
          tiles: [
            SettingsTile(
              leading: const Icon(CupertinoIcons.device_phone_portrait),
              title: SegmentedOptions(
                options: stateData.brightnessOptions,
                onValueChanged: (String value) {
                  bloc.selectBrightness(value);
                },
                value: stateData.selectedBrightnessOption,
              ),
            ),
          ],
        ),
        SettingsSection(
          title: Text(Strings.settings_notifications_section.toUpperCase()),
          tiles: [
            SettingsTile.switchTile(
              title: const Text(Strings.settings_news_notifications),
              leading: const Icon(Icons.web_outlined),
              activeSwitchColor: Colors.red,
              initialValue: stateData.newsNotification,
              onToggle: (bool value) {
                bloc.selectNewsNotifications(value);
              },
            ),
            SettingsTile.switchTile(
              title: const Text(Strings.settings_competitors_notifications),
              leading: const Icon(Icons.person_outline),
              activeSwitchColor: Colors.red,
              initialValue: stateData.competitorNotification,
              onToggle: (bool value) {
                bloc.selectCompetitorNotifications(value);
              },
            ),
            SettingsTile.switchTile(
              title: const Text(Strings.settings_videos_notifications),
              leading: const Icon(Icons.video_library),
              activeSwitchColor: Colors.red,
              initialValue: stateData.videoNotification,
              onToggle: (bool value) {
                bloc.selectVideosNotifications(value);
              },
            ),
            SettingsTile.switchTile(
              title: const Text(Strings.settings_rankings_notifications),
              leading: const Icon(Icons.leaderboard_outlined),
              activeSwitchColor: Colors.red,
              initialValue: stateData.rankingNotification,
              onToggle: (bool value) {
                bloc.selectRankingNotifications(value);
              },
            ),
          ],
        ),
      ],
    );
  }
}
