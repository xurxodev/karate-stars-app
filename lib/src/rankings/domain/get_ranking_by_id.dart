import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/rankings/domain/boundaries/ranking_repository.dart';
import 'package:karate_stars_app/src/rankings/domain/entities/ranking.dart';

class GetRankingByIdUseCase {
  final RankingRepository _rankingRepository;

  GetRankingByIdUseCase(this._rankingRepository);

  Future<Ranking> execute(ReadPolicy readPolicy, String rankingId) async {
    final rankings = await _rankingRepository.getAll(readPolicy);

    return rankings.firstWhere((ranking) => ranking.id == rankingId);
  }
}
