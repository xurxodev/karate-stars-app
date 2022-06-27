import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/rankings/domain/entities/ranking.dart';

abstract class RankingRepository {
  Future<List<Ranking>> getAll(ReadPolicy readPolicy);
}
