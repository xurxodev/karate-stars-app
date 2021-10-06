class Option {
  final String id;
  final String name;

  Option(this.id, this.name);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Option &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}