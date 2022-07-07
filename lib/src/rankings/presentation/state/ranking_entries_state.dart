import 'package:karate_stars_app/src/categories/domain/entities/category.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/rankings/domain/entities/ranking.dart';
import 'package:karate_stars_app/src/rankings/domain/entities/rankingEntry.dart';

class RankingEntriesContent {
  final Ranking ranking;
  final Category category;
  final List<RankingEntry> entries;

  RankingEntriesContent(
      {required this.ranking, required this.category, required this.entries});
}

class RankingEntriesState {
  final String searchTerm;
  final DefaultState<RankingEntriesContent> content;

  RankingEntriesState({required this.content, required this.searchTerm});

  RankingEntriesState copyWith(
      {DefaultState<RankingEntriesContent>? content, String? searchTerm}) {
    return RankingEntriesState(
        content: content ?? this.content,
        searchTerm: searchTerm ?? this.searchTerm);
  }
}
