import 'dart:async';

import 'package:karate_stars_app/src/categories/domain/entities/category.dart';
import 'package:karate_stars_app/src/categories/domain/get_categories.dart';
import 'package:karate_stars_app/src/category_types/domain/entities/category_type.dart';
import 'package:karate_stars_app/src/category_types/domain/get_category_types.dart';
import 'package:karate_stars_app/src/common/analytics/events.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_home_list_content.dart';
import 'package:karate_stars_app/src/common/presentation/boundaries/analytics.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/common/presentation/states/option.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/competitors/domain/competitors_filter.dart';
import 'package:karate_stars_app/src/competitors/domain/get_competitors_use_case.dart';
import 'package:karate_stars_app/src/competitors/presentation/states/competitors_filter_state.dart';
import 'package:karate_stars_app/src/competitors/presentation/states/competitors_state.dart';
import 'package:karate_stars_app/src/countries/domain/entities/country.dart';
import 'package:karate_stars_app/src/countries/domain/get_countries_use_case.dart';

class CompetitorsBloc extends BlocHomeListContent<CompetitorsState> {
  static const screen_name = 'home_competitors';
  final GetCompetitorsUseCase _getCompetitorsUseCase;
  final GetCountriesUseCase _getCountriesUseCase;
  final GetCategoryTypesUseCase _getCategoryTypesUseCase;
  final GetCategoriesUseCase _getCategoriesUseCase;

  final defaultCountry =
      Option(Strings.default_filters_all, Strings.default_filters_all);
  final defaultCategoryType =
      Option(Strings.default_filters_all, Strings.default_filters_all);
  final defaultCategory =
      Option(Strings.default_filters_all, Strings.default_filters_all);

  List<Country> countries = [];
  List<CategoryType> categoryTypes = [];
  List<Category> categories = [];

  CompetitorsBloc(
      this._getCompetitorsUseCase,
      this._getCountriesUseCase,
      this._getCategoryTypesUseCase,
      this._getCategoriesUseCase,
      AnalyticsService _analyticsService)
      : super(_analyticsService, screen_name) {
    changeState(CompetitorsState(
        list: DefaultState.loading(),
        filters: CompetitorsFilterState(
            countryOptions: [],
            categoryTypeOptions: [],
            categoryOptions: [],
            selectedCountry: defaultCountry,
            selectedCategoryType: defaultCategoryType,
            selectedCategory: defaultCategory)));

    _loadMetadataAndData(ReadPolicy.cache_first);
  }

  Future<void> refresh() {
    return _loadData(ReadPolicy.network_first);
  }

  void filter(
      {int? selectedLegendTypeIndex,
      int? selectedActiveIndex,
      Option? selectedCountry,
      Option? selectedCategoryType,
      Option? selectedCategory}) {
    final legendFilterIndex =
        selectedLegendTypeIndex ?? state.filters.selectedLegendType;
    final legendFilter = state.filters.legendTypeOptions[legendFilterIndex];

    final activeFilterIndex =
        selectedActiveIndex ?? state.filters.selectedActiveType;
    final activeFilter = state.filters.activeTypeOptions[
        selectedActiveIndex ?? state.filters.selectedActiveType];

    final filter =
        'legend: $legendFilter active: $activeFilter country:${selectedCountry?.name ?? ''}';
    super.analyticsService.sendEvent(CompetitorsFilterEvent(filter));

    changeState(state.copyWith(
        filters: CompetitorsFilterState(
            countryOptions: state.filters.countryOptions,
            categoryTypeOptions: state.filters.categoryTypeOptions,
            categoryOptions: state.filters.categoryOptions,
            selectedActiveType: activeFilterIndex,
            selectedLegendType: legendFilterIndex,
            selectedCountry: selectedCountry ?? state.filters.selectedCountry,
            selectedCategoryType:
                selectedCategoryType ?? state.filters.selectedCategoryType,
            selectedCategory:
                selectedCategory ?? state.filters.selectedCategory)));

    _loadData(ReadPolicy.cache_first);
  }

  Future<void> _loadMetadataAndData(ReadPolicy readPolicy) async {
    try {
      await _loadMetadata(readPolicy);
      await _loadData(readPolicy);
    } on Exception {
      changeState(state.copyWith(
          list: DefaultState.error(Strings.network_error_message)));
    }
  }

  Future<void> _loadMetadata(ReadPolicy readPolicy) async {
    countries = await _getCountriesUseCase.execute(readPolicy);

    categoryTypes = await _getCategoryTypesUseCase.execute(readPolicy);

    categories = (await _getCategoriesUseCase.execute(readPolicy))
        .where((element) => !element.name.toLowerCase().contains('team'))
        .toList();
  }

  Future<void> _loadData(ReadPolicy readPolicy) async {
    try {
      final competitorsFilter = CompetitorsFilter(
          state.filters.selectedLegendType == 0
              ? null
              : state.filters.selectedLegendType == 1 || false,
          state.filters.selectedActiveType == 0
              ? null
              : state.filters.selectedActiveType == 1 || false,
          state.filters.selectedCountry?.id != Strings.default_filters_all
              ? state.filters.selectedCountry?.id
              : null,
          state.filters.selectedCategoryType?.id != Strings.default_filters_all
              ? state.filters.selectedCategoryType?.id
              : null,
          state.filters.selectedCategory?.id != Strings.default_filters_all
              ? state.filters.selectedCategory?.id
              : null);

      final competitors = await _getCompetitorsUseCase.execute(readPolicy,
          competitorsFilter: competitorsFilter);

      final competitorItems = competitors.map((competitor) {
        final country = countries
            .firstWhere((country) => country.id == competitor.countryId);

        return CompetitorItemState(
            competitor.identifier,
            '${competitor.firstName} ${competitor.lastName}',
            competitor.mainImage,
            country.image);
      }).toList();

      changeState(state.copyWith(
          list: DefaultState.loaded(competitorItems),
          filters: state.filters.copyWith(
              countryOptions: getCountryOptions(),
              categoryTypeOptions: getCategoryTypesOptions(),
              categoryOptions: getCategoryOptions())));
    } on Exception {
      changeState(state.copyWith(
          list: DefaultState.error(Strings.network_error_message)));
    }
  }

  List<Option> getCountryOptions() {
    return [
      defaultCountry,
      ...countries.map((item) => Option(item.id, item.name))
    ];
  }

  List<Option> getCategoryTypesOptions() {
    return [
      defaultCountry,
      ...categoryTypes.map((item) => Option(item.id, item.name))
    ];
  }

  List<Option> getCategoryOptions() {
    final finalCategories = categories
        .where((element) =>
            state.filters.selectedCategoryType?.id ==
                Strings.default_filters_all ||
            element.typeId == state.filters.selectedCategoryType?.id)
        .toList();

    return [
      defaultCountry,
      ...finalCategories.map((item) => Option(item.id, item.name))
    ];
  }
}
