import 'package:karate_stars_app/src/settings/domain/boundaries/settings_repository.dart';
import 'package:karate_stars_app/src/settings/domain/entities/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _brightnessPreference = 'brightness';

class SettingsPreferencesRepository implements SettingsRepository {
  @override
  Future<Settings> get() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final brightnessValue =
        prefs.getString(_brightnessPreference) ?? BrightnessMode.system.name;

    final brightnessMode = BrightnessMode.values
        .firstWhere((item) => item.name == brightnessValue);

    return Settings(brightnessMode);
  }

  @override
  Future<void> save(Settings settings) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(_brightnessPreference, settings.brightnessMode.name);
  }
}
