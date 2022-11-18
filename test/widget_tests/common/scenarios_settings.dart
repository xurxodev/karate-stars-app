import 'package:karate_stars_app/src/global_di.dart' as app_di;
import 'package:karate_stars_app/src/settings/domain/boundaries/settings_repository.dart';
import 'package:karate_stars_app/src/settings/domain/entities/settings.dart';
import 'package:mocktail/mocktail.dart';

import 'mocks.dart';

void givenThereAreSettings() {
  final mockSettingsRepository = MockSettingsRepository();
  when(() => mockSettingsRepository.get()).thenAnswer((_) =>
      Future.value(Settings(BrightnessMode.system, true, true, true, true, '1.0')));
  app_di.getIt
      .registerLazySingleton<SettingsRepository>(() => mockSettingsRepository);
}
