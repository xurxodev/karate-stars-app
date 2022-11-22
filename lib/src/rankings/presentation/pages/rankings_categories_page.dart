import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/ads/ad.dart';
import 'package:karate_stars_app/src/ads/ads_helper.dart';
import 'package:karate_stars_app/src/ads/ads_listview.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_provider.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/Progress.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/message.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/search_app_bar.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/global_di.dart' as app_di;
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

class RankingCategoriesPage extends StatefulWidget {
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
  State<RankingCategoriesPage> createState() => _RankingCategoriesPageState();
}

class _RankingCategoriesPageState extends State<RankingCategoriesPage> {
  bool searching = false;

  @override
  Widget build(BuildContext context) {
    final RankingCategoriesBloc bloc =
        BlocProvider.of<RankingCategoriesBloc>(context);

    bloc.init(
        rankingId: widget.args.rankingId, readPolicy: widget.args.readPolicy);

    return Scaffold(
        appBar: searching
            ? SearchAppBar(onChanged: (query) {
                bloc.search(query);
              }, onCancel: () {
                setState(() {
                  searching = false;
                });
              })
            : _appBar(context, bloc),
        body: SafeArea(
            child: StreamBuilder<RankingCategoriesState>(
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
                          child: Message(
                        text: listState.message,
                        type: MessageType.error,
                      ));
                    } else {
                      final content = state.content
                          as LoadedState<RankingCategoriesContent>;

                      return _renderList(context, content.data, bloc);
                    }
                  } else {
                    return const Text('No Data');
                  }
                })));
  }

  AppBar _appBar(BuildContext context, RankingCategoriesBloc bloc) {
    final titleContent = (RankingCategoriesContent content) {
      return Row(
        children: [
          CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage:
                  CachedNetworkImageProvider(content.ranking.image)),
          const SizedBox(width: 16.0),
          Text(content.ranking.name,
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.headline6!.fontSize))
        ],
      );
    };

    return AppBar(
      centerTitle: false,
      titleSpacing: 0,
      title: StreamBuilder<RankingCategoriesState>(
          initialData: bloc.state,
          stream: bloc.observableState,
          builder: (context, snapshot) {
            final state = snapshot.data;

            if (state != null && state.content is LoadedState) {
              final content =
                  state.content as LoadedState<RankingCategoriesContent>;

              return titleContent(content.data);
            } else {
              return Container();
            }
          }),
      actions: [
        IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              setState(() {
                searching = true;
              });
            }),
      ],
    );
  }

  Widget _renderList(BuildContext context, RankingCategoriesContent content,
      RankingCategoriesBloc bloc) {
    if (content.categories.isEmpty) {
      return const Message(
        text: Strings.rankings_categories_empty_message,
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
              itemCount: content.categories.length,
              adBuilder: (context) =>
                  Ad(adUnitId: AdsHelper.rankingCategoriesNativeAdUnitId),
              itemBuilder: (context, index) {
                final category = content.categories[index];

                if (category is RankingCategoryParentState) {
                  return ListTile(
                      title: Text(
                    category.name,
                    style: Theme.of(context).textTheme.headline6,
                  ));
                } else {
                  return ItemRankingCategory(
                      rankingId: content.ranking.id,
                      category: category as RankingCategoryLeafState);
                }

                //, itemTextKey: textKey);
              },
            ),
            onRefresh: () => bloc.refresh()),
      );
    }
  }
}
