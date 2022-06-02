import 'package:karate_stars_app/app_di.dart';
import 'package:karate_stars_app/src/home/presentation/blocs/home_bloc.dart';

void initAll() {
  initBlocAndUseCases();
}

void initBlocAndUseCases() {
  getIt.registerFactory(() => HomeBloc(getIt(), getIt(), getIt()));
}
