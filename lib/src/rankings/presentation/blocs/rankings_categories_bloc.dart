import 'dart:async';

import 'package:karate_stars_app/src/categories/domain/get_categories_by_ids.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc.dart';
import 'package:karate_stars_app/src/common/presentation/boundaries/analytics.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/rankings/domain/get_ranking_by_id.dart';
import 'package:karate_stars_app/src/rankings/presentation/state/ranking_categories_state.dart';

class RankingCategoriesBloc extends Bloc<RankingCategoriesState> {
  static const screen_name = 'rankings-categories';
  final GetRankingByIdUseCase _getRankingByIdUseCase;
  final GetCategoriesByIdsUseCase _getCategoriesByIdsUseCase;
  final AnalyticsService _analyticsService;
  late String rankingId;

  RankingCategoriesBloc(this._getRankingByIdUseCase,
      this._getCategoriesByIdsUseCase, this._analyticsService);

  void init(
      {required String rankingId,
      ReadPolicy readPolicy = ReadPolicy.cache_first}) {
    _analyticsService.sendScreenName('$screen_name/$rankingId');

    this.rankingId = rankingId;

    changeState(RankingCategoriesState(content: DefaultState.loading()));

    _loadData(readPolicy);
  }

  Future<void> refresh() {
    return _loadData(ReadPolicy.network_first);
  }

  Future<void> _loadData(ReadPolicy readPolicy) async {
    try {
      final ranking =
          await _getRankingByIdUseCase.execute(readPolicy, rankingId);

      final categories = await _getCategoriesByIdsUseCase.execute(
          readPolicy, ranking.categories);

      changeState(state.copyWith(
          content: DefaultState.loaded(RankingCategoriesContent(
              ranking: ranking, categories: categories))));
    } on Exception {
      changeState(state.copyWith(
          content: DefaultState.error(Strings.network_error_message)));
    }
  }
}
