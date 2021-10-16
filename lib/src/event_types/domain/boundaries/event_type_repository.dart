import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/event_types/domain/entities/event_type.dart';

abstract class EventTypeRepository {
  Future<List<EventType>> getAll(ReadPolicy readPolicy);
}
