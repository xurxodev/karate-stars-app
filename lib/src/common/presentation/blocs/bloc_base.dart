import 'dart:async';

import 'package:flutter/widgets.dart';

abstract class BlocBase {

  void dispose();
}

// TODO(xurxodev): Remove BlocBase and rename this to BlocBase
abstract class Bloc <T> extends BlocBase {

  final _stateController = StreamController<T>.broadcast();
  T _state;

  T get state => _state;
  Stream<T> get observableState => _stateController.stream;

  @protected
  void changeState(T state) {
    _state = state;
    _stateController.sink.add(state);
  }

  @override
  void dispose(){
    _stateController.close();
  }
}
