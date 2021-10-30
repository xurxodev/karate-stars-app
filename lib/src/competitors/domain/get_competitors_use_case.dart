import 'package:collection/collection.dart';
import 'package:karate_stars_app/src/categories/domain/boundaries/category_repository.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/competitors/domain/boundaries/competitor_repository.dart';
import 'package:karate_stars_app/src/competitors/domain/competitors_filter.dart';
import 'package:karate_stars_app/src/competitors/domain/entities/competitor.dart';

class GetCompetitorsUseCase {
  final CompetitorRepository _competitorRepository;
  final CategoryRepository _categoryRepository;

  GetCompetitorsUseCase(this._competitorRepository, this._categoryRepository);

  Future<List<Competitor>> execute(ReadPolicy readPolicy,
      {CompetitorsFilter? competitorsFilter}) async {
    final competitors = await _competitorRepository.getAll(readPolicy);
    final categories = await _categoryRepository.getAll(readPolicy);

    final filteredCompetitors = competitors.where((competitor) {
      final competitorCategory = categories
          .firstWhereOrNull((element) => element.id == competitor.categoryId);

      return (competitorsFilter?.legendFilter == null ||
              competitor.isLegend == competitorsFilter?.legendFilter) &&
          (competitorsFilter?.activeFilter == null ||
              competitor.isActive == competitorsFilter?.activeFilter) &&
          (competitorsFilter?.countryId == null ||
              competitor.countryId == competitorsFilter?.countryId) &&
          (competitorsFilter?.categoryTypeId == null ||
              (competitorCategory != null &&
                  competitorCategory.typeId ==
                      competitorsFilter?.categoryTypeId)) &&
          (competitorsFilter?.categoryId == null ||
              competitor.categoryId == competitorsFilter?.categoryId) &&
          (competitorsFilter?.searchTerm == null ||
              competitor.fullName().toLowerCase().contains(competitorsFilter!.searchTerm!));
    }).toList();

    filteredCompetitors.sort((a, b) => a.lastName.compareTo(b.lastName));

    return filteredCompetitors;
  }
}
