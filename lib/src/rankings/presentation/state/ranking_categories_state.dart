import 'package:karate_stars_app/src/categories/domain/entities/category.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/rankings/domain/entities/ranking.dart';

class RankingCategoriesContent {
  final Ranking ranking;
  final List<Category> categories;

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
