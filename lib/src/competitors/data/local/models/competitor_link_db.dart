import 'package:hive/hive.dart';

part 'competitor_link_db.g.dart';

@HiveType(typeId:7)
class CompetitorLinkDB {
  @HiveField(0)
  final String url;

  @HiveField(1)
  final String type;

  CompetitorLinkDB(this.url, this.type);
}
