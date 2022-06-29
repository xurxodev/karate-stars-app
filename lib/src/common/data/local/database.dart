import 'package:hive_flutter/hive_flutter.dart';
import 'package:karate_stars_app/src/categories/data/local/category_db.dart';
import 'package:karate_stars_app/src/category_types/data/local/category_type_db.dart';
import 'package:karate_stars_app/src/competitors/data/local/models/achievement_db.dart';
import 'package:karate_stars_app/src/competitors/data/local/models/competitor_db.dart';
import 'package:karate_stars_app/src/competitors/data/local/models/competitor_link_db.dart';
import 'package:karate_stars_app/src/countries/data/local/country_db.dart';
import 'package:karate_stars_app/src/event_types/data/local/event_type_db.dart';
import 'package:karate_stars_app/src/events/data/local/event_db.dart';
import 'package:karate_stars_app/src/news/data/local/models/current_news_db.dart';
import 'package:karate_stars_app/src/news/data/local/models/current_news_source_db.dart';
import 'package:karate_stars_app/src/news/data/local/models/social_news_db.dart';
import 'package:karate_stars_app/src/news/data/local/models/social_user_db.dart';
import 'package:karate_stars_app/src/rankings/data/local/ranking_db.dart';
import 'package:karate_stars_app/src/rankings/data/local/ranking_entry_db.dart';
import 'package:karate_stars_app/src/videos/data/local/models/video_db.dart';
import 'package:karate_stars_app/src/videos/data/local/models/video_link_db.dart';

class Database {
  /// The Store of this app.
  late final Box<CurrentNewsDB> currentNewsBox;
  late final Box<SocialNewsDB> socialNewsBox;
  late final Box<CategoryDB> categoriesBox;
  late final Box<CategoryTypeDB> categoryTypesBox;
  late final Box<CompetitorDB> competitorBox;
  late final Box<CountryDB> countriesBox;
  late final Box<EventTypeDB> eventTypesBox;
  late final Box<EventDB> eventsBox;
  late final Box<VideoDB> videosBox;
  late final Box<RankingDB> rankingsBox;
  late final Box<RankingEntryDB> rankingEntriesBox;

  Database._create(
      this.currentNewsBox,
      this.socialNewsBox,
      this.categoriesBox,
      this.categoryTypesBox,
      this.competitorBox,
      this.countriesBox,
      this.eventTypesBox,
      this.eventsBox,
      this.videosBox,
      this.rankingsBox,
      this.rankingEntriesBox);

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<Database> create() async {
    await Hive.initFlutter();

    Hive.registerAdapter<CurrentNewsSourceDB>(CurrentNewsSourceDBAdapter());
    Hive.registerAdapter<CurrentNewsDB>(CurrentNewsDBAdapter());
    Hive.registerAdapter<SocialUserDB>(SocialUserDBAdapter());
    Hive.registerAdapter<SocialNewsDB>(SocialNewsDBAdapter());
    Hive.registerAdapter<CategoryDB>(CategoryDBAdapter());
    Hive.registerAdapter<CategoryTypeDB>(CategoryTypeDBAdapter());
    Hive.registerAdapter<CompetitorDB>(CompetitorDBAdapter());
    Hive.registerAdapter<CompetitorLinkDB>(CompetitorLinkDBAdapter());
    Hive.registerAdapter<AchievementDB>(AchievementDBAdapter());
    Hive.registerAdapter<CountryDB>(CountryDBAdapter());
    Hive.registerAdapter<EventTypeDB>(EventTypeDBAdapter());
    Hive.registerAdapter<EventDB>(EventDBAdapter());
    Hive.registerAdapter<VideoDB>(VideoDBAdapter());
    Hive.registerAdapter<VideoLinkDB>(VideoLinkDBAdapter());
    Hive.registerAdapter<RankingDB>(RankingDBAdapter());
    Hive.registerAdapter<RankingEntryDB>(RankingEntryDBAdapter());

    final currentNewsBox = await Hive.openBox<CurrentNewsDB>('CurrentNews');
    final socialNewsBox = await Hive.openBox<SocialNewsDB>('SocialNews');
    final categoriesBox = await Hive.openBox<CategoryDB>('Categories');
    final categoryTypesBox =
        await Hive.openBox<CategoryTypeDB>('CategoryTypes');
    final competitorsBox = await Hive.openBox<CompetitorDB>('Competitors');
    final countriesBox = await Hive.openBox<CountryDB>('Countries');
    final eventTypesBox = await Hive.openBox<EventTypeDB>('EventTypes');
    final eventsBox = await Hive.openBox<EventDB>('Events');
    final videosBox = await Hive.openBox<VideoDB>('Videos');
    final rankingsBox = await Hive.openBox<RankingDB>('Rankings');
    final rankingEntriesBox =
        await Hive.openBox<RankingEntryDB>('RankingEntries');

    return Database._create(
        currentNewsBox,
        socialNewsBox,
        categoriesBox,
        categoryTypesBox,
        competitorsBox,
        countriesBox,
        eventTypesBox,
        eventsBox,
        videosBox,
        rankingsBox,
        rankingEntriesBox);
  }
}
