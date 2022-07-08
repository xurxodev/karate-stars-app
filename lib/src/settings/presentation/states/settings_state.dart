import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/common/presentation/states/option.dart';

typedef SettingsState = DefaultState<SettingsStateData>;

class SettingsStateData {
  final List<Option> brightnessOptions;
  final String selectedBrightnessOption;
  final bool newsNotification;
  final bool competitorNotification;
  final bool videoNotification;
  final bool rankingNotification;
  final String version;

  SettingsStateData(
      {required this.brightnessOptions,
      required this.selectedBrightnessOption,
      required this.newsNotification,
      required this.competitorNotification,
      required this.videoNotification,
      required this.rankingNotification,
      required this.version});

  SettingsStateData copyWith(
      {List<Option>? brightnessOptions,
      String? selectedBrightnessOption,
      bool? newsNotification,
      bool? competitorNotification,
      bool? videoNotification,
      bool? rankingNotification}) {
    return SettingsStateData(
        brightnessOptions: brightnessOptions ?? this.brightnessOptions,
        selectedBrightnessOption:
            selectedBrightnessOption ?? this.selectedBrightnessOption,
        newsNotification: newsNotification ?? this.newsNotification,
        competitorNotification:
            competitorNotification ?? this.competitorNotification,
        videoNotification: videoNotification ?? this.videoNotification,
        rankingNotification: rankingNotification ?? this.rankingNotification,
        version: version);
  }
}
