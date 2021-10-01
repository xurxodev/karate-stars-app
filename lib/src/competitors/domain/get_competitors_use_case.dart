import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/competitors/domain/boundaries/competitor_repository.dart';
import 'package:karate_stars_app/src/competitors/domain/competitors_filter.dart';
import 'package:karate_stars_app/src/competitors/domain/entities/competitor.dart';

class GetCompetitorsUseCase {
  final CompetitorRepository _competitorRepository;

  GetCompetitorsUseCase(this._competitorRepository);

  Future<List<Competitor>> execute(
      ReadPolicy readPolicy, CompetitorsFilter competitorsFilter) async {
    final competitors = await _competitorRepository.getAll(readPolicy);

    final filteredCompetitors = competitors
        .where((competitor) =>
            (competitorsFilter.legendFilter == null ||
                competitor.isLegend == competitorsFilter.legendFilter) &&
            (competitorsFilter.activeFilter == null ||
                competitor.isActive == competitorsFilter.activeFilter) &&
            (competitorsFilter.countryId == null ||
                competitor.countryId == competitorsFilter.countryId))
        .toList();

    filteredCompetitors.sort((a, b) => a.lastName.compareTo(b.lastName));

    return filteredCompetitors;
  }
}
