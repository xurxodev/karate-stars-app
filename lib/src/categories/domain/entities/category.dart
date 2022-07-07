bool categoryParaKarateFilter(Category cat) => cat.paraKarate;

bool categoryCadetFilter(Category cat) => cat.name.contains('Cadet');

bool categoryJuniorFilter(Category cat) => cat.name.contains('Junior');

bool categoryU21Filter(Category cat) => cat.name.contains('U21');

bool categorySeniorFilter(Category cat) =>
    !categoryParaKarateFilter(cat) &&
    !categoryCadetFilter(cat) &&
    !categoryJuniorFilter(cat) &&
    !categoryU21Filter(cat);

class Category {
  final String id;
  final String name;
  final String typeId;
  final bool main;
  final bool paraKarate;

  Category(this.id, this.name, this.typeId, this.main, this.paraKarate);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Category &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          typeId == other.typeId &&
          main == other.main &&
          paraKarate == other.paraKarate;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      typeId.hashCode ^
      main.hashCode ^
      paraKarate.hashCode;
}
