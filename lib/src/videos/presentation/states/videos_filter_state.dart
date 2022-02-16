import 'package:karate_stars_app/src/common/presentation/states/option.dart';

class VideosFilterState {
  final List<Option> competitorOptions;
  final List<Option> yearOptions;

  final String selectedCompetitor;
  final String selectedYear;

  VideosFilterState(
      {required this.competitorOptions,
      required this.yearOptions,
      required this.selectedCompetitor,
      required this.selectedYear});

  VideosFilterState copyWith(
      {List<Option>? competitorOptions,
      List<Option>? yearOptions,
      String? selectedCompetitor,
      String? selectedYear}) {
    return VideosFilterState(
        competitorOptions: competitorOptions ?? this.competitorOptions,
        yearOptions: yearOptions ?? this.yearOptions,
        selectedCompetitor: selectedCompetitor ?? this.selectedCompetitor,
        selectedYear: selectedYear ?? this.selectedYear);
  }
}
