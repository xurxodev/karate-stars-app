import 'package:karate_stars_app/src/common/presentation/states/option.dart';

class VideosFilterState {
  final List<Option> competitorOptions;
  final List<Option> yearOptions;

  final Option? selectedCompetitor;
  final Option? selectedYear;

  VideosFilterState(
      {required this.competitorOptions,
      required this.yearOptions,
      this.selectedCompetitor,
      this.selectedYear});

  VideosFilterState copyWith(
      {List<Option>? competitorOptions,
      List<Option>? yearOptions,
      Option? selectedCompetitor,
      Option? selectedYear}) {
    return VideosFilterState(
        competitorOptions: competitorOptions ?? this.competitorOptions,
        yearOptions: yearOptions ?? this.yearOptions,
        selectedCompetitor: selectedCompetitor ?? this.selectedCompetitor,
        selectedYear: selectedYear ?? this.selectedYear);
  }
}
