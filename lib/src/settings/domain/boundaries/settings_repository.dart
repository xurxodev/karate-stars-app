import 'package:karate_stars_app/src/settings/domain/entities/settings.dart';

abstract class SettingsRepository {
  Future<Settings> get();
  Future<void> save(Settings settings);
}
