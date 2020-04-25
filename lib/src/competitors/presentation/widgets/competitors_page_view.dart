import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/keys.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_provider.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/notification_message.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/competitors/domain/entities/competitor.dart';
import 'package:karate_stars_app/src/competitors/presentation/blocs/competitors_bloc.dart';
import 'package:karate_stars_app/src/competitors/presentation/states/competitors_state.dart';
import 'package:karate_stars_app/src/competitors/presentation/widgets/item_competitor.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class CompetitorsPageView extends StatefulWidget {
  const CompetitorsPageView()
      : super(key: const Key(Keys.competitors_page_view));

  @override
  _CompetitorsPageViewState createState() => _CompetitorsPageViewState();
}

class _CompetitorsPageViewState extends State<CompetitorsPageView>
    with AutomaticKeepAliveClientMixin<CompetitorsPageView> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final CompetitorsBloc bloc = BlocProvider.of<CompetitorsBloc>(context);

    return StreamBuilder<CompetitorsState>(
      initialData: bloc.state,
      stream: bloc.observableState,
      builder: (context, snapshot) {
        final state = snapshot.data;

        if (state.listState is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.listState is ErrorState) {
          final listState = state.listState as ErrorState;
          return Center(child: NotificationMessage(listState.message));
        } else {
          return _renderList(context, state.listState, bloc);
        }
      },
    );
  }

  // ignore: missing_return
  Widget _renderList(BuildContext context, LoadedState<List<Competitor>> state,
      CompetitorsBloc bloc) {
    if (state.data.isEmpty) {
      return const NotificationMessage(Strings.news_empty_message);
    } else {
      return Container(
          padding: const EdgeInsets.only(top: 8.0),
          child: NotificationListener<ScrollUpdateNotification>(
            child: LiquidPullToRefresh(
                key: const Key(Keys.news_items_parent),
                borderWidth: 2,
                color: Theme.of(context).cardColor,
                backgroundColor: Theme.of(context).accentColor,
                showChildOpacityTransition: false,
                child: ListView.builder(
                  itemCount: state.data.length,
                  itemBuilder: (context, index) {
                    final competitor = state.data[index];

                    final textKey = '${Keys.news_item}_$index';

                    return ItemCompetitor(competitor, itemTextKey: textKey);
                  },
                ),
                onRefresh: () => bloc.refresh()),
            onNotification: (notification) {
              //bloc.registerInteraction();
              return true;
            },
          ));
    }
  }

  @override
  bool get wantKeepAlive => true;
}
