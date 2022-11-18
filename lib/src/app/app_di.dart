import 'package:karate_stars_app/src/app/app_bloc.dart';
import 'package:karate_stars_app/src/global_di.dart';

void initAll() {
  initBlocAndUseCases();
}

void initBlocAndUseCases() {
  getIt.registerFactory(() => AppBloc(getIt()));
}

