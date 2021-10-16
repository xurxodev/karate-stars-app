import 'package:karate_stars_app/src/event_types/domain/entities/event_type.dart';

EventType worldChampionships() {
  return EventType('Jr6N73CZWtE', 'World Championships');
}

EventType europeanChampionships() {
  return EventType('FEJ08kkHhqi', 'European Championships');
}

List<EventType> allEventTypes() {
  return [worldChampionships(), europeanChampionships()];
}
