import 'dart:async';

import 'package:karate_stars_app/src/categories/domain/entities/category.dart';
import 'package:karate_stars_app/src/categories/domain/get_categories.dart';
import 'package:karate_stars_app/src/category_types/domain/entities/category_type.dart';
import 'package:karate_stars_app/src/category_types/domain/get_category_types.dart';
import 'package:karate_stars_app/src/common/analytics/events.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/common/extensions/extensions.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_home_list_content.dart';
import 'package:karate_stars_app/src/common/presentation/boundaries/analytics.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/common/presentation/states/option.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/competitors/domain/competitors_filter.dart';
import 'package:karate_stars_app/src/competitors/domain/entities/competitor.dart';
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

  final List<Option> _legendTypeOptions = [
    Option('', Strings.default_filters_all),
    Option('true', Strings.competitor_filters_legends),
    Option('false', Strings.competitor_filters_stars)
  ];

  final List<Option> _activeTypeOptions = [
    Option('', Strings.default_filters_all),
    Option('true', Strings.competitor_filters_active),
    Option('false', Strings.competitor_filters_inactive)
  ];

  final defaultCountry = Option.defaultOption();
  final defaultCategoryType = Option.defaultOption();
  final defaultCategory = Option.defaultOption();

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
            legendTypeOptions: _legendTypeOptions,
            activeTypeOptions: _activeTypeOptions,
            countryOptions: [],
            categoryTypeOptions: [],
            categoryOptions: [],
            selectedLegendType: _legendTypeOptions[0].id,
            selectedActiveType: _activeTypeOptions[0].id,
            selectedCountry: defaultCountry.id,
            selectedCategoryType: defaultCategoryType.id,
            selectedCategory: defaultCategory.id)));

    _loadMetadataAndData(ReadPolicy.cache_first);
  }

  Future<void> refresh() {
    return _loadData(ReadPolicy.network_first);
  }

  void filter(
      {String? selectedLegendType,
      String? selectedActiveType,
      String? selectedCountry,
      String? selectedCategoryType,
      String? selectedCategory}) {
    final filters = state.filters.copyWith(
        selectedActiveType:
            selectedActiveType ?? state.filters.selectedActiveType,
        selectedLegendType:
            selectedLegendType ?? state.filters.selectedLegendType,
        selectedCountry: selectedCountry ?? state.filters.selectedCountry,
        selectedCategoryType:
            selectedCategoryType ?? state.filters.selectedCategoryType,
        selectedCategory: selectedCategory ?? state.filters.selectedCategory);

    sendFilterAnalyticsEvent(state.filters);

    changeState(state.copyWith(filters: filters));

    _loadData(ReadPolicy.cache_first);
  }

  void sendFilterAnalyticsEvent(CompetitorsFilterState filters) {
    final legend = _legendTypeOptions
        .firstWhere((option) => option.id == filters.selectedLegendType);

    final active = _activeTypeOptions
        .firstWhere((option) => option.id == filters.selectedActiveType);

    final country = filters.countryOptions
        .firstWhere((option) => option.id == filters.selectedCountry);

    final categoryType = filters.categoryTypeOptions
        .firstWhere((option) => option.id == filters.selectedCategoryType);

    final category = filters.categoryOptions
        .firstWhere((option) => option.id == filters.selectedCategory);

    final filter =
        'legend: ${legend.name} active: ${active.name} country:${country.name} category:${categoryType.name} categoryType:${category.name}';

    super.analyticsService.sendEvent(CompetitorsFilterEvent(filter));
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
          legendFilter: state.filters.selectedLegendType.toNullableBool(),
          activeFilter: state.filters.selectedActiveType.toNullableBool(),
          countryId: Option.getIdOrNull(state.filters.selectedCountry),
          categoryTypeId:
              Option.getIdOrNull(state.filters.selectedCategoryType),
          categoryId: Option.getIdOrNull(state.filters.selectedCategory));

      final competitors = await _getCompetitorsUseCase.execute(readPolicy,
          competitorsFilter: competitorsFilter);

      final competitorItems = _mapCompetitors(competitors);

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
      defaultCategoryType,
      ...categoryTypes.map((item) => Option(item.id, item.name))
    ];
  }

  List<Option> getCategoryOptions() {
    final finalCategories = categories
        .where((element) =>
            state.filters.selectedCategoryType == Strings.default_filters_all ||
            element.typeId == state.filters.selectedCategoryType)
        .toList();

    return [
      defaultCategory,
      ...finalCategories.map((item) => Option(item.id, item.name))
    ];
  }

  List<CompetitorItemState> _mapCompetitors(List<Competitor> competitors) {
    final competitorItems = competitors.map((competitor) {
      final country =
          countries.firstWhere((country) => country.id == competitor.countryId);

      return CompetitorItemState(
          competitor.id,
          '${competitor.firstName} ${competitor.lastName}',
          competitor.mainImage,
          country.image);
    }).toList();
    return competitorItems;
  }
}
