import 'package:hive/hive.dart';
import 'package:karate_stars_app/src/common/data/local/cache_data_source.dart';
import 'package:karate_stars_app/src/news/data/local/models/social_user_db.dart';

part 'social_news_db.g.dart';

@HiveType(typeId:3)
class SocialNewsDB implements ModelDB {
  @HiveField(0)
  final String network;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String link;

  @HiveField(3)
  final String? image;

  @HiveField(4)
  final String? video;

  @HiveField(5)
  final String pubDate;

  @HiveField(6)
  final SocialUserDB user;

  @override
  @HiveField(7)
  final String lastUpdate;

  SocialNewsDB(this.network, this.link, this.title, this.image, this.video, this.pubDate,
      this.user, this.lastUpdate);
}
