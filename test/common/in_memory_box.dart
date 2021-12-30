import 'package:hive/hive.dart';

class InMemoryBox<ModelDB> implements Box<ModelDB> {
  List<ModelDB> items = [];

  InMemoryBox(this.items);

  @override
  Future<int> add(ModelDB value) async {
    items.add(value);

    return Future.value(0);
  }

  @override
  Future<Iterable<int>> addAll(Iterable<ModelDB> values) {
    items.addAll(values);

    return Future.value(const Iterable.empty());
  }

  @override
  Future<int> clear() {
    items.clear();

    return Future.value(0);
  }

  @override
  Future<void> close() async {}

  @override
  Future<void> compact() async {}

  @override
  bool containsKey(key) {
    return false;
  }

  @override
  Future<void> delete(key) async {
  }

  @override
  Future<void> deleteAll(Iterable keys) async{

  }

  @override
  Future<void> deleteAt(int index) async{

  }

  @override
  Future<void> deleteFromDisk() async{

  }

  @override
  Future<void> flush()async {

  }

  @override
  ModelDB? get(key, {ModelDB? defaultValue}) {
    return null;
  }

  @override
  ModelDB? getAt(int index) {
    return null;
  }

  @override
  bool get isEmpty => items.isEmpty;

  @override
  bool get isNotEmpty => items.isNotEmpty;

  @override
  bool get isOpen => true;

  @override
  dynamic keyAt(int index)  {
    return null;
  }

  @override
  Iterable get keys => throw UnimplementedError();

  @override
  bool get lazy => throw UnimplementedError();

  @override
  int get length => throw UnimplementedError();

  @override
  String get name => throw UnimplementedError();

  @override
  String? get path => throw UnimplementedError();

  @override
  Future<void> put(key, ModelDB value) {
    throw UnimplementedError();
  }

  @override
  Future<void> putAll(Map<dynamic, ModelDB> entries) {
    throw UnimplementedError();
  }

  @override
  Future<void> putAt(int index, ModelDB value) {
    throw UnimplementedError();
  }

  @override
  Map<dynamic, ModelDB> toMap() {
    throw UnimplementedError();
  }

  @override
  Iterable<ModelDB> get values => items;

  @override
  Iterable<ModelDB> valuesBetween({startKey, endKey}) {
    throw UnimplementedError();
  }

  @override
  Stream<BoxEvent> watch({key}) {
    throw UnimplementedError();
  }
}
