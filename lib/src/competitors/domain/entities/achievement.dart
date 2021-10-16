class Achievement {
  final String eventId;
  final String categoryId;
  final int position;

  Achievement(this.eventId, this.categoryId, this.position);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Achievement &&
          runtimeType == other.runtimeType &&
          eventId == other.eventId &&
          categoryId == other.categoryId &&
          position == other.position;

  @override
  int get hashCode =>
      eventId.hashCode ^ categoryId.hashCode ^ position.hashCode;
}
