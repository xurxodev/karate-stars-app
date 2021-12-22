import 'package:floor/floor.dart';
import 'package:karate_stars_app/src/common/data/local/cache_data_source.dart';

@Entity(tableName: 'SocialUsers', indices: [
  Index(value: ['userName'], unique: true)
])
class SocialUserDB extends ModelDB {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String name;
  final String userName;
  final String image;
  final String url;

  SocialUserDB(this.id, this.name, this.userName, this.image, this.url,
      String lastUpdate)
      : super(lastUpdate);

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
class SocialNewsDB extends ModelDB {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String link;
  final String title;
  final String? image;
  final String? video;
  final String pubDate;
  final int socialUserId;
  final String network;

  SocialNewsDB(this.id, this.network, this.link, this.title, this.image, this.video,
      this.pubDate, this.socialUserId, String lastUpdate)
      : super(lastUpdate);
}
