import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/videos/domain/entities/video.dart';

class VideoPlayerState {
  final DefaultState<List<Video>> playList;
  final Video? currentVideo;
  final bool? requestRateApp;

  VideoPlayerState(
      {required this.playList, this.currentVideo, this.requestRateApp});

  VideoPlayerState copyWith(
      {DefaultState<List<Video>>? playList,
      Video? currentVideo,
      bool? requestRateApp}) {
    return VideoPlayerState(
        playList: playList ?? this.playList,
        currentVideo: currentVideo ?? this.currentVideo,
        requestRateApp: requestRateApp ?? this.requestRateApp);
  }
}
