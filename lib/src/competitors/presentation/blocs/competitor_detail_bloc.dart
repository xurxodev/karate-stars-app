import 'dart:async';

import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc.dart';
import 'package:karate_stars_app/src/common/presentation/boundaries/analytics.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/competitors/domain/entities/competitor.dart';
import 'package:karate_stars_app/src/competitors/domain/get_competitor_by_id_use_case.dart';

typedef CompetitorDetailState = DefaultState<Competitor>;

class CompetitorDetailBloc extends Bloc<CompetitorDetailState> {
  static const screen_name = 'competitor_detail';
  final GetCompetitorByIdUseCase _getCompetitorByIdUseCase;

  final AnalyticsService _analyticsService;

  CompetitorDetailBloc(this._getCompetitorByIdUseCase, this._analyticsService) {
    changeState(DefaultState.loading());
  }

  void init(String competitorId) {
    _loadData(competitorId);
  }

  Future<void> _loadData(String competitorId) async {
    try {
      final competitor = await _getCompetitorByIdUseCase.execute(
          ReadPolicy.cache_first, competitorId);

      _analyticsService.sendScreenName('$screen_name/${competitor.identifier}');

      changeState(DefaultState.loaded(competitor));
    } on Exception {
      changeState(DefaultState.error(Strings.network_error_message));
    }
  }
}
