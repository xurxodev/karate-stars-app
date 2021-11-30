import 'package:flutter/cupertino.dart';
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
import 'package:karate_stars_app/src/news/domain/entities/current.dart';
import 'package:karate_stars_app/src/news/domain/entities/live_video_news.dart';
import 'package:karate_stars_app/src/news/domain/entities/news.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';
import 'package:karate_stars_app/src/news/presentation/blocs/news_bloc.dart';
import 'package:karate_stars_app/src/news/presentation/states/news_state.dart';
import 'package:karate_stars_app/src/news/presentation/widgets/item_current_news.dart';
import 'package:karate_stars_app/src/news/presentation/widgets/item_live_video_news.dart';
import 'package:karate_stars_app/src/news/presentation/widgets/item_social_news.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class NewsPageView extends StatefulWidget {
  const NewsPageView() : super(key: const Key(Keys.news_page_view));

  @override
  _NewsPageViewState createState() => _NewsPageViewState();
}

class _NewsPageViewState extends State<NewsPageView>
    with AutomaticKeepAliveClientMixin<NewsPageView> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final NewsBloc bloc = BlocProvider.of<NewsBloc>(context);

    return StreamBuilder<NewsState>(
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
                context, state.listState as LoadedState<List<News>>, bloc);
          }
        } else {
          return const Text('No data');
        }
      },
    );
  }

  // ignore: missing_return
  Widget _renderNews(
      BuildContext context, LoadedState<List<News>> state, NewsBloc bloc) {
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
                    itemCount: state.data.length,
                    adBuilder: (context) => Ad(
                        adUnitId: AdsHelper.newsNativeAdUnitId,
                        margin: calculateItemNewsMargin(context)),
                    itemBuilder: (context, index) {
                      final News news = state.data[index];

                      final textKey = '${Keys.news_item}_$index';

                      if (news is LiveVideoNews) {
                        return ItemLiveVideoNews(liveVideoNews: news);
                      } else if (news is SocialNews) {
                        return ItemSocialNews(news, itemTextKey: textKey);
                      } else {
                        return ItemCurrentNews(news as CurrentNews,
                            itemTextKey: textKey);
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
