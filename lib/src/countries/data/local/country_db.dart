import 'package:hive/hive.dart';
import 'package:karate_stars_app/src/common/data/local/cache_data_source.dart';

part 'country_db.g.dart';

@HiveType(typeId: 9)
class CountryDB implements ModelDB {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String iso2;

  @HiveField(3)
  final String image;

  @override
  @HiveField(4)
  final String lastUpdate;

  CountryDB(this.id, this.name, this.iso2, this.image, this.lastUpdate);
}
