import 'dart:async';

import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/competitors/domain/get_competitors_use_case.dart';
import 'package:karate_stars_app/src/competitors/presentation/states/competitors_state.dart';

class CompetitorsBloc extends Bloc<CompetitorsState> {
  static const screen_name = 'home_competitors';
  final GetCompetitorsUseCase _getCompetitorsUseCase;

  CompetitorsBloc(this._getCompetitorsUseCase) {
    changeState(CompetitorsState(listState: DefaultState.loading()));
    _loadData(ReadPolicy.cache_first);
  }

  Future<void> refresh() {
    return _loadData(ReadPolicy.network_first);
  }

/*Future<void> changeFilters(int selectedCompetitorTypeIndex,
      int selectedCountryIndex, int selectedCategoryIndex) {
    final competitorFilter =
        _lastState.filters.competitorTypeOptions[selectedCompetitorTypeIndex];
    final categoryFilter =
        _lastState.filters.categoryOptions[selectedCategoryIndex];
    final countryFilter =
        _lastState.filters.countryOptions[selectedCountryIndex];

    final filter =
        'competitorType: $competitorFilter country: $countryFilter category: $categoryFilter';
    super.analyticsService.sendEvent(CompetitorsFilterEvent(filter));

    _loadData(ReadPolicy.cache_first);
  }*/

  Future<void> _loadData(ReadPolicy readPolicy) async {
    _getCompetitorsUseCase.execute(ReadPolicy.cache_first).then((data) {
      changeState(state.copyWith(listState: DefaultState.loaded(data)));
    }).catchError((error) {
      changeState(state.copyWith(
          listState: DefaultState.error(Strings.network_error_message)));
    });
  }
}
