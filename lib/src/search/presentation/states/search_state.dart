import 'package:karate_stars_app/src/competitors/presentation/states/competitors_state.dart';
import 'package:karate_stars_app/src/news/domain/entities/news.dart';
import 'package:karate_stars_app/src/videos/domain/entities/video.dart';

abstract class SearchState {
  SearchState();

  factory SearchState.initial() => InitialState();

  factory SearchState.searching() => SearchingState();

  factory SearchState.results(SearchStateData data) => ResultsState(data: data);

  factory SearchState.error(String message) => SearchErrorState(message: message);
}

class InitialState extends SearchState {}

class SearchingState extends SearchState {}

class ResultsState<SearchStateData> extends SearchState {
  final SearchStateData data;

  ResultsState({required this.data});
}

class SearchErrorState extends SearchState{
  final String message;

  SearchErrorState({required this.message});
}

class SearchStateData {
  final List<News> newsResults;
  final List<CompetitorItemState> competitorResults;
  final List<Video> videosResults;

  SearchStateData(
      {required this.newsResults,
      required this.competitorResults,
      required this.videosResults});

  SearchStateData copyWith(
      {List<News>? newsResults,
      List<CompetitorItemState>? competitorResults,
      List<Video>? videosResults}) {
    return SearchStateData(
        newsResults: newsResults ?? this.newsResults,
        competitorResults: competitorResults ?? this.competitorResults,
        videosResults: videosResults ?? this.videosResults);
  }
}
