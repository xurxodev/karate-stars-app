import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/common/presentation/states/option.dart';

typedef SettingsState = DefaultState < SettingsStateData
>;

class SettingsStateData {
  final List<Option> brightnessOptions;
  final Option selectedBrightnessOption;

  SettingsStateData({required this.brightnessOptions,
    required this.selectedBrightnessOption});

  SettingsStateData copyWith({
    List<Option>? brightnessOptions,
    Option? selectedBrightnessOption
  }) {
    return SettingsStateData(
        brightnessOptions: brightnessOptions ?? this.brightnessOptions,
        selectedBrightnessOption: selectedBrightnessOption ??
            this.selectedBrightnessOption);
  }
}
