import 'package:hive/hive.dart';
import 'package:karate_stars_app/src/common/data/local/cache_data_source.dart';

part 'social_user_db.g.dart';

@HiveType(typeId: 2)
class SocialUserDB implements ModelDB {
  @HiveField(0)
  final String userName;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String image;

  @HiveField(3)
  final String url;

  @override
  @HiveField(4)
  final String lastUpdate;

  SocialUserDB(this.name, this.userName, this.image, this.url, this.lastUpdate);
}
