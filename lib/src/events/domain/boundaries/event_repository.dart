import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/events/domain/entities/event.dart';

abstract class EventRepository {
  Future<List<Event>> getAll(ReadPolicy readPolicy);
}
