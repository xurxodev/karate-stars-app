import 'package:floor/floor.dart';
import 'package:karate_stars_app/src/common/data/local/cache_data_source.dart';

@Entity(tableName: 'CurrentNewsSources', indices: [
  Index(value: ['url'], unique: true)
])
class CurrentNewsSourceDB implements ModelDB {
  @PrimaryKey(autoGenerate: true)
  final int id;

  final String url;
  final String name;
  final String image;

  @override
  final String lastUpdate;

  CurrentNewsSourceDB(
      this.id, this.url, this.name, this.image, this.lastUpdate);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrentNewsSourceDB &&
          runtimeType == other.runtimeType &&
          url == other.url;

  @override
  int get hashCode => url.hashCode;
}

@Entity(tableName: 'CurrentNews', foreignKeys: [
  ForeignKey(
    childColumns: ['sourceId'],
    parentColumns: ['id'],
    entity: CurrentNewsSourceDB,
  )
])
class CurrentNewsDB implements ModelDB {
  @PrimaryKey(autoGenerate: true)
  final int id;

  final String link;
  final String title;
  final String image;
  final String pubDate;
  final int sourceId;

  @override
  final String lastUpdate;

  CurrentNewsDB(this.id, this.link, this.title, this.image, this.pubDate,
      this.sourceId, this.lastUpdate);
}
