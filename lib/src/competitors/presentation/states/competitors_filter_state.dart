import 'package:karate_stars_app/src/common/strings.dart';

class CompetitorsFilterState {
  final List<String> competitorTypeOptions = [
    Strings.default_filters_all,
    Strings.competitor_filters_stars,
    Strings.competitor_filters_legends
  ];

  final List<String> categoryOptions;
  final List<String> countryOptions;

  final int selectedCompetitorType;
  final int selectedCountry;
  final int selectedCategory;

  CompetitorsFilterState(
      {this.categoryOptions = const [],
      this.countryOptions = const [],
      this.selectedCompetitorType = 0,
      this.selectedCountry = 0,
      this.selectedCategory = 0});

  CompetitorsFilterState copyWith(
      {List<String>? categoryOptions,
      List<String>? countryOptions,
      int? selectedCompetitorType,
      int? selectedCountry,
      int? selectedCategory}) {
    return CompetitorsFilterState(
        categoryOptions: categoryOptions ?? this.categoryOptions,
        countryOptions: countryOptions ?? this.countryOptions,
        selectedCompetitorType:
            selectedCompetitorType ?? this.selectedCompetitorType,
        selectedCountry: selectedCountry ?? this.selectedCountry,
        selectedCategory: selectedCategory ?? this.selectedCategory);
  }
}
