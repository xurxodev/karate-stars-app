import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/events/domain/entities/event.dart';
import 'package:karate_stars_app/src/events/presentation/state/events_filter_state.dart';

class EventsState {
  final DefaultState<List<Event>> list;
  final EventsFilterState filters;

  EventsState({required this.filters, required this.list});

  EventsState copyWith(
      {DefaultState<List<Event>>? list, EventsFilterState? filters}) {
    return EventsState(
        list: list ?? this.list, filters: filters ?? this.filters);
  }
}
