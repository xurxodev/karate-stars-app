import 'package:flutter/material.dart';
import 'package:karate_stars_app/app_di.dart' as app_di;
import 'package:karate_stars_app/src/ads/ad.dart';
import 'package:karate_stars_app/src/ads/ads_helper.dart';
import 'package:karate_stars_app/src/ads/ads_listview.dart';
import 'package:karate_stars_app/src/ads/interstitial_ad.dart';
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

class SearchPage extends StatefulWidget {
  static const routeName = '/search';

  static void navigate(BuildContext context) {
    Navigator.pushNamed(context, routeName);
  }

  static Widget create() {
    return BlocProvider(bloc: app_di.getIt<SearchBloc>(), child: SearchPage());
  }

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  final ScrollController _newsScrollController = ScrollController();
  final ScrollController _competitorsScrollController = ScrollController();
  final ScrollController _videosScrollController = ScrollController();
  late PlayVideoInterstitialAd _playVideoInterstitialAd;

  @override
  void initState() {
    super.initState();
    _playVideoInterstitialAd = PlayVideoInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SearchBloc>(context);

    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: SearchAppBar(onTap: _scrollUp),
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
          child: AdsListView(
            controller: _newsScrollController,
            itemCount: newsResults.length,
            adBuilder: (context) =>
                Ad(adUnitId: AdsHelper.searchNewsNativeAdUnitId),
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
      return const NotificationMessage(Strings.search_empty_message);
    } else {
      return Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: AdsListView(
            controller: _competitorsScrollController,
            itemCount: competitorResults.length,
            adBuilder: (context) =>
                Ad(adUnitId: AdsHelper.searchCompetitorsNativeAdUnitId),
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
      return const NotificationMessage(Strings.search_empty_message);
    } else {
      return Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: AdsListView(
            controller: _videosScrollController,
            adBuilder: (context) =>
                Ad(adUnitId: AdsHelper.searchVideosNativeAdUnitId),
            itemCount: videoResults.length,
            itemBuilder: (context, index) {
              final video = videoResults[index];

              return ItemVideo(
                video: video,
                onTap: () async {
                  _playVideoInterstitialAd.show();
                  VideoPlayerPage.navigate(context,
                      arguments:
                          VideoPlayerPageArgs(videoId: video.id));
                },
              );
            },
          ));
    }
  }

  void _scrollUp(index) {
    switch (index) {
      case 0:
        if (_newsScrollController.hasClients) {
          _newsScrollController.animateTo(
              _newsScrollController.position.minScrollExtent,
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn);
        }
        break;
      case 1:
        if (_competitorsScrollController.hasClients) {
          _competitorsScrollController.animateTo(
              _competitorsScrollController.position.minScrollExtent,
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn);
        }
        break;
      case 2:
        if (_videosScrollController.hasClients) {
          _videosScrollController.animateTo(
              _videosScrollController.position.minScrollExtent,
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn);
          break;
        }
    }
  }

  @override
  void dispose() {
    _newsScrollController.dispose();
    _competitorsScrollController.dispose();
    _videosScrollController.dispose();
    _playVideoInterstitialAd.dispose();
    super.dispose();
  }
}
