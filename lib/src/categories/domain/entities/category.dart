class Category {
  final String id;
  final String name;
  final String typeId;

  Category(this.id, this.name, this.typeId);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Category &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          typeId == other.typeId;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ typeId.hashCode;
}
