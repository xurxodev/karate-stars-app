import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/competitors/domain/boundaries/competitor_repository.dart';
import 'package:karate_stars_app/src/competitors/domain/entities/competitor.dart';

class GetCompetitorsUseCase {
  final CompetitorRepository _competitorRepository;

  GetCompetitorsUseCase(this._competitorRepository);

  Future<List<Competitor>> execute(ReadPolicy readPolicy) async {
    final competitors = await _competitorRepository.getAll(readPolicy);

    return competitors;
  }
}
