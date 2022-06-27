import 'package:karate_stars_app/src/common/data/local/DataBaseMapper.dart';
import 'package:karate_stars_app/src/rankings/data/local/ranking_db.dart';
import 'package:karate_stars_app/src/rankings/domain/entities/ranking.dart';

class RankingMapper implements DataBaseMapper<Ranking, RankingDB> {
  @override
  Ranking mapToDomain(RankingDB modelDB) {
    return Ranking(modelDB.id, modelDB.name, modelDB.image, modelDB.webUrl,
        modelDB.apiUrl, modelDB.categoryParameter, modelDB.categories);
  }

  @override
  RankingDB mapToDB(Ranking entity) {
    return RankingDB(
      entity.id,
      entity.name,
      entity.image,
      entity.webUrl,
      entity.apiUrl,
      entity.categoryParameter,
      entity.categories,
      DateTime.now().toIso8601String(),
    );
  }
}
