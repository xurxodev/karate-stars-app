import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/rankings/domain/boundaries/ranking_repository.dart';
import 'package:karate_stars_app/src/rankings/domain/entities/ranking.dart';

class GetRankingsUseCase {
  final RankingRepository _rankingRepository;

  GetRankingsUseCase(this._rankingRepository);

  Future<List<Ranking>> execute(ReadPolicy readPolicy) async {
    return _rankingRepository.getAll(readPolicy);
  }
}
