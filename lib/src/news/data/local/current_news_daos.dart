
import 'package:floor/floor.dart';
import 'package:karate_stars_app/src/news/data/local/current_news_models.dart';

@dao
abstract class CurrentNewsSourcesDao {
  @Query('SELECT * FROM CurrentNewsSources')
  Future<List<CurrentNewsSourceDB>> findAll();

  @Insert()
  Future<void> insert(List<CurrentNewsSourceDB> currentNewsSourcesDB);
}

@dao
abstract class CurrentNewsDao {
  @Query('SELECT * FROM CurrentNews')
  Future<List<CurrentNewsDB>> findAll();

  @Insert()
  Future<void> insert(List<CurrentNewsDB> currentNewsDB);
}



