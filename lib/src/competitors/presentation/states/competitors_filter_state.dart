import 'package:karate_stars_app/src/categories/domain/entities/category.dart';
import 'package:karate_stars_app/src/category_types/domain/entities/category_type.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/countries/domain/entities/country.dart';

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

  final List<Country> countryOptions;
  final List<CategoryType> categoryTypeOptions;
  final List<Category> categoryOptions;

  final int selectedLegendType;
  final int selectedActiveType;
  final Country? selectedCountry;
  final CategoryType? selectedCategoryType;
  final Category? selectedCategory;

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
      {List<Country>? countryOptions,
      List<CategoryType>? categoryTypeOptions,
      List<Category>? categoryOptions,
      int? selectedLegendType,
      int? selectedActiveType,
      Country? selectedCountry,
      CategoryType? selectedCategoryType,
      Category? selectedCategory}) {
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
