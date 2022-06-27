class Ranking {
  final String id;
  final String name;
  final String image;
  final String webUrl;
  final String? apiUrl;
  final String? categoryParameter;
  final List<String> categories;

  Ranking(
      this.id, this.name, this.image, this.webUrl, this.apiUrl, this.categoryParameter,this.categories);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Ranking &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          image == other.image &&
          webUrl == other.webUrl &&
          apiUrl == other.apiUrl &&
          categoryParameter == other.categoryParameter &&
          categories == other.categories;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      image.hashCode ^
      webUrl.hashCode ^
      apiUrl.hashCode ^
      categoryParameter.hashCode ^
      categories.hashCode;
}
