import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';

typedef AppState = DefaultState<AppStateData>;

class AppStateData {
  final bool isPremium;

  AppStateData({required this.isPremium});
}
