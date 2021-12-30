
import 'package:hive/hive.dart';
import 'package:karate_stars_app/src/common/data/local/cache_data_source.dart';

part 'current_news_source_db.g.dart';

@HiveType(typeId:0)
class CurrentNewsSourceDB implements ModelDB {
  @HiveField(0)
  final String url;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String image;

  @override
  @HiveField(3)
  final String lastUpdate;

  CurrentNewsSourceDB(this.url, this.name, this.image, this.lastUpdate);
}
