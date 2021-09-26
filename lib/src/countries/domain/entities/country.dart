class Country {
  final String id;
  final String name;
  final String iso2;
  final String image;

  Country(this.id, this.name, this.iso2,this.image);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Country &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          iso2 == other.iso2 &&
          image == other.image;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ iso2.hashCode ^ image.hashCode;
}