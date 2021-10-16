import 'package:karate_stars_app/src/events/domain/entities/event.dart';

class EventParser {
  List<Event> parse(List<dynamic> json) {
    return json.map((jsonItem) => _parse(jsonItem)).toList();
  }

  Event _parse(Map<String, dynamic> jsonData) {
    return Event(
        jsonData['id'], jsonData['name'], jsonData['typeId'], jsonData['year']);
  }
}
