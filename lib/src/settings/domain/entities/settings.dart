
import 'package:flutter/foundation.dart';

enum BrightnessMode { system, light, dark }

extension SelectedColorExtension on BrightnessMode {
  String get name => describeEnum(this);
}

class Settings {
  final BrightnessMode brightnessMode;

  Settings(this.brightnessMode);
}
