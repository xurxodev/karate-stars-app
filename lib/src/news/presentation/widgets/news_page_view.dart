import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_provider.dart';
import 'package:karate_stars_app/src/news/domain/entities/news.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';
import 'package:karate_stars_app/src/news/presentation/blocs/news_bloc.dart';
import 'package:karate_stars_app/src/news/presentation/states/news_filter_state.dart';
import 'package:karate_stars_app/src/news/presentation/states/news_state.dart';
import 'package:karate_stars_app/src/news/presentation/widgets/item_current_news.dart';
import 'package:karate_stars_app/src/news/presentation/widgets/item_social_news.dart';

class NewsPageView extends StatefulWidget {
  static const id = 'news_page_view';

  const NewsPageView() : super(key: const Key(id));

  @override
  _NewsPageViewState createState() => _NewsPageViewState();
}

class _NewsPageViewState extends State<NewsPageView> {
  @override
  Widget build(BuildContext context) {
    final NewsBloc bloc = BlocProvider.of<NewsBloc>(context);

    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              margin: const EdgeInsets.all(16.0),
              width: 200,
              child: StreamBuilder<NewsFilterState>(
                initialData: bloc.initialFilter,
                stream: bloc.filter,
                builder: (context, snapshot) {
                  return _renderFilter(context, snapshot.data, bloc);
                },
              )),
          Expanded(
            child: StreamBuilder<NewsState>(
              initialData: bloc.initialNews,
              stream: bloc.news,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return _renderNews(context, snapshot.data);
                } else {
                  return Center(child: Text(snapshot.error.toString()));
                }
              },
            ),
          )
        ]);
  }

  Widget _renderFilter(
      BuildContext context, NewsFilterState state, NewsBloc bloc) {
    return CupertinoSlidingSegmentedControl(
      thumbColor: Theme.of(context).accentColor,
      children:
          state.filterOptions.map((key, value) => MapEntry(key, Text(value))),
      onValueChanged: (index) =>
          bloc.filterSink.add(NewsFilterState(selectedIndex: index)),
      groupValue: state.selectedIndex,
    );
  }

  // ignore: missing_return
  Widget _renderNews(BuildContext context, NewsState state) {
    if (state is Loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is Loaded) {
      return Container(
        child: ListView.builder(
          key: const PageStorageKey('news_list_view'),
          //important to maintain scroll
          itemCount: state.news.length,
          itemBuilder: (context, index) {
            final News news = state.news[index];

            if (news is SocialNews) {
              return ItemSocialNews(news);
            } else {
              return ItemCurrentNews(news);
            }
          },
        ),
      );
    }
  }
}
