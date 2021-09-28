import 'package:karate_stars_app/src/common/strings.dart';

class CompetitorsFilterState {
  final Map<int, String> legendTypeOptions = {
    0: Strings.default_filters_all,
    1: Strings.competitor_filters_legends,
    2: Strings.competitor_filters_stars
  };

  final Map<int, String> activeTypeOptions = {
    0: Strings.default_filters_all,
    1: Strings.competitor_filters_active,
    2: Strings.competitor_filters_inactive
  };

/*  final List<String> categoryOptions;
  final List<String> countryOptions;*/

  final int selectedLegendType;
  final int selectedActiveType;

/*  final int selectedCountry;
  final int selectedCategory;*/

  CompetitorsFilterState(
      {this.selectedLegendType = 0, this.selectedActiveType = 0});

  CompetitorsFilterState copyWith(
      {int? selectedLegendType, int? selectedActiveType}) {
    return CompetitorsFilterState(
        selectedLegendType: selectedLegendType ?? this.selectedLegendType,
        selectedActiveType: selectedActiveType ?? this.selectedActiveType);
  }
}
