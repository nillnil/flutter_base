
import 'package:flutter/foundation.dart' show TargetPlatform;
import 'package:flutter/material.dart' show Color;

class AppState {

  final TargetPlatform targetPlatform;
  final Color primaryColor;

  AppState({
    this.targetPlatform,
    this.primaryColor
  });

  AppState.initialState({ TargetPlatform targetPlatform, Color primaryColor })
     : this.targetPlatform = targetPlatform,
       this.primaryColor = primaryColor;

  AppState copyWith({ TargetPlatform targetPlatform, Color primaryColor }) {
    return AppState(
      targetPlatform: targetPlatform ?? this.targetPlatform, 
      primaryColor: primaryColor ?? this.primaryColor
    );
  }

}