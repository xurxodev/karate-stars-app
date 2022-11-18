import 'package:karate_stars_app/src/common/auth/credentials.dart';
import 'package:karate_stars_app/src/global_di.dart';
import 'package:karate_stars_app/src/search/presentation/blocs/search_bloc.dart';

void initAll(String apiUrl, Credentials apiCredentials) {
  initBlocAndUseCases();
}

void initBlocAndUseCases() {
  getIt.registerFactory(
      () => SearchBloc(getIt(), getIt(), getIt(), getIt(), getIt()));
}
