import 'package:karate_stars_app/src/common/strings.dart';

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

  factory Option.defaultOption() {
    return Option(Strings.default_filters_all, Strings.default_filters_all);
  }

  static String? getIdOrNull(String id) =>
      id != Strings.default_filters_all ? id : null;
}
