import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karate_stars_app/app_di.dart' as app_di;
import 'package:karate_stars_app/src/common/keys.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_provider.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/Progress.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/notification_message.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/competitors/presentation/states/competitors_state.dart';
import 'package:karate_stars_app/src/competitors/presentation/widgets/item_competitor.dart';
import 'package:karate_stars_app/src/news/domain/entities/current.dart';
import 'package:karate_stars_app/src/news/domain/entities/news.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';
import 'package:karate_stars_app/src/news/presentation/widgets/item_current_news.dart';
import 'package:karate_stars_app/src/news/presentation/widgets/item_social_news.dart';
import 'package:karate_stars_app/src/search/presentation/blocs/search_bloc.dart';
import 'package:karate_stars_app/src/search/presentation/states/search_state.dart';
import 'package:karate_stars_app/src/search/presentation/widgets/search_app_bar.dart';
import 'package:karate_stars_app/src/videos/domain/entities/video.dart';
import 'package:karate_stars_app/src/videos/presentation/pages/video_player_page.dart';
import 'package:karate_stars_app/src/videos/presentation/widgets/item_video.dart';

class SearchPage extends StatelessWidget {
  static const routeName = '/search';

  static Widget create() {
    return BlocProvider(bloc: app_di.getIt<SearchBloc>(), child: SearchPage());
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SearchBloc>(context);

    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: SearchAppBar(),
            body: SafeArea(
                child: StreamBuilder<SearchState>(
              initialData: bloc.state,
              stream: bloc.observableState,
              builder: (context, snapshot) {
                final state = snapshot.data;

                if (state != null) {
                  if (state is InitialState) {
                    return const NotificationMessage(
                        Strings.search_initial_message);
                  } else if (state is SearchingState) {
                    return Progress();
                  } else if (state is SearchErrorState) {
                    final errorState = state;
                    return Center(
                      child: NotificationMessage(errorState.message),
                    );
                  } else {
                    return _renderResults(context,
                        (state as ResultsState<SearchStateData>).data, bloc);
                  }
                } else {
                  return const Text('No Data');
                }
              },
            ))));
  }

  Widget _renderResults(
      BuildContext context, SearchStateData stateData, SearchBloc bloc) {
    return TabBarView(
      children: [
        _newsResults(stateData.newsResults),
        _competitorResults(stateData.competitorResults),
        _videoResults(stateData.videosResults),
      ],
    );
  }

  Widget _newsResults(List<News> newsResults) {
    if (newsResults.isEmpty) {
      return const NotificationMessage(Strings.search_empty_message);
    } else {
      return Container(
          padding: const EdgeInsets.only(top: 8.0),
          child: ListView.builder(
            itemCount: newsResults.length,
            itemBuilder: (context, index) {
              final News news = newsResults[index];

              final textKey = '${Keys.news_item}_$index';

              if (news is SocialNews) {
                return ItemSocialNews(news, itemTextKey: textKey);
              } else {
                return ItemCurrentNews(news as CurrentNews,
                    itemTextKey: textKey);
              }
            },
          ));
    }
  }

  Widget _competitorResults(List<CompetitorItemState> competitorResults) {
    if (competitorResults.isEmpty) {
      return const NotificationMessage(
          Strings.search_empty_message);
    } else {
      return Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: ListView.builder(
            itemCount: competitorResults.length,
            itemBuilder: (context, index) {
              final competitor = competitorResults[index];

              final textKey = '${Keys.competitors_item}_$index';

              return ItemCompetitor(
                competitor,
                itemTextKey: textKey,
                margin: const EdgeInsets.symmetric(vertical: 4.0),
              );
            },
          ));
    }
  }

  Widget _videoResults(List<Video> videoResults) {
    if (videoResults.isEmpty) {
      return const NotificationMessage(
          Strings.search_empty_message);
    } else {
      return Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: ListView.builder(
            itemCount: videoResults.length,
            itemBuilder: (context, index) {
              final video = videoResults[index];

              //final textKey = '${Keys.competitors_item}_$index';

              return ItemVideo(video: video, onTap: () async {
                Navigator.pushNamed(context, VideoPlayerPage.routeName,
                    arguments: video.id);
              },);
            },
          ));
    }
  }
}


