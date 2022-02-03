import 'package:hive/hive.dart';
import 'package:karate_stars_app/src/common/data/local/cache_data_source.dart';

part 'event_type_db.g.dart';

@HiveType(typeId:10)
class EventTypeDB implements ModelDB {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @override
  @HiveField(2)
  final String lastUpdate;

  EventTypeDB(this.id, this.name, this.lastUpdate);
}
