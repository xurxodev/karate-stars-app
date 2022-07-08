import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/competitors/presentation/states/competitors_state.dart';
import 'package:karate_stars_app/src/news/domain/entities/news.dart';
import 'package:karate_stars_app/src/videos/domain/entities/video.dart';

class SearchState {
  final DefaultState<List<News>> news;
  final DefaultState<List<CompetitorItemState>> competitors;
  final DefaultState<List<Video>> videos;

  SearchState(
      {required this.news, required this.competitors, required this.videos});

  SearchState copyWith(
      {DefaultState<List<News>>? news,
      DefaultState<List<CompetitorItemState>>? competitors,
      DefaultState<List<Video>>? videos}) {
    return SearchState(
        news: news ?? this.news,
        competitors: competitors ?? this.competitors,
        videos: videos ?? this.videos);
  }
}
