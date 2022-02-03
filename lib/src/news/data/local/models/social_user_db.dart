import 'package:hive/hive.dart';

part 'social_user_db.g.dart';

@HiveType(typeId: 2)
class SocialUserDB{
  @HiveField(0)
  final String userName;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String image;

  @HiveField(3)
  final String url;

  SocialUserDB(this.name, this.userName, this.image, this.url);
}
