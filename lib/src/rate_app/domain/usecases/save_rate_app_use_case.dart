import 'package:karate_stars_app/src/rate_app/domain/boundaries/rate_app_repository.dart';
import 'package:karate_stars_app/src/rate_app/domain/entities/rate_app.dart';

class SaveRateAppUseCase {
  final RateAppRepository _rateAppRepository;

  SaveRateAppUseCase(this._rateAppRepository);

  Future<void> execute(RateApp rateApp) async {
    return _rateAppRepository.save(rateApp);
  }
}
