import 'package:karate_stars_app/src/common/data/local/DataBaseMapper.dart';
import 'package:karate_stars_app/src/event_types/data/local/event_type_db.dart';
import 'package:karate_stars_app/src/event_types/domain/entities/event_type.dart';

class EventTypeMapper
    implements DataBaseMapper<EventType, EventTypeDB> {
  @override
  EventType mapToDomain(EventTypeDB modelDB) {
    return EventType(modelDB.id, modelDB.name);
  }

  @override
  EventTypeDB mapToDB(EventType entity) {
    return EventTypeDB(
      entity.id,
      entity.name,
      DateTime.now().toIso8601String(),
    );
  }
}
