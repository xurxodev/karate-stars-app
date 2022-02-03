import 'package:hive/hive.dart';
import 'package:karate_stars_app/src/common/data/local/cache_data_source.dart';

part 'event_db.g.dart';

@HiveType(typeId: 11)
class EventDB implements ModelDB {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String typeId;

  @HiveField(3)
  final int year;

  @override
  @HiveField(4)
  final String lastUpdate;

  EventDB(this.id, this.name, this.typeId, this.year, this.lastUpdate);
}
