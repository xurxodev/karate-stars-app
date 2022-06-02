import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/ads/ad.dart';
import 'package:karate_stars_app/src/ads/ads_helper.dart';
import 'package:karate_stars_app/src/ads/ads_listview.dart';
import 'package:karate_stars_app/src/common/keys.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_provider.dart';
import 'package:karate_stars_app/src/common/presentation/functions/calculate_item_news_margin.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/Progress.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/notification_message.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/home/presentation/blocs/home_bloc.dart';
import 'package:karate_stars_app/src/home/presentation/states/home_state.dart';
import 'package:karate_stars_app/src/home/presentation/widgets/home_last_videos_item.dart';
import 'package:karate_stars_app/src/home/presentation/widgets/home_top_news_item.dart';
import 'package:karate_stars_app/src/news/domain/entities/current.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';
import 'package:karate_stars_app/src/news/presentation/page/current_news_page.dart';
import 'package:karate_stars_app/src/news/presentation/widgets/item_current_news.dart';
import 'package:karate_stars_app/src/news/presentation/widgets/item_social_news.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HomePageView extends StatefulWidget {
  final ScrollController? controller;
  final VoidCallback? onTapShowAllVideos;

  const HomePageView({this.controller, this.onTapShowAllVideos})
      : super(key: const Key(Keys.home_page_view));

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView>
    with AutomaticKeepAliveClientMixin<HomePageView> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final HomeBloc bloc = BlocProvider.of<HomeBloc>(context);

    return StreamBuilder<HomeState>(
      initialData: bloc.state,
      stream: bloc.observableState,
      builder: (context, snapshot) {
        final state = snapshot.data;

        if (state != null) {
          if (state.listState is LoadingState) {
            return Progress();
          } else if (state.listState is ErrorState) {
            final listState = state.listState as ErrorState;
            return Center(
              child: NotificationMessage(listState.message),
            );
          } else {
            return _renderNews(
                context, state.listState as LoadedState<List<HomeItem>>, bloc);
          }
        } else {
          return const Text('No data');
        }
      },
    );
  }

  Widget _renderNews(
      BuildContext context, LoadedState<List<HomeItem>> state, HomeBloc bloc) {
    if (state.data.isEmpty) {
      return const NotificationMessage(Strings.news_empty_message);
    } else {
      return Container(
          padding: const EdgeInsets.only(top: 8.0),
          child: NotificationListener<ScrollUpdateNotification>(
            child: LiquidPullToRefresh(
                key: const Key(Keys.news_items_parent),
                borderWidth: 2,
                color: Theme.of(context).scaffoldBackgroundColor,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                showChildOpacityTransition: false,
                child: AdsListView(
                    controller: widget.controller,
                    itemCount: state.data.length,
                    adBuilder: (context) => Ad(
                        adUnitId: AdsHelper.newsNativeAdUnitId,
                        margin: calculateItemNewsMargin(context)),
                    itemBuilder: (context, index) {
                      final HomeItem homeItem = state.data[index];

                      final textKey = '${Keys.news_item}_$index';

                      if (homeItem is HomeTopNewsItem) {
                        return ItemHomeTopNews(
                          topNews: homeItem.content,
                          onTapShowAll: () {
                            CurrentNewsPage.navigate(context);
                          },
                        );
                      } else if (homeItem is HomeLastVideoItem) {
                        return ItemHomeLastVideo(
                          lastVideos: homeItem.content,
                          onTapShowAll: widget.onTapShowAllVideos,
                        );
                      } else if (homeItem.content is SocialNews) {
                        return ItemSocialNews(homeItem.content,
                            itemTextKey: textKey);
                      } else {
                        return ItemCurrentNews( currentNews: homeItem.content as CurrentNews,
                            itemTextKey: textKey, type: CurrentNewsType.big,);
                      }
                    }),
                onRefresh: () async {
                  bloc.refresh();
                }),
            onNotification: (notification) {
              bloc.registerInteraction();
              return true;
            },
          ));
    }
  }

  @override
  bool get wantKeepAlive => true;
}
