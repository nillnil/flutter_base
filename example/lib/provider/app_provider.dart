import 'package:base/base.dart' show BasePlatformMode, isCupertinoMode;
import 'package:flutter/material.dart';

/// 默认PlatformMode
BasePlatformMode _defaultPlatformMode = const BasePlatformMode();

/// 默认Brightness
const Brightness _defaultBrightness = Brightness.light;

/// 默认ThemeMode
const ThemeMode _defaultThemeMode = ThemeMode.system;

class AppProvider with ChangeNotifier {
  AppProvider({
    BasePlatformMode? platformMode,
    Brightness? brightness,
    ThemeMode? themeMode,
    double? appBarHeight,
    bool routeFullscreenGackGesture = true,
  }) {
    _platformMode = platformMode ?? _defaultPlatformMode;
    _brightness = brightness ?? _defaultBrightness;
    _themeMode = themeMode ?? _defaultThemeMode;
    if (appBarHeight != null) {
      _appBarHeight = appBarHeight;
    } else {
      _appBarHeight = isCupertinoMode ? 44.0 : 56.0;
    }
    _routeFullscreenGackGesture = routeFullscreenGackGesture;
  }

  BasePlatformMode? _platformMode;
  BasePlatformMode? get platformMode => _platformMode;

  Brightness? _brightness;
  Brightness? get brightness => _brightness;

  /// 主题模式
  ThemeMode? _themeMode;
  ThemeMode? get themeMode => _themeMode;

  double? _appBarHeight;
  double? get appBarHeight => _appBarHeight;

  // 路由全屏手势
  bool? _routeFullscreenGackGesture;
  bool? get routeFullscreenGackGesture => _routeFullscreenGackGesture;

  void changePlatformMode(BasePlatformMode? platformMode) {
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

  void changeAppBarHeight(double appBarHeight) {
    _appBarHeight = appBarHeight;
    notifyListeners();
  }

  void changeRouteFullscreenGackGesture() {
    _routeFullscreenGackGesture = !routeFullscreenGackGesture!;
    notifyListeners();
  }
}
