import 'package:flutter/material.dart';
import 'package:karate_stars_app/dependencies_provider.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_provider.dart';
import 'package:karate_stars_app/src/news/domain/entities/news.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';
import 'package:karate_stars_app/src/news/presentation/blocs/news_bloc.dart';
import 'package:karate_stars_app/src/news/presentation/widgets/item_current_news.dart';
import 'package:karate_stars_app/src/news/presentation/widgets/item_social_news.dart';

class NewsPageView extends StatefulWidget {
  static const id = 'news_page_view';

  const NewsPageView._(): super(key: const Key(id));

  static Widget create() {
    return BlocProvider<NewsBloc>(
      bloc: getIt<NewsBloc>(),
      child: const NewsPageView._(),
    );
  }

  @override
  _NewsPageViewState createState() => _NewsPageViewState();
}

class _NewsPageViewState extends State<NewsPageView> {
  @override
  Widget build(BuildContext context) {
    final NewsBloc bloc = BlocProvider.of<NewsBloc>(context);

    return StreamBuilder<List<News>>(
      stream: bloc.news,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return buildNewsList(context, snapshot.data);
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget buildNewsList(BuildContext context, List<News> data) {
    return Container(
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final News news = data[index];

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
