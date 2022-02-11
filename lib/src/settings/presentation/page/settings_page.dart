import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_provider.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/common/presentation/states/option.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/Progress.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/filters/SegmentedFilter.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/notification_message.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/settings/presentation/blocs/settings_bloc.dart';
import 'package:karate_stars_app/src/settings/presentation/states/settings_state.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends StatelessWidget {
  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SettingsBloc>(context);

    bloc.visitScreen();

    return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            title: Text(Strings.settings_title,
                style: TextStyle(
                    fontSize:
                        Theme.of(context).textTheme.headline6!.fontSize))),
        body: SafeArea(
            child: StreamBuilder<SettingsState>(
          initialData: bloc.state,
          stream: bloc.observableState,
          builder: (context, snapshot) {
            final state = snapshot.data;

            if (state != null) {
              if (state is LoadingState) {
                return Progress();
              } else if (state is ErrorState) {
                final listState = state as ErrorState;
                return Center(
                  child: NotificationMessage(listState.message),
                );
              } else {
                return _renderSettings(context,
                    (state as LoadedState<SettingsStateData>).data, bloc);
              }
            } else {
              return const Text('No Data');
            }
          },
        )));
  }

  Widget _renderSettings(
      BuildContext context, SettingsStateData stateData, SettingsBloc bloc) {

    return SettingsList(
      lightTheme: const SettingsThemeData(titleTextColor:  Color.fromRGBO(109, 109, 114, 1)),
      darkTheme:const SettingsThemeData(titleTextColor: CupertinoColors.systemGrey),
      sections: [
        SettingsSection(
          title:  Text(Strings.settings_app_section.toUpperCase()),
          tiles: [
            SettingsTile(
              title: const Text(Strings.settings_app_version),
              value: Text(stateData.version),
            ),
          ],
        ),
        SettingsSection(
          title:  Text(Strings.settings_appearance_section.toUpperCase()),
          tiles: [
            SettingsTile(
          leading: const Icon(CupertinoIcons.device_phone_portrait),
              title: SegmentedOptions(
                options: stateData.brightnessOptions,
                onValueChanged: (Option option) {
                  bloc.selectBrightness(option);
                },
                value: stateData.selectedBrightnessOption,
              ),
            ),
          ],
        ),
        SettingsSection(
          title:  Text(Strings.settings_notifications_section.toUpperCase()),
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
          ],
        ),

      ],
    );
  }
}
