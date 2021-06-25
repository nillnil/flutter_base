import 'package:base/platform/platform.dart';
import 'package:flutter/material.dart';

/// 默认PlatformMode
const PlatformMode _defaultPlatformMode = PlatformMode();

/// 默认Brightness
const Brightness _defaultBrightness = Brightness.light;

/// 默认ThemeMode
const ThemeMode _defaultThemeMode = ThemeMode.system;

class AppProvider with ChangeNotifier {
  AppProvider({
    PlatformMode? platformMode,
    Brightness? brightness,
    ThemeMode? themeMode,
  }) {
    _platformMode = platformMode ?? _defaultPlatformMode;
    _brightness = brightness ?? _defaultBrightness;
    _themeMode = themeMode ?? _defaultThemeMode;
  }

  PlatformMode? _platformMode;
  PlatformMode? get platformMode => _platformMode;

  Brightness? _brightness;
  Brightness? get brightness => _brightness;

  /// 主题模式
  ThemeMode? _themeMode;
  ThemeMode? get themeMode => _themeMode;

  void changePlatformMode(PlatformMode? platformMode) {
    _platformMode = platformMode;
    notifyListeners();
  }

  void changeBrightness(Brightness? brightness) {
    _brightness = brightness;
    notifyListeners();
  }

  void changeThemeMode(ThemeMode? themeMode) {
    if (themeMode != _themeMode) {
      _themeMode = themeMode;
      switch (_themeMode) {
        case ThemeMode.system:
          _brightness = WidgetsBinding.instance?.window.platformBrightness;
          break;
        case ThemeMode.light:
          _brightness = Brightness.light;
          break;
        case ThemeMode.dark:
          _brightness = Brightness.dark;
          break;
        default:
      }
      notifyListeners();
    }
  }
}
