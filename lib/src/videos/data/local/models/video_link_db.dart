import 'package:hive/hive.dart';

part 'video_link_db.g.dart';

@HiveType(typeId:13)
class VideoLinkDB {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String type;

  VideoLinkDB(this.id, this.type);
}
