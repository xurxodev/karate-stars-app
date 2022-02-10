import 'dart:async';

import 'package:karate_stars_app/src/common/analytics/events.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_home_list_content.dart';
import 'package:karate_stars_app/src/common/presentation/boundaries/analytics.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/common/presentation/states/option.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/event_types/domain/get_event_types.dart';
import 'package:karate_stars_app/src/events/domain/events_filter.dart';
import 'package:karate_stars_app/src/events/domain/get_events.dart';
import 'package:karate_stars_app/src/events/presentation/state/events_filter_state.dart';
import 'package:karate_stars_app/src/events/presentation/state/events_state.dart';

class EventsBloc extends BlocHomeListContent<EventsState> {
  static const screen_name = 'events';
  final GetEventsUseCase _getEventsUseCase;
  final GetEventTypesUseCase _getEventTypesUseCase;

  final defaultEventType =
      Option(Strings.default_filters_all, Strings.default_filters_all);
  final defaultYear =
      Option(Strings.default_filters_all, Strings.default_filters_all);

  List<Option> eventTypeOptions = [];
  List<Option> yearOptions = [];

  EventsBloc(this._getEventsUseCase, this._getEventTypesUseCase,
      AnalyticsService _analyticsService)
      : super(_analyticsService, screen_name) {
    changeState(EventsState(
        list: DefaultState.loading(),
        filters: EventsFilterState(
            eventTypeOptions: [],
            yearOptions: [],
            selectedEventType: defaultEventType,
            selectedYear: defaultYear)));

    _loadMetadataAndData(ReadPolicy.cache_first);
  }

  Future<void> refresh() {
    return _loadData(ReadPolicy.network_first);
  }

  void filter({Option? selectedEventType, Option? selectedYear}) {
    final filter =
        'eventType: ${selectedEventType?.name} year: ${selectedYear?.name}}';
    super.analyticsService.sendEvent(EventsFilterEvent(filter));

    changeState(state.copyWith(
        filters: EventsFilterState(
            eventTypeOptions: state.filters.eventTypeOptions,
            yearOptions: state.filters.yearOptions,
            selectedEventType:
            selectedEventType ?? state.filters.selectedEventType,
            selectedYear: selectedYear ?? state.filters.selectedYear)));

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
    eventTypeOptions = [
      defaultEventType,
      ...(await _getEventTypesUseCase.execute(readPolicy))
          .map((item) => Option(item.id, item.name))
    ];

    final events = await _getEventsUseCase.execute(readPolicy, EventsFilters());
    final years = events.map((event) => Option(
        event.startDate.year.toString(), event.startDate.year.toString()));
    final finalYears = years.toSet().toList();

    yearOptions = [defaultYear, ...finalYears];
  }

  Future<void> _loadData(ReadPolicy readPolicy) async {
    try {
      final eventsFilter = EventsFilters(
          eventTypeId: state.filters.selectedEventType?.id !=
                  Strings.default_filters_all
              ? state.filters.selectedEventType?.id
              : null,
          year: state.filters.selectedYear?.id != Strings.default_filters_all
              ? int.parse(state.filters.selectedYear!.id)
              : null);

      final events = await _getEventsUseCase.execute(readPolicy, eventsFilter);

      changeState(state.copyWith(
          list: DefaultState.loaded(events),
          filters: state.filters.copyWith(
              eventTypeOptions: eventTypeOptions,
              yearOptions: yearOptions)));
    } on Exception {
      changeState(state.copyWith(
          list: DefaultState.error(Strings.network_error_message)));
    }
  }
}
