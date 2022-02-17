import 'package:karate_stars_app/src/common/presentation/states/option.dart';

class CompetitorsFilterState {
  final List<Option> legendTypeOptions;
  final List<Option> activeTypeOptions;
  final List<Option> countryOptions;
  final List<Option> categoryTypeOptions;
  final List<Option> categoryOptions;

  final String selectedLegendType;
  final String selectedActiveType;
  final String selectedCountry;
  final String selectedCategoryType;
  final String selectedCategory;

  CompetitorsFilterState({
    required this.legendTypeOptions,
    required this.activeTypeOptions,
    required this.countryOptions,
    required this.categoryTypeOptions,
    required this.categoryOptions,
    required this.selectedLegendType,
    required this.selectedActiveType,
    required this.selectedCountry,
    required this.selectedCategoryType,
    required this.selectedCategory,
  });

  CompetitorsFilterState copyWith(
      {List<Option>? legendTypeOptions,
      List<Option>? activeTypeOptions,
      List<Option>? countryOptions,
      List<Option>? categoryTypeOptions,
      List<Option>? categoryOptions,
      String? selectedLegendType,
      String? selectedActiveType,
      String? selectedCountry,
      String? selectedCategoryType,
      String? selectedCategory}) {
    return CompetitorsFilterState(
        legendTypeOptions: legendTypeOptions ?? this.legendTypeOptions,
        activeTypeOptions: activeTypeOptions ?? this.activeTypeOptions,
        countryOptions: countryOptions ?? this.countryOptions,
        categoryTypeOptions: categoryTypeOptions ?? this.categoryTypeOptions,
        categoryOptions: categoryOptions ?? this.categoryOptions,
        selectedLegendType: selectedLegendType ?? this.selectedLegendType,
        selectedActiveType: selectedActiveType ?? this.selectedActiveType,
        selectedCountry: selectedCountry ?? this.selectedCountry,
        selectedCategoryType: selectedCategoryType ?? this.selectedCategoryType,
        selectedCategory: selectedCategory ?? this.selectedCategory);
  }

  bool get anyFilter {
    return legendTypeOptions.isNotEmpty && selectedLegendType != legendTypeOptions[0].id ||
        activeTypeOptions.isNotEmpty && selectedActiveType != activeTypeOptions[0].id ||
        countryOptions.isNotEmpty && selectedCountry != countryOptions[0].id ||
        categoryOptions.isNotEmpty &&  selectedCategoryType != categoryOptions[0].id ||
        categoryOptions.isNotEmpty &&  selectedCategory != categoryOptions[0].id;
  }
}
