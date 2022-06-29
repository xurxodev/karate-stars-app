import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/rankings/domain/entities/rankingEntry.dart';

abstract class RankingEntryRepository {
  Future<List<RankingEntry>> getByRankingAndCategory(
      ReadPolicy readPolicy, String rankingId, String categoryId);
}
