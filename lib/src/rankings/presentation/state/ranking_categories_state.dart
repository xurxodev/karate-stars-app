import 'package:karate_stars_app/src/categories/domain/entities/category.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/rankings/domain/entities/ranking.dart';

class RankingCategoryState {}

class RankingCategoryParentState extends RankingCategoryState{
  final String name;

  RankingCategoryParentState(this.name);
}

class RankingCategoryLeafState extends RankingCategoryState{
  final String id;
  final String name;

  RankingCategoryLeafState(this.id, this.name);
}

class RankingCategoriesContent {
  final Ranking ranking;
  final List<RankingCategoryState> categories;

  RankingCategoriesContent({required this.ranking, required this.categories});
}

class RankingCategoriesState {
  final DefaultState<RankingCategoriesContent> content;

  RankingCategoriesState({required this.content});

  RankingCategoriesState copyWith(
      {DefaultState<RankingCategoriesContent>? content}) {
    return RankingCategoriesState(content: content ?? this.content);
  }
}
