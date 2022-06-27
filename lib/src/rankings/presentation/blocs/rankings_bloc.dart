import 'dart:async';

import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc.dart';
import 'package:karate_stars_app/src/common/presentation/boundaries/analytics.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/rankings/domain/get_rankings.dart';
import 'package:karate_stars_app/src/rankings/presentation/state/events_state.dart';

class RankingsBloc extends Bloc<RankingsState> {
  static const screen_name = 'rankings';
  final GetRankingsUseCase _getRankingsUseCase;
  final AnalyticsService _analyticsService;

  RankingsBloc(this._getRankingsUseCase, this._analyticsService) {
    _analyticsService.sendScreenName(screen_name);

    changeState(RankingsState(list: DefaultState.loading()));

    _loadData(ReadPolicy.cache_first);
  }

  Future<void> refresh() {
    return _loadData(ReadPolicy.network_first);
  }

  Future<void> _loadData(ReadPolicy readPolicy) async {
    try {
      final events = await _getRankingsUseCase.execute(readPolicy);

      changeState(state.copyWith(list: DefaultState.loaded(events)));
    } on Exception {
      changeState(state.copyWith(
          list: DefaultState.error(Strings.network_error_message)));
    }
  }
}
