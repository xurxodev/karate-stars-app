import 'package:karate_stars_app/src/settings/domain/boundaries/settings_repository.dart';
import 'package:karate_stars_app/src/settings/domain/entities/settings.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _brightnessPreference = 'brightness';
const _newsNotificationsPreference = 'newsNotifications';
const _competitorNotificationsPreference = 'competitorNotifications';
const _videosNotificationsPreference = 'videosNotifications';

class SettingsPreferencesRepository implements SettingsRepository {
  @override
  Future<Settings> get() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final brightnessValue =
        prefs.getString(_brightnessPreference) ?? BrightnessMode.system.name;

    final newsNotifications =
        prefs.getBool(_newsNotificationsPreference) ?? true;

    final competitorsNotifications =
        prefs.getBool(_competitorNotificationsPreference) ?? true;

    final videosNotifications =
        prefs.getBool(_videosNotificationsPreference) ?? true;

    final brightnessMode = BrightnessMode.values
        .firstWhere((item) => item.name == brightnessValue);

    final packageInfo = await PackageInfo.fromPlatform();

    return Settings(brightnessMode, newsNotifications, competitorsNotifications,
        videosNotifications, packageInfo.version);
  }

  @override
  Future<void> save(Settings settings) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(_brightnessPreference, settings.brightnessMode.name);
    prefs.setBool(_newsNotificationsPreference, settings.newsNotification);
    prefs.setBool(
        _competitorNotificationsPreference, settings.competitorNotification);
    prefs.setBool(_videosNotificationsPreference, settings.videoNotification);
  }
}
