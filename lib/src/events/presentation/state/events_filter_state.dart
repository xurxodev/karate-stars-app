import 'package:karate_stars_app/src/common/presentation/states/option.dart';

class EventsFilterState {
  final List<Option> eventTypeOptions;
  final List<Option> yearOptions;

  final String selectedEventType;
  final String selectedYear;

  EventsFilterState(
      {required this.eventTypeOptions,
      required this.yearOptions,
      required this.selectedEventType,
      required this.selectedYear});

  EventsFilterState copyWith(
      {List<Option>? eventTypeOptions,
      List<Option>? yearOptions,
      String? selectedEventType,
      String? selectedYear}) {
    return EventsFilterState(
        eventTypeOptions: eventTypeOptions ?? this.eventTypeOptions,
        yearOptions: yearOptions ?? this.yearOptions,
        selectedEventType: selectedEventType ?? this.selectedEventType,
        selectedYear: selectedYear ?? this.selectedYear);
  }

  bool get anyFilter {
    return eventTypeOptions.isNotEmpty &&
            selectedEventType != eventTypeOptions[0].id ||
        yearOptions.isNotEmpty && selectedYear != yearOptions[0].id;
  }
}
