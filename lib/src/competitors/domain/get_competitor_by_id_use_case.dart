import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/competitors/domain/boundaries/competitor_repository.dart';
import 'package:karate_stars_app/src/competitors/domain/entities/competitor.dart';

class GetCompetitorByIdUseCase {
  final CompetitorRepository _competitorRepository;

  GetCompetitorByIdUseCase(this._competitorRepository);

  Future<Competitor> execute(ReadPolicy readPolicy, String competitorId) async {
    final competitors = await _competitorRepository.getAll(readPolicy);

    final competitor = competitors
        .firstWhere((competitor) => competitor.id == competitorId);

    return competitor;
  }
}
