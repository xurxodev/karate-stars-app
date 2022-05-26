import 'package:karate_stars_app/src/rate_app/domain/boundaries/rate_app_repository.dart';
import 'package:karate_stars_app/src/rate_app/domain/entities/rate_app.dart';

class GetRateAppUseCase {
  final RateAppRepository _rateAppRepository;

  GetRateAppUseCase(this._rateAppRepository);

  Future<RateApp> execute() async {
    return _rateAppRepository.get();
  }
}
