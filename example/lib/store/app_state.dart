
import 'package:flutter/foundation.dart' show TargetPlatform;
import 'package:flutter/material.dart' show Color;

class AppState {

  const AppState({
    this.targetPlatform,
    this.primaryColor,
  });

  final TargetPlatform targetPlatform;
  final Color primaryColor;

  AppState copyWith({ TargetPlatform targetPlatform, Color primaryColor }) {
    return AppState(
      targetPlatform: targetPlatform ?? this.targetPlatform, 
      primaryColor: primaryColor ?? this.primaryColor
    );
  }

}