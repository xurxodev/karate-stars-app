import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/videos/domain/entities/video.dart';
import 'package:karate_stars_app/src/videos/presentation/states/videos_filter_state.dart';

class VideosState {
  final DefaultState<List<Video>> list;
  final VideosFilterState filters;

  VideosState({required this.filters, required this.list});

  VideosState copyWith(
      {DefaultState<List<Video>>? list,
      VideosFilterState? filters}) {
    return VideosState(
        list: list ?? this.list,
        filters: filters ?? this.filters);
  }
}

