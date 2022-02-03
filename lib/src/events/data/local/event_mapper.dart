import 'package:karate_stars_app/src/common/data/local/DataBaseMapper.dart';
import 'package:karate_stars_app/src/events/data/local/event_db.dart';
import 'package:karate_stars_app/src/events/domain/entities/event.dart';

class EventMapper implements DataBaseMapper<Event, EventDB> {
  @override
  Event mapToDomain(EventDB modelDB) {
    return Event(modelDB.id, modelDB.name, modelDB.typeId, modelDB.year);
  }

  @override
  EventDB mapToDB(Event entity) {
    return EventDB(
      entity.id,
      entity.name,
      entity.typeId,
      entity.year,
      DateTime.now().toIso8601String(),
    );
  }
}
