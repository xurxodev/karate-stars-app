import 'package:karate_stars_app/src/app/app_state.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/purchases/domain/usecases/is_premium.dart';

class AppBloc extends Bloc<AppState> {
  final IsPremiumUseCase _isPremiumUseCase;

  AppBloc(this._isPremiumUseCase) {
    changeState(DefaultState.loaded(AppStateData(isPremium: false)));

    _isPremiumUseCase.execute().listen((isPremium) {
      changeState(DefaultState.loaded(AppStateData(isPremium: isPremium)));
    },onError: (error) {
      changeState(DefaultState.loaded(AppStateData(isPremium: false)));
    });
  }
}
