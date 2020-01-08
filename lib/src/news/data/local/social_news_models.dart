import 'package:floor/floor.dart';
import 'package:karate_stars_app/src/common/data/local/cache_data_source.dart';

@Entity(tableName: 'SocialUsers', indices: [
  Index(value: ['userName'], unique: true)
])
class SocialUserDB implements ModelDB {
  @PrimaryKey(autoGenerate: true)
  final int id;

  final String name;
  final String userName;
  final String image;
  final String url;

  @override
  final String lastUpdate;

  SocialUserDB(
      this.id, this.name, this.userName, this.image, this.url, this.lastUpdate);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SocialUserDB &&
          runtimeType == other.runtimeType &&
          userName == other.userName;

  @override
  int get hashCode => userName.hashCode;
}

@Entity(tableName: 'SocialNews', foreignKeys: [
  ForeignKey(
    childColumns: ['socialUserId'],
    parentColumns: ['id'],
    entity: SocialUserDB,
  )
])
class SocialNewsDB implements ModelDB {
  @PrimaryKey(autoGenerate: true)
  final int id;

  final String link;
  final String title;
  final String image;
  final String video;
  final String pubDate;
  final int socialUserId;

  @override
  final String lastUpdate;

  SocialNewsDB(this.id, this.link, this.title, this.image, this.video,
      this.pubDate, this.socialUserId, this.lastUpdate);
}
