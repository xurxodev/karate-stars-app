import 'package:floor/floor.dart';
import 'package:karate_stars_app/src/news/data/local/social_news_models.dart';

@dao
abstract class SocialUsersDao {
  @Query('SELECT * FROM SocialUsers')
  Future<List<SocialUserDB>> findAll();

  @insert
  Future<void> insertAll(List<SocialUserDB> socialUsersDB);

  @Query('DELETE FROM SocialUsers')
  Future<void> deleteAll();
}

@dao
abstract class SocialNewsDao {
  @Query('SELECT * FROM SocialNews')
  Future<List<SocialNewsDB>> findAll();

  @insert
  Future<void> insertAll(List<SocialNewsDB> socialNewsDB);

  @Query('DELETE FROM SocialNews')
  Future<void> deleteAll();
}
