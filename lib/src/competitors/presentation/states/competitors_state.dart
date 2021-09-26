import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/competitors/presentation/states/competitors_filter_state.dart';

class CompetitorsState {
  final DefaultState<List<CompetitorItemState>>? listState;
  final CompetitorsFilterState? filtersState;

  CompetitorsState({this.listState, this.filtersState});

  CompetitorsState copyWith(
      {DefaultState<List<CompetitorItemState>>? listState,
      CompetitorsFilterState? filtersState}) {
    return CompetitorsState(
        listState: listState ?? this.listState,
        filtersState: filtersState ?? this.filtersState);
  }
}

class CompetitorItemState{
  final String id;
  final String name;
  final String image;
  final String flag;

  CompetitorItemState(this.id,
      this.name,
      this.image,
      this.flag);
}


