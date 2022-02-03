import 'package:hive/hive.dart';
import 'package:karate_stars_app/src/common/data/local/cache_data_source.dart';

part 'category_db.g.dart';

@HiveType(typeId:4)
class CategoryDB implements ModelDB {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String typeId;

  @override
  @HiveField(3)
  final String lastUpdate;

  CategoryDB(this.id, this.name, this.typeId, this.lastUpdate);
}
