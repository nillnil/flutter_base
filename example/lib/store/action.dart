
import 'package:flutter/foundation.dart' show TargetPlatform;
import 'package:flutter/material.dart' show Color;

class PlatformAction {
  
  PlatformAction({
    this.targetPlatform
  });

  final TargetPlatform targetPlatform;
}

class ThemeAction {

  const ThemeAction({
    this.primaryColor
  });

  final Color primaryColor;
}