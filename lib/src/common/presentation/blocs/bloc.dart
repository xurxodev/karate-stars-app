import 'dart:async';

import 'package:flutter/widgets.dart';

// TODO(xurxodev): Remove BlocBase and rename this to BlocBase
abstract class Bloc<T> {
  final _stateController = StreamController<T>.broadcast();
  late T _state;

  T get state => _state;
  Stream<T> get observableState => _stateController.stream;

  @protected
  void changeState(T state) {
    _state = state;
    _stateController.sink.add(state);
  }

  void dispose() {
    _stateController.close();
  }
}
