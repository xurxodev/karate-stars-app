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
import 'package:karate_stars_app/src/rankings/presentation/blocs/rankings_categories_bloc.dart';
import 'package:karate_stars_app/src/rankings/presentation/state/ranking_categories_state.dart';
import 'package:karate_stars_app/src/rankings/presentation/widgets/item_ranking_category.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class RankingCategoriesArgs {
  final String rankingId;
  final ReadPolicy readPolicy;

  RankingCategoriesArgs(
      {required this.rankingId, this.readPolicy = ReadPolicy.cache_first});
}

class RankingCategoriesPage extends StatelessWidget {
  final RankingCategoriesArgs args;

  const RankingCategoriesPage(this.args);

  static void navigate(BuildContext context,
      {required RankingCategoriesArgs arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  static Widget create(RankingCategoriesArgs args) {
    return BlocProvider(
        bloc: app_di.getIt<RankingCategoriesBloc>(),
        child: RankingCategoriesPage(args));
  }

  static const routeName = '/ranking-categories';

  @override
  Widget build(BuildContext context) {
    final RankingCategoriesBloc bloc =
        BlocProvider.of<RankingCategoriesBloc>(context);

    bloc.init(rankingId: args.rankingId, readPolicy: args.readPolicy);

    return StreamBuilder<RankingCategoriesState>(
      initialData: bloc.state,
      stream: bloc.observableState,
      builder: (context, snapshot) {
        final state = snapshot.data;

        if (state != null) {
          if (state.content is LoadingState) {
            return Progress();
          } else if (state.content is ErrorState) {
            final listState = state.content as ErrorState;
            return Center(child: NotificationMessage(listState.message));
          } else {
            final content =
                state.content as LoadedState<RankingCategoriesContent>;

            return Scaffold(
                appBar: AppBar(
                    centerTitle: false,
                    title: Row(
                      children: [
                        CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: CachedNetworkImageProvider(
                                content.data.ranking.image)),
                        const SizedBox(width: 16.0),
                        Text(content.data.ranking.name,
                            style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .fontSize))
                      ],
                    )),
                body:
                    SafeArea(child: _renderList(context, content.data, bloc)));
          }
        } else {
          return const Text('No Data');
        }
      },
    );
  }

  Widget _renderList(BuildContext context, RankingCategoriesContent content,
      RankingCategoriesBloc bloc) {
    if (content.categories.isEmpty) {
      return const NotificationMessage(
          Strings.rankings_categories_empty_message);
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: LiquidPullToRefresh(
            borderWidth: 2,
            color: Theme.of(context).scaffoldBackgroundColor,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            showChildOpacityTransition: false,
            child: AdsListView(
              itemCount: content.categories.length,
              adBuilder: (context) =>
                  Ad(adUnitId: AdsHelper.videosNativeAdUnitId),
              itemBuilder: (context, index) {
                final category = content.categories[index];

                return ItemRankingCategory(
                    category: category); //, itemTextKey: textKey);
              },
            ),
            onRefresh: () => bloc.refresh()),
      );
    }
  }
}
