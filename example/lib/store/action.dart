
import 'package:flutter/foundation.dart' show TargetPlatform;
import 'package:flutter/material.dart' show Color;

class PlatformAction {
  
  final TargetPlatform targetPlatform;

  PlatformAction({
    this.targetPlatform
  });
  
}

class ThemeAction {

  final Color primaryColor;

  ThemeAction({
    this.primaryColor
  });

}