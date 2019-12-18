import 'dart:async';

import 'package:karate_stars_app/src/common/presentation/blocs/bloc_base.dart';

class BrowserBloc extends BlocBase{
  String _url;
  final _urlController = StreamController<String>.broadcast();

  void init(String url) {
    _url = url;
    _urlController.sink.add(_url);
  }

  Stream<String> get url => _urlController.stream;

  @override
  void dispose() {
    _urlController.close();
  }

}