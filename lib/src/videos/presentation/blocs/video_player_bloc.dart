import 'dart:async';

import 'package:karate_stars_app/src/common/analytics/events.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc.dart';
import 'package:karate_stars_app/src/common/presentation/boundaries/analytics.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/rate_app/domain/usecases/get_rate_app_use_case.dart';
import 'package:karate_stars_app/src/rate_app/presentation/utils.dart';
import 'package:karate_stars_app/src/videos/domain/entities/video.dart';
import 'package:karate_stars_app/src/videos/domain/get_play_list_use_case.dart';
import 'package:karate_stars_app/src/videos/presentation/states/VideoPlayerState.dart';

class VideoPlayerBloc extends Bloc<VideoPlayerState> {
  static const screen_name = 'video_player';
  final GetPlayListByVideoIdUseCase _getPlayListByVideoIdUseCase;
  final GetRateAppUseCase _getRateAppUseCase;

  final AnalyticsService _analyticsService;

  VideoPlayerBloc(this._getPlayListByVideoIdUseCase, this._analyticsService, this._getRateAppUseCase) {
    changeState(VideoPlayerState(playList: DefaultState.loading()));
  }

  void init(
      {required String videoId,
      ReadPolicy readPolicy = ReadPolicy.cache_first}) {
    _loadData(videoId, readPolicy);

    increaseAppRateConversionCount();
  }

  Future<void> next() async {
    final rateApp = await _getRateAppUseCase.execute();
    if (await rateApp.isRequestRateAppRequired()){
      print('Request review required');
      changeState(state.copyWith(requestRateApp: true));
      updateAppRateLastRequestVersion();
      _analyticsService.sendEvent(RateApp(RateAppFrom.fromAlgorithm));
    }else {
      print('Request review does not required, playing next video');
      final videos = (state.playList as LoadedState<List<Video>>).data;
      final currentVideo = videos[0];
      videos.remove(currentVideo);

      _analyticsService.sendScreenName('$screen_name/${currentVideo.id}');

      changeState(state.copyWith(
          playList: DefaultState.loaded(videos), currentVideo: currentVideo));

      increaseAppRateConversionCount();
    }
  }

  Future<void> _loadData(String videoId, ReadPolicy readPolicy) async {
    try {
      final videos =
          await _getPlayListByVideoIdUseCase.execute(readPolicy, videoId);

      final currentVideo = videos[0];
      videos.remove(currentVideo);

      _analyticsService.sendScreenName('$screen_name/${currentVideo.id}');

      changeState(VideoPlayerState(
          playList: DefaultState.loaded(videos), currentVideo: currentVideo));
    } on Exception {
      changeState(VideoPlayerState(
          playList: DefaultState.error(Strings.network_error_message)));
    }
  }
}
