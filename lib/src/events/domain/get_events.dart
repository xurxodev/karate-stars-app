import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/events/domain/boundaries/event_repository.dart';
import 'package:karate_stars_app/src/events/domain/entities/event.dart';
import 'package:karate_stars_app/src/events/domain/events_filter.dart';

class GetEventsUseCase {
  final EventRepository _eventRepository;

  GetEventsUseCase(this._eventRepository);

  Future<List<Event>> execute(ReadPolicy readPolicy,EventsFilters eventFilters) async {
    final events = await _eventRepository.getAll(readPolicy);

    final filteredEvents = events.where((event) {
      return (eventFilters.eventTypeId == null ||
          event.typeId == eventFilters.eventTypeId) &&
          (eventFilters.year == null ||
              event.startDate.year == eventFilters.year);
    }).toList();

    filteredEvents.sort((a, b) => b.startDate.compareTo(a.startDate));

    return filteredEvents;
  }
}
