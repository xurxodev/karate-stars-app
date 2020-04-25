enum CompetitorsTypeFilter { all, stars, legends }

class CompetitorsFilter {
  final CompetitorsTypeFilter competitorsTypeFilter;
  final String countryId;
  final String categoryId;

  CompetitorsFilter(
      [this.competitorsTypeFilter = CompetitorsTypeFilter.all,
      this.countryId = '',
      this.categoryId = '']);
}
