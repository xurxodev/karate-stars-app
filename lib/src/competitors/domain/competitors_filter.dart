class CompetitorsFilter {
  final bool? legendFilter;
  final bool? activeFilter;
  final String? countryId;
  final String? categoryTypeId;
  final String? categoryId;
  final String? searchTerm;

  CompetitorsFilter(
      {this.legendFilter,
      this.activeFilter,
      this.countryId,
      this.categoryTypeId,
      this.categoryId,
      this.searchTerm});
}
