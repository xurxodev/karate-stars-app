import 'dart:async';

import 'package:karate_stars_app/src/categories/domain/entities/category.dart';
import 'package:karate_stars_app/src/categories/domain/get_categories_by_ids.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_searchable.dart';
import 'package:karate_stars_app/src/common/presentation/boundaries/analytics.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/rankings/domain/get_ranking_by_id.dart';
import 'package:karate_stars_app/src/rankings/presentation/state/ranking_categories_state.dart';

class RankingCategoriesBloc extends BlocSearchable<RankingCategoriesState> {
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

    changeState(RankingCategoriesState(
        searchTerm: '', content: DefaultState.loading()));

    _loadData(readPolicy);
  }

  Future<void> refresh() {
    return _loadData(ReadPolicy.network_first);
  }

  @override
  Future<void> executeSearch(String searchTerm) async {
    changeState(state.copyWith(searchTerm: searchTerm));

    return _loadData(ReadPolicy.cache_first);
  }

  Future<void> _loadData(ReadPolicy readPolicy) async {
    try {
      final ranking =
          await _getRankingByIdUseCase.execute(readPolicy, rankingId);

      final categories = (await _getCategoriesByIdsUseCase.execute(
              readPolicy, ranking.categories))
          .where((cat) =>
              state.searchTerm == '' ||
              cat.name.toLowerCase().contains(state.searchTerm.toLowerCase()));

      final catMap = (Category cat) => RankingCategoryLeafState(
          cat.id,
          cat.name
              .replaceAll('Cadet', '')
              .replaceAll('Junior', '')
              .replaceAll('U21', ''));

      final paraKarateCategories =
          categories.where(categoryParaKarateFilter).map(catMap);
      final cadetCategories = categories.where(categoryCadetFilter).map(catMap);
      final juniorCategories =
          categories.where(categoryJuniorFilter).map(catMap);
      final u21Categories = categories.where(categoryU21Filter).map(catMap);
      final seniorCategories =
          categories.where(categorySeniorFilter).map(catMap);

      final finalCategories = [
        if (seniorCategories.isNotEmpty) ...[
          RankingCategoryParentState(Strings.rankings_categories_senior_title),
          ...seniorCategories
        ] else
          ...seniorCategories,
        if (u21Categories.isNotEmpty) ...[
          RankingCategoryParentState(Strings.rankings_categories_u21_title),
          ...u21Categories
        ] else
          ...u21Categories,
        if (juniorCategories.isNotEmpty) ...[
          RankingCategoryParentState(Strings.rankings_categories_junior_title),
          ...juniorCategories
        ] else
          ...juniorCategories,
        if (cadetCategories.isNotEmpty) ...[
          RankingCategoryParentState(Strings.rankings_categories_cadet_title),
          ...cadetCategories
        ] else
          ...cadetCategories,
        if (paraKarateCategories.isNotEmpty) ...[
          RankingCategoryParentState(
              Strings.rankings_categories_para_karate_title),
          ...paraKarateCategories
        ] else
          ...paraKarateCategories
      ];

      changeState(state.copyWith(
          content: DefaultState.loaded(RankingCategoriesContent(
              ranking: ranking, categories: finalCategories))));
    } on Exception {
      changeState(state.copyWith(
          content: DefaultState.error(Strings.network_error_message)));
    }
  }
}
