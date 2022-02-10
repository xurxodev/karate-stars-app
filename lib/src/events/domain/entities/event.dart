class Event {
  final String id;
  final String name;
  final String typeId;
  final DateTime startDate;
  final DateTime endDate;
  final String? url;

  Event(
      this.id, this.name, this.typeId, this.startDate, this.endDate, this.url);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Event &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          typeId == other.typeId &&
          startDate == other.startDate &&
          endDate == other.endDate &&
          url == other.url;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      typeId.hashCode ^
      startDate.hashCode ^
      endDate.hashCode ^
      url.hashCode;
}
