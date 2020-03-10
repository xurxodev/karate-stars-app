import 'package:karate_stars_app/app_di.dart' as app_di;
import 'package:karate_stars_app/src/browser/presentation/blocs/browser_bloc.dart';

void init(){
  app_di.getIt.registerFactory(() => BrowserBloc());
}
