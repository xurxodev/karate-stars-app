import 'package:karate_stars_app/src/common/presentation/states/option.dart';
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

  final List<Option> countryOptions;
  final List<Option> categoryTypeOptions;
  final List<Option> categoryOptions;

  final int selectedLegendType;
  final int selectedActiveType;
  final Option? selectedCountry;
  final Option? selectedCategoryType;
  final Option? selectedCategory;

  CompetitorsFilterState({
    required this.countryOptions,
    required this.categoryTypeOptions,
    required this.categoryOptions,
    this.selectedLegendType = 0,
    this.selectedActiveType = 0,
    this.selectedCountry,
    this.selectedCategoryType,
    this.selectedCategory,
  });

  CompetitorsFilterState copyWith(
      {List<Option>? countryOptions,
      List<Option>? categoryTypeOptions,
      List<Option>? categoryOptions,
      int? selectedLegendType,
      int? selectedActiveType,
      Option? selectedCountry,
      Option? selectedCategoryType,
      Option? selectedCategory}) {
    return CompetitorsFilterState(
        countryOptions: countryOptions ?? this.countryOptions,
        categoryTypeOptions: categoryTypeOptions ?? this.categoryTypeOptions,
        categoryOptions: categoryOptions ?? this.categoryOptions,
        selectedLegendType: selectedLegendType ?? this.selectedLegendType,
        selectedActiveType: selectedActiveType ?? this.selectedActiveType,
        selectedCountry: selectedCountry ?? this.selectedCountry,
        selectedCategoryType: selectedCategoryType ?? this.selectedCategoryType,
        selectedCategory: selectedCategory ?? this.selectedCategory);
  }
}
