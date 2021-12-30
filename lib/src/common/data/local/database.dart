

import 'package:hive_flutter/hive_flutter.dart';
import 'package:karate_stars_app/src/news/data/local/models/current_news_db.dart';
import 'package:karate_stars_app/src/news/data/local/models/current_news_source_db.dart';
import 'package:karate_stars_app/src/news/data/local/models/social_news_db.dart';
import 'package:karate_stars_app/src/news/data/local/models/social_user_db.dart';

class Database {
  /// The Store of this app.
  late final Box<CurrentNewsDB> currentNewsBox;
  late final Box<SocialNewsDB> socialNewsBox;

  Database._create(this.currentNewsBox, this.socialNewsBox);

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<Database> create() async {
    await Hive.initFlutter();

    Hive.registerAdapter<CurrentNewsSourceDB>(CurrentNewsSourceDBAdapter());
    Hive.registerAdapter<CurrentNewsDB>(CurrentNewsDBAdapter());
    Hive.registerAdapter<SocialUserDB>(SocialUserDBAdapter());
    Hive.registerAdapter<SocialNewsDB>(SocialNewsDBAdapter());

    final currentNewsBox = await Hive.openBox<CurrentNewsDB>('CurrentNews');
    final socialNewsBox = await Hive.openBox<SocialNewsDB>('SocialNews');



    return Database._create(currentNewsBox, socialNewsBox);
  }
}