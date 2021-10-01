import 'dart:async';

import 'package:karate_stars_app/src/common/analytics/events.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_home_list_content.dart';
import 'package:karate_stars_app/src/common/presentation/boundaries/analytics.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
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

  final defaultCountry = Country(
      Strings.default_filters_all, Strings.default_filters_all, '', '');

  CompetitorsBloc(this._getCompetitorsUseCase, this._getCountriesUseCase,
      AnalyticsService _analyticsService)
      : super(_analyticsService, screen_name) {
    changeState(CompetitorsState(
        list: DefaultState.loading(),
        filters: CompetitorsFilterState(
            countryOptions: [], selectedCountry: defaultCountry)));
    _loadData(ReadPolicy.cache_first);
  }

  Future<void> refresh() {
    return _loadData(ReadPolicy.network_first);
  }

  void filter({int? selectedLegendTypeIndex,
    int? selectedActiveIndex,
    Country? selectedCountry}) {
    final legendFilterIndex =
        selectedLegendTypeIndex ?? state.filters.selectedLegendType;
    final legendFilter = state.filters.legendTypeOptions[legendFilterIndex];

    final activeFilterIndex =
        selectedActiveIndex ?? state.filters.selectedActiveType;
    final activeFilter = state.filters.activeTypeOptions[
    selectedActiveIndex ?? state.filters.selectedActiveType];

    final filter =
        'legend: $legendFilter active: $activeFilter country:${selectedCountry
        ?.name ?? ''}';
    super.analyticsService.sendEvent(CompetitorsFilterEvent(filter));

    changeState(state.copyWith(
        filters: CompetitorsFilterState(
            countryOptions: state.filters.countryOptions,
            selectedActiveType: activeFilterIndex,
            selectedLegendType: legendFilterIndex,
            selectedCountry: selectedCountry)));

    _loadData(ReadPolicy.cache_first);
  }

  Future<void> _loadData(ReadPolicy readPolicy) async {
    try {
      final countries = await _getCountriesUseCase.execute(readPolicy);

      final finalCountries = [defaultCountry, ...countries];

      final competitorsFilter = CompetitorsFilter(
          state.filters.selectedLegendType == 0
              ? null
              : state.filters.selectedLegendType == 1 || false,
          state.filters.selectedActiveType == 0
              ? null
              : state.filters.selectedActiveType == 1 || false,
          state.filters.selectedCountry?.id != Strings.default_filters_all
              ? state.filters.selectedCountry?.id
              : null);

      final competitors =
      await _getCompetitorsUseCase.execute(readPolicy, competitorsFilter);

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
    filters: state.filters.copyWith(countryOptions: finalCountries)));
    } on Exception {
    changeState(state.copyWith(
    list: DefaultState.error(Strings.network_error_message)));
    }
  }
}
