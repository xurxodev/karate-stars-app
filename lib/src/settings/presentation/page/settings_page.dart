import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_provider.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/common/presentation/states/option.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/Progress.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/filters/FilterGroup.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/filters/SegmentedFilter.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/notification_message.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/settings/presentation/blocs/settings_bloc.dart';
import 'package:karate_stars_app/src/settings/presentation/states/settings_state.dart';

class SettingsPage extends StatelessWidget {
  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SettingsBloc>(context);

    bloc.visitScreen();

    return Scaffold(
        backgroundColor: Theme.of(context).cardColor,
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
    return
      Padding(padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),child:Column(
        children: [
          FilterGroup(
            label: Strings.settings_brightness,
            child: Container(
                width: double.infinity,
                child: SegmentedOptions(
                  options: stateData.brightnessOptions,
                  onValueChanged: (Option option) {
                    bloc.selectBrightness(option);
                  },
                  value: stateData.selectedBrightnessOption,
                )),
          ),
        ],
      ) ,);
  }
}
