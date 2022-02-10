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
  final DateTime startDate;

  @HiveField(4)
  final DateTime endDate;

  @HiveField(5)
  final String? url;

  @override
  @HiveField(6)
  final String lastUpdate;

  EventDB(this.id, this.name, this.typeId, this.startDate, this.endDate,
      this.url, this.lastUpdate);
}
