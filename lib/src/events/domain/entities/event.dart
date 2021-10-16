class Event {
  final String id;
  final String name;
  final String typeId;
  final int year;

  Event(this.id, this.name, this.typeId, this.year);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Event &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          typeId == other.typeId &&
          year == other.year;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ typeId.hashCode ^ year.hashCode;
}
