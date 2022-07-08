import 'package:flutter/foundation.dart';

enum BrightnessMode { system, light, dark }

extension SelectedColorExtension on BrightnessMode {
  String get name => describeEnum(this);
}

class Settings {
  final BrightnessMode brightnessMode;
  final bool newsNotification;
  final bool competitorNotification;
  final bool videoNotification;
  final bool rankingNotification;
  final String version;

  Settings(
      this.brightnessMode,
      this.newsNotification,
      this.competitorNotification,
      this.videoNotification,
      this.rankingNotification,
      this.version);
}
