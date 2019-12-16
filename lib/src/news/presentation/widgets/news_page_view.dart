import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_provider.dart';
import 'package:karate_stars_app/src/news/domain/entities/news.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';
import 'package:karate_stars_app/src/news/presentation/blocs/news_bloc.dart';
import 'package:karate_stars_app/src/news/presentation/states/news_state.dart';
import 'package:karate_stars_app/src/news/presentation/widgets/item_current_news.dart';
import 'package:karate_stars_app/src/news/presentation/widgets/item_social_news.dart';

class NewsPageView extends StatefulWidget {
  static const id = 'news_page_view';

  const NewsPageView(): super(key: const Key(id));

  @override
  _NewsPageViewState createState() => _NewsPageViewState();
}

class _NewsPageViewState extends State<NewsPageView> {

  @override
  Widget build(BuildContext context) {
    final NewsBloc bloc = BlocProvider.of<NewsBloc>(context);

    return StreamBuilder<NewsState>(
      initialData: bloc.initialState,
      stream: bloc.news,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return renderState(context, snapshot.data);
        } else  {
          return Center(child: Text(snapshot.error.toString()));
        }
      },
    );
  }

  ScrollController _scrollController;

  // ignore: missing_return
  Widget renderState(BuildContext context, NewsState state) {

    if (state is Loading){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    else if (state is Loaded){

      return Container(
        child: ListView.builder(
          key: const PageStorageKey('news_list_view'), //important to maintain scroll
          controller: _scrollController,
          itemCount: state.news.length,
          itemBuilder: (context, index) {
            final News news = state.news[index];

            if (news is SocialNews){
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
