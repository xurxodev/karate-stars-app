import 'package:karate_stars_app/src/rate_app/domain/entities/rate_app.dart';

abstract class RateAppRepository {
  Future<RateApp> get();
  Future<void> save(RateApp rateApp);
}
