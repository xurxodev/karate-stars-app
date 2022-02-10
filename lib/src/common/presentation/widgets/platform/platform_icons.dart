import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformIcons {
  PlatformIcons._();

  static IconData settings =
      Platform.isAndroid ? Icons.settings : CupertinoIcons.wrench;
}
