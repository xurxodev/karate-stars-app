class Achievement {
  final String name;
  final List<AchievementDetail> details;

  Achievement(this.name, this.details);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Achievement &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          details == other.details;

  @override
  int get hashCode => name.hashCode ^ details.hashCode;
}

class AchievementDetail {
  final String category;
  final String name;
  final int position;

  AchievementDetail(this.category, this.name, this.position);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AchievementDetail &&
          runtimeType == other.runtimeType &&
          category == other.category &&
          name == other.name &&
          position == other.position;

  @override
  int get hashCode => category.hashCode ^ name.hashCode ^ position.hashCode;
}
