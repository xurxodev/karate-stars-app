import 'package:floor/floor.dart';

@Entity(
  tableName: 'CurrentNewsSources',
)
class CurrentNewsSourceDB {
  @PrimaryKey(autoGenerate: true)
  final int id;

  final String url;

  final String name;

  final String image;

  final String lastUpdateMillis;

  CurrentNewsSourceDB(this.id, this.url, this.name, this.image, this.lastUpdateMillis);
}

@Entity(tableName: 'CurrentNews', foreignKeys: [
  ForeignKey(
    childColumns: ['sourceId'],
    parentColumns: ['id'],
    entity: CurrentNewsSourceDB,
  )
])
class CurrentNewsDB {
  @PrimaryKey(autoGenerate: true)
  final int id;

  final String link;

  final String title;
  final String image;
  final String pubDate;
  final String lastUpdateMillis;

  final int sourceId;

  CurrentNewsDB(this.id, this.link, this.title, this.image, this.pubDate,
      this.lastUpdateMillis, this.sourceId);
}
