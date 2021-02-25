import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/competitors/domain/entities/competitor.dart';
import 'package:karate_stars_app/src/competitors/presentation/states/competitors_filter_state.dart';

class CompetitorsState {
  final DefaultState<List<Competitor>> listState;
  final CompetitorsFilterState filtersState;

  CompetitorsState({this.listState, this.filtersState});
  
  CompetitorsState copyWith({DefaultState<List<Competitor>> listState,
    CompetitorsFilterState filtersState}) {
    return CompetitorsState(
        listState: listState ?? this.listState,
        filtersState: filtersState ?? this.filtersState);
  }
}