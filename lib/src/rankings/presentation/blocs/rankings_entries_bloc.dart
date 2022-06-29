import 'dart:async';

import 'package:karate_stars_app/src/categories/domain/get_category_by_id.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc.dart';
import 'package:karate_stars_app/src/common/presentation/boundaries/analytics.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/rankings/domain/get_ranking_by_id.dart';
import 'package:karate_stars_app/src/rankings/domain/get_ranking_entries.dart';
import 'package:karate_stars_app/src/rankings/presentation/state/ranking_entries_state.dart';

class RankingEntriesBloc extends Bloc<RankingEntriesState> {
  static const screen_name = 'rankings-entries';
  final GetRankingByIdUseCase _getRankingByIdUseCase;
  final GetCategoryByIdUseCase _getCategoryByIdUseCase;
  final GetRankingEntriesUseCase _getRankingEntriesUseCase;

  final AnalyticsService _analyticsService;
  late String rankingId;
  late String categoryId;

  RankingEntriesBloc(this._getRankingByIdUseCase, this._getCategoryByIdUseCase,
      this._getRankingEntriesUseCase, this._analyticsService);

  void init(
      {required String rankingId,
      required String categoryId,
      ReadPolicy readPolicy = ReadPolicy.cache_first}) {
    _analyticsService.sendScreenName(
        '$screen_name rankingId:$rankingId categoryId:$categoryId');

    this.rankingId = rankingId;
    this.categoryId = categoryId;

    changeState(RankingEntriesState(content: DefaultState.loading()));

    _loadData(readPolicy);
  }

  Future<void> refresh() {
    return _loadData(ReadPolicy.network_first);
  }

  Future<void> _loadData(ReadPolicy readPolicy) async {
    try {
      final ranking =
          await _getRankingByIdUseCase.execute(readPolicy, rankingId);

      final category =
          await _getCategoryByIdUseCase.execute(readPolicy, categoryId);

      final entries = await _getRankingEntriesUseCase.execute(
          readPolicy, rankingId, categoryId);

      changeState(state.copyWith(
          content: DefaultState.loaded(RankingEntriesContent(
              ranking: ranking, category: category, entries: entries))));
    } on Exception {
      changeState(state.copyWith(
          content: DefaultState.error(Strings.network_error_message)));
    }
  }
}
