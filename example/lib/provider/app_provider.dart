import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  AppProvider({
    TargetPlatform targetPlatform,
    Color primaryColor,
    Brightness brightness,
  }) {
    _targetPlatform = targetPlatform ?? defaultTargetPlatform;
    _primaryColor = primaryColor ?? Colors.indigo;
    _brightness = brightness ?? Brightness.light;
  }

  TargetPlatform _targetPlatform;

  TargetPlatform get targetPlatform => _targetPlatform;

  Color _primaryColor;

  Color get primaryColor => _primaryColor;

  Brightness _brightness;
  Brightness get brightness => _brightness;

  void changePlatform(TargetPlatform targetPlatform) {
    _targetPlatform = targetPlatform;
    notifyListeners();
  }

  void changeTheme(Color primaryColor) {
    _primaryColor = primaryColor;
    notifyListeners();
  }

  void changeBrightness(Brightness brightness) {
    _brightness = brightness;
    notifyListeners();
  }
}
