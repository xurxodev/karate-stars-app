import 'package:hive/hive.dart';
import 'package:karate_stars_app/src/common/data/local/cache_data_source.dart';
import 'package:karate_stars_app/src/news/data/local/models/current_news_source_db.dart';

part 'current_news_db.g.dart';

@HiveType(typeId:1)
class CurrentNewsDB implements ModelDB {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String link;

  @HiveField(2)
  final String? image;

  @HiveField(3)
  final String? video;

  @HiveField(4)
  final String pubDate;

  @HiveField(5)
  final CurrentNewsSourceDB source;

  @override
  @HiveField(6)
  final String lastUpdate;

  CurrentNewsDB(this.title, this.link, this.image, this.video, this.pubDate,
      this.source, this.lastUpdate);
}
