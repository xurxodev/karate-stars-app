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

  final defaultEventType = Option.defaultOption();
  final defaultYear = Option.defaultOption();

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
            selectedEventType: defaultEventType.id,
            selectedYear: defaultYear.id)));

    _loadMetadataAndData(ReadPolicy.cache_first);
  }

  Future<void> refresh() {
    return _loadData(ReadPolicy.network_first);
  }

  void filter({String? selectedEventType, String? selectedYear}) {
    final filters = state.filters.copyWith(
        selectedEventType: selectedEventType ?? state.filters.selectedEventType,
        selectedYear: selectedYear ?? state.filters.selectedYear);

    _sendFilterEvent(filters);

    changeState(state.copyWith(filters: filters));

    _loadData(ReadPolicy.cache_first);
  }

  void _sendFilterEvent(EventsFilterState filters) {
    final eventTypeFilter = eventTypeOptions
        .firstWhere((option) => option.id == filters.selectedEventType);
    final yearFilter =
        yearOptions.firstWhere((option) => option.id == filters.selectedYear);

    final filter =
        'eventType: ${eventTypeFilter.name} year: ${yearFilter.name}}';
    super.analyticsService.sendEvent(EventsFilterEvent(filter));
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
      final year = Option.getIdOrNull(state.filters.selectedYear);

      final eventsFilter = EventsFilters(
          eventTypeId: Option.getIdOrNull(state.filters.selectedEventType),
          year: year != null ? int.parse(year) : null);

      final events = await _getEventsUseCase.execute(readPolicy, eventsFilter);

      changeState(state.copyWith(
          list: DefaultState.loaded(events),
          filters: state.filters.copyWith(
              eventTypeOptions: eventTypeOptions, yearOptions: yearOptions)));
    } on Exception {
      changeState(state.copyWith(
          list: DefaultState.error(Strings.network_error_message)));
    }
  }
}
