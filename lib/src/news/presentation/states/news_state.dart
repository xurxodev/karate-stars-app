import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/news/domain/entities/news.dart';

class NewsState {
  final DefaultState<List<News>> listState;

  NewsState(
      {required this.listState});

  NewsState copyWith(
      {DefaultState<List<News>>? listState}) {
    return NewsState(
        listState: listState ?? this.listState);
  }
}
