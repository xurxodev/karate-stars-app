import 'package:flutter/material.dart';
import 'package:karate_stars_app/app_di.dart' as app_di;
import 'package:karate_stars_app/src/ads/ad.dart';
import 'package:karate_stars_app/src/ads/ads_helper.dart';
import 'package:karate_stars_app/src/ads/ads_listview.dart';
import 'package:karate_stars_app/src/ads/interstitial_ad.dart';
import 'package:karate_stars_app/src/common/keys.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_provider.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
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
import 'package:karate_stars_app/src/search/presentation/widgets/search_page_search_app_bar.dart';
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
            appBar: SearchPageSearchAppBar(onTap: _scrollUp),
            body: SafeArea(
                child: StreamBuilder<SearchState>(
              initialData: bloc.state,
              stream: bloc.observableState,
              builder: (context, snapshot) {
                final state = snapshot.data;

                if (state != null) {
                  return _renderResults(context, state, bloc);
                } else {
                  return const Text('No Data');
                }
              },
            ))));
  }

  Widget _renderResults(
      BuildContext context, SearchState stateData, SearchBloc bloc) {
    return TabBarView(
      children: [
        _newsResults(stateData.news),
        _competitorResults(stateData.competitors),
        _videoResults(stateData.videos),
      ],
    );
  }

  Widget _newsResults(DefaultState<List<News>> newsResults) {
    if (newsResults is LoadingState) {
      return Progress();
    } else if (newsResults is ErrorState) {
      final errorState = newsResults as ErrorState;
      return Center(
        child: NotificationMessage(errorState.message),
      );
    } else {
      final news = (newsResults as LoadedState<List<News>>).data;

      if (news.isEmpty) {
        return const NotificationMessage(Strings.search_empty_message);
      } else {
        return Container(
            padding: const EdgeInsets.only(top: 8.0),
            child: AdsListView(
              controller: _newsScrollController,
              itemCount: news.length,
              adBuilder: (context) =>
                  Ad(adUnitId: AdsHelper.searchNewsNativeAdUnitId),
              itemBuilder: (context, index) {
                final News newsItem = news[index];

                final textKey = '${Keys.news_item}_$index';

                if (newsItem is SocialNews) {
                  return ItemSocialNews(newsItem, itemTextKey: textKey);
                } else {
                  return ItemCurrentNews(
                    currentNews: newsItem as CurrentNews,
                    itemTextKey: textKey,
                    type: CurrentNewsType.big,
                  );
                }
              },
            ));
      }
    }
  }

  Widget _competitorResults(
      DefaultState<List<CompetitorItemState>> competitorResults) {
    if (competitorResults is LoadingState) {
      return Progress();
    } else if (competitorResults is ErrorState) {
      final errorState = competitorResults as ErrorState;
      return Center(
        child: NotificationMessage(errorState.message),
      );
    } else {
      final competitors =
          (competitorResults as LoadedState<List<CompetitorItemState>>).data;
      if (competitors.isEmpty) {
        return const NotificationMessage(Strings.search_empty_message);
      } else {
        return Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: AdsListView(
              controller: _competitorsScrollController,
              itemCount: competitors.length,
              adBuilder: (context) =>
                  Ad(adUnitId: AdsHelper.searchCompetitorsNativeAdUnitId),
              itemBuilder: (context, index) {
                final competitor = competitors[index];

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
  }

  Widget _videoResults(DefaultState<List<Video>> videoResults) {
    if (videoResults is LoadingState) {
      return Progress();
    } else if (videoResults is ErrorState) {
      final errorState = videoResults as ErrorState;
      return Center(
        child: NotificationMessage(errorState.message),
      );
    } else {
      final videos = (videoResults as LoadedState<List<Video>>).data;

      if (videos.isEmpty) {
        return const NotificationMessage(Strings.search_empty_message);
      } else {
        return Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: AdsListView(
              controller: _videosScrollController,
              adBuilder: (context) =>
                  Ad(adUnitId: AdsHelper.searchVideosNativeAdUnitId),
              itemCount: videos.length,
              itemBuilder: (context, index) {
                final video = videos[index];

                return ItemVideo(
                  video: video,
                  onTap: () async {
                    _playVideoInterstitialAd.show();
                    VideoPlayerPage.navigate(context,
                        arguments: VideoPlayerPageArgs(videoId: video.id));
                  },
                );
              },
            ));
      }
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
