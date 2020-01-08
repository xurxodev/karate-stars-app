
import 'package:floor/floor.dart';
import 'package:karate_stars_app/src/news/data/local/current_news_models.dart';

@dao
abstract class CurrentNewsSourcesDao {
  @Query('SELECT * FROM CurrentNewsSources')
  Future<List<CurrentNewsSourceDB>> findAll();

  @insert
  Future<void> insertAll(List<CurrentNewsSourceDB> currentNewsSourcesDB);

  @Query('DELETE FROM CurrentNewsSources')
  Future<void> deleteAll();
}

@dao
abstract class CurrentNewsDao {
  @Query('SELECT * FROM CurrentNews')
  Future<List<CurrentNewsDB>> findAll();

  @insert
  Future<void> insertAll(List<CurrentNewsDB> currentNewsDB);

  @Query('DELETE FROM CurrentNews')
  Future<void> deleteAll();
}



