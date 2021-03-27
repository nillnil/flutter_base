import 'package:base/platform/platform.dart';
import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  AppProvider({
    PlatformMode? platformMode,
    Color? primaryColor,
    Brightness? brightness,
  }) {
    _platformMode = platformMode ?? const PlatformMode();
    _primaryColor = primaryColor ?? Colors.indigo;
    _brightness = brightness ?? Brightness.light;
  }

  PlatformMode? _platformMode;
  PlatformMode? get platformMode => _platformMode;

  Color? _primaryColor;

  Color? get primaryColor => _primaryColor;

  Brightness? _brightness;
  Brightness? get brightness => _brightness;

  void changePlatformMode(PlatformMode? platformMode) {
    _platformMode = platformMode;
    notifyListeners();
  }

  void changeTheme(Color? primaryColor) {
    _primaryColor = primaryColor;
    notifyListeners();
  }

  void changeBrightness(Brightness? brightness) {
    _brightness = brightness;
    notifyListeners();
  }
}
