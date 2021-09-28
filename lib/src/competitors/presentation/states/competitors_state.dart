import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/competitors/presentation/states/competitors_filter_state.dart';

class CompetitorsState {
  final DefaultState<List<CompetitorItemState>> list;
  final CompetitorsFilterState filters;

  CompetitorsState({required this.filters, required this.list});

  CompetitorsState copyWith(
      {DefaultState<List<CompetitorItemState>>? list,
      CompetitorsFilterState? filters}) {
    return CompetitorsState(
        list: list ?? this.list,
        filters: filters ?? this.filters);
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


