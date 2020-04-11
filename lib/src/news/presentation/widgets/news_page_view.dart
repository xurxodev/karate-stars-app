import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/keys.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_provider.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/notification_message.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/news/domain/entities/news.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';
import 'package:karate_stars_app/src/news/presentation/blocs/news_bloc.dart';
import 'package:karate_stars_app/src/news/presentation/states/news_state.dart';
import 'package:karate_stars_app/src/news/presentation/widgets/item_current_news.dart';
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final NewsBloc bloc = BlocProvider.of<NewsBloc>(context);

    return StreamBuilder<NewsState>(
      initialData: bloc.initialNews,
      stream: bloc.news,
      builder: (context, snapshot) {
        final state = snapshot.data;

        if (state is NewsLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is NewsErrorState) {
          return Center(
            child: NotificationMessage(state.message),
          );
        } else {
          return _renderNews(context, snapshot.data, bloc);
        }
      },
    );
  }

  // ignore: missing_return
  Widget _renderNews(
      BuildContext context, NewsLoadedState state, NewsBloc bloc) {
    if (state.news.isEmpty) {
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
                  itemBuilder: (context, index) {
                    final News news = state.news[index];

                    final textKey = '${Keys.news_item}_$index';

                    if (news is SocialNews) {
                      return ItemSocialNews(news, itemTextKey: textKey);
                    } else {
                      return ItemCurrentNews(news, itemTextKey: textKey);
                    }
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

  @override
  bool get wantKeepAlive => true;
}
