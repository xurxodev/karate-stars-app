import 'dart:async';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc.dart';
import 'package:karate_stars_app/src/common/presentation/boundaries/analytics.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/common/presentation/states/option.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/settings/domain/entities/settings.dart';
import 'package:karate_stars_app/src/settings/domain/get_settings_use_case.dart';
import 'package:karate_stars_app/src/settings/domain/save_settings_use_case.dart';
import 'package:karate_stars_app/src/settings/presentation/states/settings_state.dart';

class SettingsBloc extends Bloc<SettingsState> {
  static const screen_name = 'settings';

  final GetSettingsUseCase _getSettingsUseCase;
  final SaveSettingsUseCase _saveSettingsUseCase;

  final AnalyticsService _analyticsService;

  List<Option> brightnessOptions = [];

  SettingsBloc(this._getSettingsUseCase, this._saveSettingsUseCase,
      this._analyticsService) {
    changeState(DefaultState.loading());

    brightnessOptions = mapBrightnessModeToOptions();

    _loadData();
  }

  void visitScreen() {
    _analyticsService.sendScreenName('$screen_name');
  }

  Future<void> _loadData() async {
    try {
      // ;

      final settings = await _getSettingsUseCase.execute();

      final selectedBrightnessOption = brightnessOptions
          .firstWhere((item) => item.id == settings.brightnessMode.name);

      final settingsStateData = SettingsStateData(
          brightnessOptions: brightnessOptions,
          selectedBrightnessOption: selectedBrightnessOption);

      changeState(DefaultState.loaded(settingsStateData));
    } on Exception {
      changeState(DefaultState.error(Strings.network_error_message));
    }
  }

  List<Option> mapBrightnessModeToOptions() {
    final List<Option> brightnessOptions = BrightnessMode.values.map((item) {
      switch (item) {
        case BrightnessMode.system:
          return Option(
              BrightnessMode.system.name, Strings.settings_brightness_system);
        case BrightnessMode.dark:
          return Option(
              BrightnessMode.dark.name, Strings.settings_brightness_dark);
        case BrightnessMode.light:
          return Option(
              BrightnessMode.light.name, Strings.settings_brightness_light);
      }
    }).toList();
    return brightnessOptions;
  }

  void selectBrightness(Option option) {
    final settingsStateData = SettingsStateData(
        brightnessOptions: brightnessOptions, selectedBrightnessOption: option);

    changeState(DefaultState.loaded(settingsStateData));

    final brightnessMode =
        BrightnessMode.values.firstWhere((item) => item.name == option.id);

    final settings = Settings(brightnessMode);

    _saveSettingsUseCase.execute(settings);

    //Send event to analytics
  }
}
