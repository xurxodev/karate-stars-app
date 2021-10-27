import 'package:karate_stars_app/src/settings/domain/boundaries/settings_repository.dart';
import 'package:karate_stars_app/src/settings/domain/entities/settings.dart';

class GetSettingsUseCase {
  final SettingsRepository _settingsRepository;

  GetSettingsUseCase(this._settingsRepository);

  Future<Settings> execute() async {
    return _settingsRepository.get();
  }
}
