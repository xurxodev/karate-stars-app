
import 'package:karate_stars_app/src/common/data/local/cache_data_source.dart';
import 'package:hive/hive.dart';
import 'package:karate_stars_app/src/news/data/local/models/social_user_db.dart';

part 'social_news_db.g.dart';

@HiveType(typeId:3)
class SocialNewsDB implements ModelDB {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String link;

  @HiveField(2)
  final String image;

  @HiveField(3)
  final String video;

  @HiveField(4)
  final String pubDate;

  @HiveField(5)
  final SocialUserDB user;

  @override
  @HiveField(6)
  final String lastUpdate;

  SocialNewsDB(this.link, this.title, this.image, this.video, this.pubDate,
      this.user, this.lastUpdate);
}
