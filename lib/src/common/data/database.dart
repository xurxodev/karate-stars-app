import 'dart:async';
import 'package:floor/floor.dart';
import 'package:karate_stars_app/src/news/data/local/current_news_daos.dart';
import 'package:karate_stars_app/src/news/data/local/current_news_models.dart';
import 'package:karate_stars_app/src/news/data/local/social_news_daos.dart';
import 'package:karate_stars_app/src/news/data/local/social_news_models.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart'; // the generated code will be there

@Database(
    version: 1,
    entities: [CurrentNewsDB, CurrentNewsSourceDB, SocialNewsDB, SocialUserDB])
abstract class AppDatabase extends FloorDatabase {
  CurrentNewsDao get currentNewsDao;

  CurrentNewsSourcesDao get currentNewsSourcesDao;

  SocialNewsDao get socialNewsDao;

  SocialUsersDao get socialUsersDao;
}
