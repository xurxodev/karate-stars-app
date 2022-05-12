import 'dart:async';
import 'package:karate_stars_app/src/common/analytics/events.dart';
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

  void requestReview() {
    _analyticsService.sendEvent(RateApp());
  }

  void visitScreen() {
    _analyticsService.sendScreenName('$screen_name');
  }

  Future<void> _loadData() async {
    try {
      final settings = await _getSettingsUseCase.execute();

      final selectedBrightnessOption = brightnessOptions
          .firstWhere((item) => item.id == settings.brightnessMode.name);

      final settingsStateData = SettingsStateData(
          brightnessOptions: brightnessOptions,
          selectedBrightnessOption: selectedBrightnessOption.id,
          newsNotification: settings.newsNotification,
          competitorNotification: settings.competitorNotification,
          videoNotification: settings.videoNotification,
          version: settings.version);

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

  void selectBrightness(String optionId) {
    if (state is LoadedState) {
      final loadedState = state as LoadedState<SettingsStateData>;
      final settingsStateData = loadedState.data.copyWith(
          brightnessOptions: brightnessOptions,
          selectedBrightnessOption: optionId);

      changeState(DefaultState.loaded(settingsStateData));

      final brightnessOption = settingsStateData.brightnessOptions
          .firstWhere((option) => option.id == optionId);

      _analyticsService
          .sendEvent(ChangeSettings('brightness', brightnessOption.name));

      _saveSettings();
    }
  }

  void selectNewsNotifications(bool value) {
    if (state is LoadedState) {
      final loadedState = state as LoadedState<SettingsStateData>;

      final settingsStateData =
          loadedState.data.copyWith(newsNotification: value);

      changeState(DefaultState.loaded(settingsStateData));

      _analyticsService
          .sendEvent(ChangeSettings('Notifications - news', value.toString()));

      _saveSettings();
    }
  }

  void selectCompetitorNotifications(bool value) {
    if (state is LoadedState) {
      final loadedState = state as LoadedState<SettingsStateData>;
      final settingsStateData =
          loadedState.data.copyWith(competitorNotification: value);

      changeState(DefaultState.loaded(settingsStateData));

      _analyticsService.sendEvent(
          ChangeSettings('Notifications - competitor', value.toString()));

      _saveSettings();
    }
  }

  void selectVideosNotifications(bool value) {
    if (state is LoadedState) {
      final loadedState = state as LoadedState<SettingsStateData>;
      final settingsStateData =
          loadedState.data.copyWith(videoNotification: value);

      changeState(DefaultState.loaded(settingsStateData));

      _analyticsService.sendEvent(
          ChangeSettings('Notifications - videos', value.toString()));

      _saveSettings();
    }
  }

  void _saveSettings() {
    final loadedState = state as LoadedState<SettingsStateData>;
    final brightnessMode = BrightnessMode.values.firstWhere(
        (item) => item.name == loadedState.data.selectedBrightnessOption);

    final settings = Settings(
        brightnessMode,
        loadedState.data.newsNotification,
        loadedState.data.competitorNotification,
        loadedState.data.videoNotification,
        loadedState.data.version);

    _saveSettingsUseCase.execute(settings);
  }


}
