import 'package:karate_stars_app/src/settings/domain/boundaries/settings_repository.dart';
import 'package:karate_stars_app/src/settings/domain/entities/settings.dart';

class SaveSettingsUseCase {
  final SettingsRepository _settingsRepository;

  SaveSettingsUseCase(this._settingsRepository);

  Future<void> execute(Settings settings) async {
    return _settingsRepository.save(settings);
  }
}
