class CategoryType {
  final String id;
  final String name;

  CategoryType(this.id, this.name);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryType &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
