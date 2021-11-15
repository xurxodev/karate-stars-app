import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/news/domain/entities/news.dart';
import 'package:karate_stars_app/src/news/presentation/states/news_filter_state.dart';

class NewsState {
  final DefaultState<List<News>> listState;
  final NewsFilterState filtersState;

  NewsState(
      {required this.listState,
      required this.filtersState});

  NewsState copyWith(
      {DefaultState<List<News>>? listState,
      NewsFilterState? filtersState}) {
    return NewsState(
        listState: listState ?? this.listState,
        filtersState: filtersState ?? this.filtersState);
  }
}
