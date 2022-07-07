import 'dart:async';

import 'package:karate_stars_app/src/common/presentation/blocs/bloc.dart';

abstract class BlocSearchable<T> extends Bloc<T> {
  Timer? _debounce;

  Future<void> executeSearch(String searchTerm);

  Future<void> search(String searchTerm) async {
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 400), () {
      print('Search: $searchTerm');
      executeSearch(searchTerm);
    });
  }
}
