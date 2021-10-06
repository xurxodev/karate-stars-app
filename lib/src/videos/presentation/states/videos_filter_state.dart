import 'package:karate_stars_app/src/common/presentation/states/option.dart';

class VideosFilterState {
  final List<Option> competitorOptions;

  final Option? selectedCompetitor;
  final int? selectedYear;

  VideosFilterState(
      {required this.competitorOptions,
      this.selectedCompetitor,
      this.selectedYear});

  VideosFilterState copyWith(
      {List<Option>? competitorOptions,
      Option? selectedCompetitor,
      int? selectedYear}) {
    return VideosFilterState(
        competitorOptions: competitorOptions ?? this.competitorOptions,
        selectedCompetitor: selectedCompetitor ?? this.selectedCompetitor,
        selectedYear: selectedYear ?? this.selectedYear);
  }
}
