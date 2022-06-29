import 'package:karate_stars_app/src/common/data/local/DataBaseMapper.dart';
import 'package:karate_stars_app/src/rankings/data/local/ranking_entry_db.dart';
import 'package:karate_stars_app/src/rankings/domain/entities/rankingEntry.dart';

class RankingEntryMapper
    implements DataBaseMapper<RankingEntry, RankingEntryDB> {
  @override
  RankingEntry mapToDomain(RankingEntryDB modelDB) {
    return RankingEntry(
      modelDB.id,
      modelDB.rankingId,
      modelDB.rank,
      modelDB.country,
      modelDB.countryCode,
      modelDB.name,
      modelDB.firstName,
      modelDB.lastName,
      modelDB.wkfId,
      modelDB.photo,
      modelDB.totalPoints,
      modelDB.continentalCode,
      modelDB.categoryId,
      modelDB.categoryWkfId,
    );
  }

  @override
  RankingEntryDB mapToDB(RankingEntry entity) {
    return RankingEntryDB(
      entity.id,
      entity.rankingId,
      entity.rank,
      entity.country,
      entity.countryCode,
      entity.name,
      entity.firstName,
      entity.lastName,
      entity.wkfId,
      entity.photo,
      entity.totalPoints,
      entity.continentalCode,
      entity.categoryId,
      entity.categoryWkfId,
      DateTime.now().toIso8601String(),
    );
  }
}
