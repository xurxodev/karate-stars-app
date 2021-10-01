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
/*  final List<String> categoryOptions;
  */

  final int selectedLegendType;
  final int selectedActiveType;
  final Country? selectedCountry;

/*
  final int selectedCategory;*/

  CompetitorsFilterState(
      {required this.countryOptions, this.selectedLegendType = 0, this.selectedActiveType = 0, this.selectedCountry});

  CompetitorsFilterState copyWith(
      {List<Country>? countryOptions , int? selectedLegendType, int? selectedActiveType, Country? selectedCountry}) {
    return CompetitorsFilterState(
        countryOptions: countryOptions ?? this.countryOptions,
        selectedLegendType: selectedLegendType ?? this.selectedLegendType,
        selectedActiveType: selectedActiveType ?? this.selectedActiveType,
        selectedCountry: selectedCountry ?? this.selectedCountry);
  }
}
