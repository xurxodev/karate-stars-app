import 'package:karate_stars_app/src/common/presentation/states/option.dart';

class EventsFilterState {
  final List<Option> eventTypeOptions;
  final List<Option> yearOptions;

  final Option? selectedEventType;
  final Option? selectedYear;

  EventsFilterState(
      {required this.eventTypeOptions,
      required this.yearOptions,
      this.selectedEventType,
      this.selectedYear});

  EventsFilterState copyWith(
      {List<Option>? eventTypeOptions,
      List<Option>? yearOptions,
      Option? selectedEventType,
      Option? selectedYear}) {
    return EventsFilterState(
        eventTypeOptions: eventTypeOptions ?? this.eventTypeOptions,
        yearOptions: yearOptions ?? this.yearOptions,
        selectedEventType: selectedEventType ?? this.selectedEventType,
        selectedYear: selectedYear ?? this.selectedYear);
  }
}
