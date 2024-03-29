import 'package:app_review/app_review.dart';
import 'package:flutter/material.dart';
import 'package:karate_stars_app/app_di.dart' as app_di;
import 'package:karate_stars_app/src/ads/ad.dart';
import 'package:karate_stars_app/src/ads/ads_helper.dart';
import 'package:karate_stars_app/src/ads/ads_listview.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_provider.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/Progress.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/notification_message.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/videos/domain/entities/video.dart';
import 'package:karate_stars_app/src/videos/presentation/blocs/video_player_bloc.dart';
import 'package:karate_stars_app/src/videos/presentation/states/VideoPlayerState.dart';
import 'package:karate_stars_app/src/videos/presentation/widgets/item_video.dart';
import 'package:karate_stars_app/src/videos/presentation/widgets/youtube/youtube_video_player.dart';

class VideoPlayerPageArgs {
  final String videoId;
  final ReadPolicy readPolicy;

  VideoPlayerPageArgs(
      {required this.videoId, this.readPolicy = ReadPolicy.cache_first});
}

class VideoPlayerPage extends StatefulWidget {
  final VideoPlayerPageArgs args;
  static const routeName = '/video';

  const VideoPlayerPage({required this.args});

  static void navigate(BuildContext context,
      {required VideoPlayerPageArgs arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  static Widget create(VideoPlayerPageArgs args) {
    return BlocProvider(
        bloc: app_di.getIt<VideoPlayerBloc>(),
        child: VideoPlayerPage(args: args));
  }

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPage();
}

class _VideoPlayerPage extends State<VideoPlayerPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final VideoPlayerBloc bloc = BlocProvider.of<VideoPlayerBloc>(context);
    bloc.init(videoId: widget.args.videoId, readPolicy: widget.args.readPolicy);

    return StreamBuilder<VideoPlayerState>(
      initialData: bloc.state,
      stream: bloc.observableState,
      builder: (context, snapshot) {
        final state = snapshot.data;

        if (state != null) {
          if (state.playList is LoadingState) {
            return Progress();
          } else if (state.playList is ErrorState) {
            final errorState = state as ErrorState;
            return Center(child: NotificationMessage(errorState.message));
          } else {
            Future.delayed(const Duration(milliseconds: 100), () async {
              if (state.requestRateApp == true){

                final available = await AppReview.isRequestReviewAvailable;

                if (available) {
                  print('Request review');
                  AppReview.requestReview.then((value) {
                    print('Review ok ' + value.toString());
                  });
                }
              }
            });
            return _renderPlayList(context, state, bloc);
          }
        } else {
          return const Text('No Data');
        }
      },
    );
  }

  Widget _renderPlayList(
      BuildContext context, VideoPlayerState state, VideoPlayerBloc bloc) {
    final playList = state.playList as LoadedState<List<Video>>;

    return state.currentVideo == null
        ? Progress()
        : YoutubeVideoPlayer(
            youtubeVideoId: state.currentVideo!.links[0].id,
            isLive: state.currentVideo!.isLive,
            builder: (context, player) {
              return Scaffold(
                  appBar: AppBar(
                      centerTitle: false,
                      titleSpacing: 0,
                      title: Text(
                        Strings.video_player_appbar_title,
                        style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .headline6!
                                .fontSize),
                      )),
                  body: SafeArea(
                      child: Column(
                    children: [
                      player,
                      Card(
                          margin: const EdgeInsets.only(bottom: 16.0),
                          elevation: 15.0,
                          child: ListTile(
                            title: Text(state.currentVideo!.title),
                            subtitle: Text(
                                '${state.currentVideo!.subtitle} \n${state.currentVideo!.description}'),
                            isThreeLine: true,
                          )),
                      Expanded(
                        child: AdsListView(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16),
                          itemCount: playList.data.length,
                          adBuilder: (context) =>
                              Ad(adUnitId: AdsHelper.videoNativeAdUnitId),
                          itemBuilder: (context, index) {
                            final video = playList.data[index];

                            //final textKey = '${Keys.news_item}_$index';

                            return ItemVideo(
                              video: video,
                              onTap: () async {
                                bloc.init(videoId: video.id);
                              },
                            ); //, itemTextKey: textKey);
                          },
                        ),
                      )
                    ],
                  )));
            },
            onEnded: (data) {
              bloc.next();
            });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
