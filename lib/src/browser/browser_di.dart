import 'package:karate_stars_app/dependencies_provider.dart';
import 'package:karate_stars_app/src/browser/presentation/blocs/browser_bloc.dart';

void init(){
  getIt.registerFactory(() => BrowserBloc());
}
