import 'package:flutter/material.dart';
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
import 'package:karate_stars_app/src/videos/domain/entities/video.dart';
import 'package:karate_stars_app/src/videos/presentation/blocs/videos_bloc.dart';
import 'package:karate_stars_app/src/videos/presentation/pages/video_player_page.dart';
import 'package:karate_stars_app/src/videos/presentation/states/videos_state.dart';
import 'package:karate_stars_app/src/videos/presentation/widgets/item_video.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class VideosPageView extends StatefulWidget {
  final ScrollController? controller;

  const VideosPageView({this.controller})
      : super(key: const Key(Keys.videos_page_view));

  @override
  _VideosPageViewState createState() => _VideosPageViewState();
}

class _VideosPageViewState extends State<VideosPageView> {
  late PlayVideoInterstitialAd _playVideoInterstitialAd;

  @override
  void initState() {
    super.initState();

    _playVideoInterstitialAd = PlayVideoInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {
    final VideosBloc bloc = BlocProvider.of<VideosBloc>(context);

    return StreamBuilder<VideosState>(
      initialData: bloc.state,
      stream: bloc.observableState,
      builder: (context, snapshot) {
        final state = snapshot.data;

        if (state != null) {
          if (state.list is LoadingState) {
            return Progress();
          } else if (state.list is ErrorState) {
            final listState = state.list as ErrorState;
            return Center(child: NotificationMessage(listState.message));
          } else {
            return _renderList(
                context, state.list as LoadedState<List<Video>>, bloc);
          }
        } else {
          return const Text('No Data');
        }
      },
    );
  }

  Widget _renderList(
      BuildContext context, LoadedState<List<Video>> state, VideosBloc bloc) {
    print('videos' + state.data.length.toString());
    if (state.data.isEmpty) {
      return const NotificationMessage(Strings.videos_empty_message);
    } else {
      return Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: NotificationListener<ScrollUpdateNotification>(
            child: LiquidPullToRefresh(
                borderWidth: 2,
                color: Theme.of(context).scaffoldBackgroundColor,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                showChildOpacityTransition: false,
                child: AdsListView(
                  controller: widget.controller,
                  itemCount: state.data.length,
                  adBuilder: (context) =>
                      Ad(adUnitId: AdsHelper.videosNativeAdUnitId),
                  itemBuilder: (context, index) {
                    final video = state.data[index];

                    //final textKey = '${Keys.news_item}_$index';

                    return ItemVideo(
                      video: video,
                      onTap: () async {
                        _playVideoInterstitialAd.show();
                        Navigator.pushNamed(context, VideoPlayerPage.routeName,
                            arguments: video.id);
                      },
                    ); //, itemTextKey: textKey);
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
  void dispose() {
    _playVideoInterstitialAd.dispose();
    super.dispose();
  }
}
