abstract class Identifiable{
  final String id;

  Identifiable(this.id);
}

abstract class Mappable {
  Map<String, dynamic> toMap();
}
