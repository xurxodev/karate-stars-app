import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/ads/ad.dart';
import 'package:karate_stars_app/src/ads/ads_helper.dart';
import 'package:karate_stars_app/src/ads/ads_listview.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_provider.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/Progress.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/message.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/global_di.dart' as app_di;
import 'package:karate_stars_app/src/rankings/domain/entities/ranking.dart';
import 'package:karate_stars_app/src/rankings/presentation/blocs/rankings_bloc.dart';
import 'package:karate_stars_app/src/rankings/presentation/state/rankings_state.dart';
import 'package:karate_stars_app/src/rankings/presentation/widgets/item_ranking.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class RankingsPage extends StatelessWidget {
  static Widget create() {
    return BlocProvider(
        bloc: app_di.getIt<RankingsBloc>(), child: RankingsPage());
  }

  static const routeName = '/rankings';

  static void navigate(BuildContext context) {
    Navigator.pushNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    final RankingsBloc bloc = BlocProvider.of<RankingsBloc>(context);

    return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            titleSpacing: 0,
            title: Text(Strings.rankings_title,
                style: TextStyle(
                    fontSize:
                        Theme.of(context).textTheme.headline6!.fontSize))),
        body: SafeArea(
            child: StreamBuilder<RankingsState>(
          initialData: bloc.state,
          stream: bloc.observableState,
          builder: (context, snapshot) {
            final state = snapshot.data;

            if (state != null) {
              if (state.list is LoadingState) {
                return Progress();
              } else if (state.list is ErrorState) {
                final listState = state.list as ErrorState;
                return Message(
                  text: listState.message,
                  type: MessageType.error,
                );
              } else {
                return _renderList(
                    context, state.list as LoadedState<List<Ranking>>, bloc);
              }
            } else {
              return const Text('No Data');
            }
          },
        )));
  }

  Widget _renderList(BuildContext context, LoadedState<List<Ranking>> state,
      RankingsBloc bloc) {
    if (state.data.isEmpty) {
      return const Message(
        text: Strings.rankings_empty_message,
        type: MessageType.info,
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: LiquidPullToRefresh(
            borderWidth: 2,
            color: Theme.of(context).scaffoldBackgroundColor,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            showChildOpacityTransition: false,
            child: AdsListView(
              itemCount: state.data.length,
              adBuilder: (context) =>
                  Ad(adUnitId: AdsHelper.rankingsNativeAdUnitId),
              itemBuilder: (context, index) {
                final ranking = state.data[index];

                return ItemRanking(ranking: ranking); //, itemTextKey: textKey);
              },
            ),
            onRefresh: () => bloc.refresh()),
      );
    }
  }
}
