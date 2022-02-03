import 'package:hive/hive.dart';
import 'package:karate_stars_app/src/common/data/local/cache_data_source.dart';
import 'package:karate_stars_app/src/videos/data/local/models/video_link_db.dart';

part 'video_db.g.dart';

@HiveType(typeId: 12)
class VideoDB implements ModelDB {
  @HiveField(0)
  final String id;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String subtitle;

  @HiveField(4)
  final String description;

  @HiveField(5)
  final List<String> competitors;

  @HiveField(6)
  final DateTime eventDate;

  @HiveField(7)
  final DateTime createdDate;

  @HiveField(8)
  final int order;

  @HiveField(9)
  final bool isLive;

  @HiveField(10)
  final List<VideoLinkDB> links;

  @override
  @HiveField(11)
  final String lastUpdate;

  VideoDB(
      this.id,
      this.title,
      this.subtitle,
      this.description,
      this.competitors,
      this.eventDate,
      this.createdDate,
      this.order,
      this.isLive,
      this.links,
      this.lastUpdate);
}
