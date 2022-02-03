import 'package:hive/hive.dart';

part 'achievement_db.g.dart';

@HiveType(typeId:8)
class AchievementDB{
  @HiveField(0)
  final String eventId;

  @HiveField(1)
  final String categoryId;

  @HiveField(3)
  final int position;

  AchievementDB(this.eventId, this.categoryId, this.position);
}
