import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:karate_stars_app/app_di.dart' as app_di;
import 'package:karate_stars_app/src/ads/ad.dart';
import 'package:karate_stars_app/src/ads/ads_helper.dart';
import 'package:karate_stars_app/src/ads/ads_listview.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_provider.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/Progress.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/notification_message.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/rankings/presentation/blocs/rankings_entries_bloc.dart';
import 'package:karate_stars_app/src/rankings/presentation/state/ranking_entries_state.dart';
import 'package:karate_stars_app/src/rankings/presentation/widgets/item_ranking_entry.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class RankingEntriesArgs {
  final String rankingId;
  final String categoryId;
  final ReadPolicy readPolicy;

  RankingEntriesArgs(
      {required this.rankingId,
      required this.categoryId,
      this.readPolicy = ReadPolicy.cache_first});
}

class RankingEntriesPage extends StatelessWidget {
  final RankingEntriesArgs args;

  const RankingEntriesPage(this.args);

  static void navigate(BuildContext context,
      {required RankingEntriesArgs arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  static Widget create(RankingEntriesArgs args) {
    return BlocProvider(
        bloc: app_di.getIt<RankingEntriesBloc>(),
        child: RankingEntriesPage(args));
  }

  static const routeName = '/ranking-entries';

  @override
  Widget build(BuildContext context) {
    final RankingEntriesBloc bloc =
        BlocProvider.of<RankingEntriesBloc>(context);

    bloc.init(
        rankingId: args.rankingId,
        categoryId: args.categoryId,
        readPolicy: args.readPolicy);

    return Scaffold(
        appBar: _appBar(context, bloc),
        body: SafeArea(
            child: StreamBuilder<RankingEntriesState>(
                initialData: bloc.state,
                stream: bloc.observableState,
                builder: (context, snapshot) {
                  final state = snapshot.data;

                  if (state != null) {
                    if (state.content is LoadingState) {
                      return Progress();
                    } else if (state.content is ErrorState) {
                      final listState = state.content as ErrorState;
                      return Center(
                          child: NotificationMessage(listState.message));
                    } else {
                      final content =
                          state.content as LoadedState<RankingEntriesContent>;

                      return _renderList(context, content.data, bloc);
                    }
                  } else {
                    return const Text('No Data');
                  }
                })));
  }

  AppBar _appBar(BuildContext context, RankingEntriesBloc bloc) {
    final titleContent = (RankingEntriesContent content) {
      return Row(children: [
        CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: CachedNetworkImageProvider(content.ranking.image)),
        const SizedBox(width: 16.0),
        Flexible(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(content.ranking.name,
                style: TextStyle(
                    fontSize:
                        Theme.of(context).textTheme.titleMedium!.fontSize)),
            const SizedBox(height: 4),
            Text(content.category.name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: Theme.of(context).textTheme.caption!.fontSize))
          ],
        )),
      ]);
    };

    return AppBar(
      centerTitle: false,
      titleSpacing: 0,
      title: StreamBuilder<RankingEntriesState>(
          initialData: bloc.state,
          stream: bloc.observableState,
          builder: (context, snapshot) {
            final state = snapshot.data;

            if (state != null && state.content is LoadedState) {
              final content =
                  state.content as LoadedState<RankingEntriesContent>;

              return titleContent(content.data);
            } else {
              return Container();
            }
          }),
      actions: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/logo.png',width: 24,))
      ],
    );
  }

  Widget _renderList(BuildContext context, RankingEntriesContent content,
      RankingEntriesBloc bloc) {
    if (content.entries.isEmpty) {
      return const NotificationMessage(Strings.rankings_entries_empty_message);
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: LiquidPullToRefresh(
            borderWidth: 2,
            color: Theme.of(context).scaffoldBackgroundColor,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            showChildOpacityTransition: false,
            child: AdsListView(
              itemCount: content.entries.length,
              adBuilder: (context) =>
                  Ad(adUnitId: AdsHelper.videosNativeAdUnitId),
              itemBuilder: (context, index) {
                final entry = content.entries[index];

                return ItemRankingEntry(rankingEntry: entry);
              },
            ),
            onRefresh: () => bloc.refresh()),
      );
    }
  }
}
