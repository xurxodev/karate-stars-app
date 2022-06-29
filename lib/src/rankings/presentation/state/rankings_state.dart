import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/rankings/domain/entities/ranking.dart';

class RankingsState {
  final DefaultState<List<Ranking>> list;

  RankingsState({required this.list});

  RankingsState copyWith(
      {DefaultState<List<Ranking>>? list}) {
    return RankingsState(
        list: list ?? this.list, );
  }
}
