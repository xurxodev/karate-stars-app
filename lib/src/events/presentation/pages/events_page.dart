import 'package:flutter/material.dart';
import 'package:karate_stars_app/app_di.dart' as app_di;
import 'package:karate_stars_app/src/ads/ad.dart';
import 'package:karate_stars_app/src/ads/ads_helper.dart';
import 'package:karate_stars_app/src/ads/ads_listview.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_provider.dart';
import 'package:karate_stars_app/src/common/presentation/functions/showPlatformDialog.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/Progress.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/actions/FilterAction.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/notification_message.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/platform/platform_alert_dialog.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/events/domain/entities/event.dart';
import 'package:karate_stars_app/src/events/presentation/blocs/events_bloc.dart';
import 'package:karate_stars_app/src/events/presentation/state/events_state.dart';
import 'package:karate_stars_app/src/events/presentation/widgets/events_filters.dart';
import 'package:karate_stars_app/src/events/presentation/widgets/item_event.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class EventsPage extends StatelessWidget {
  static Widget create() {
    return BlocProvider(bloc: app_di.getIt<EventsBloc>(), child: EventsPage());
  }

  static const routeName = '/events';

  static void navigate(BuildContext context) {
    Navigator.pushNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    final EventsBloc bloc = BlocProvider.of<EventsBloc>(context);

    return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            titleSpacing: 0,
            title: Text(Strings.events_title,
                style: TextStyle(
                    fontSize: Theme.of(context).textTheme.headline6!.fontSize)),
            actions: [
              StreamBuilder<EventsState>(
                initialData: bloc.state,
                stream: bloc.observableState,
                builder: (context, snapshot) {
                  final state = snapshot.data;

                  return FilterAction(
                    tooltip: Strings.events_filters_title,
                    applied: state != null && state.filters.anyFilter,
                    onPressed: () {
                      showPlatformDialog(
                          context: context,
                          builder: (_) => PlatformAlertDialog(
                              title: Strings.events_filters_title,
                              content: EventsFilters(bloc: bloc)));
                    },
                  );
                },
              )
            ]),
        body: SafeArea(
            child: StreamBuilder<EventsState>(
          initialData: bloc.state,
          stream: bloc.observableState,
          builder: (context, snapshot) {
            final state = snapshot.data;

            if (state != null) {
              if (state.list is LoadingState) {
                return Progress();
              } else if (state.list is ErrorState) {
                final listState = state.list as ErrorState;
                return Center(child: NotificationMessage(listState.message));
              } else {
                return _renderList(
                    context, state.list as LoadedState<List<Event>>, bloc);
              }
            } else {
              return const Text('No Data');
            }
          },
        )));
  }

  Widget _renderList(
      BuildContext context, LoadedState<List<Event>> state, EventsBloc bloc) {
    print('videos' + state.data.length.toString());
    if (state.data.isEmpty) {
      return const NotificationMessage(Strings.videos_empty_message);
    } else {
      return Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: NotificationListener<ScrollUpdateNotification>(
            child: LiquidPullToRefresh(
                borderWidth: 2,
                color: Theme.of(context).scaffoldBackgroundColor,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                showChildOpacityTransition: false,
                child: AdsListView(
                  itemCount: state.data.length,
                  adBuilder: (context) =>
                      Ad(adUnitId: AdsHelper.eventsNativeAdUnitId),
                  itemBuilder: (context, index) {
                    final event = state.data[index];

                    return ItemEvent(event: event); //, itemTextKey: textKey);
                  },
                ),
                onRefresh: () => bloc.refresh()),
            onNotification: (notification) {
              bloc.registerInteraction();
              return true;
            },
          ));
    }
  }
}
