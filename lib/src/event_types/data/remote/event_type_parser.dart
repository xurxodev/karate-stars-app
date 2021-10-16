import 'package:karate_stars_app/src/event_types/domain/entities/event_type.dart';

class EventTypeParser {
  List<EventType> parse(List<dynamic> json) {
    return json.map((jsonItem) => _parseCountry(jsonItem)).toList();
  }

  EventType _parseCountry(Map<String, dynamic> jsonData) {
    return EventType(jsonData['id'], jsonData['name']);
  }
}
