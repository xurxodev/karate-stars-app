import 'package:karate_stars_app/src/rate_app/domain/boundaries/rate_app_repository.dart';
import 'package:karate_stars_app/src/rate_app/domain/entities/rate_app.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _lastRequestVersionPreference = 'lastRequestVersionPreference';
const _rateAppConversionCount = 'rateAppConversionCount';

class RateAppPreferencesRepository implements RateAppRepository {
  @override
  Future<RateApp> get() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final lastRequestVersionPreference =
        prefs.getString(_lastRequestVersionPreference) ?? '';

    final rateAppConversionCount =
        prefs.getInt(_rateAppConversionCount) ?? 0;

    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = packageInfo.version;

    return RateApp(currentVersion, lastRequestVersionPreference, rateAppConversionCount);
  }

  @override
  Future<void> save(RateApp rateApp) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(_lastRequestVersionPreference, rateApp.lastRequestVersion);
    prefs.setInt(_rateAppConversionCount, rateApp.rateAppConversionCount);
  }
}
