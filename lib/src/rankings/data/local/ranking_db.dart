import 'package:hive/hive.dart';
import 'package:karate_stars_app/src/common/data/local/cache_data_source.dart';

part 'ranking_db.g.dart';

@HiveType(typeId: 14)
class RankingDB implements ModelDB {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String image;

  @HiveField(3)
  final String webUrl;

  @HiveField(4)
  final String? apiUrl;

  @HiveField(5)
  final String? categoryParameter;

  @HiveField(6)
  final List<String> categories;

  @override
  @HiveField(7)
  final String lastUpdate;

  RankingDB(this.id, this.name, this.image, this.webUrl, this.apiUrl,
      this.categoryParameter,this.categories, this.lastUpdate);
}
