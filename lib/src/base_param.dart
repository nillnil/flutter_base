import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

import 'mode/base_mode.dart';

/// Base组件专属的个性化参数
class BaseParam {
  BaseParam({
    this.cupertino,
    this.material,
    this.android,
    this.fuchsia,
    this.iOS,
    this.linux,
    this.macOS,
    this.windows,
    this.web,
    this.others,
    this.forceUseMaterial = false,
    this.forceUseCupertino = false,
    this.disabledOnMaterial = false,
    this.disabledOnCupertino = false,
    this.disabledOnAndroid = false,
    this.disabledOnFuchsia = false,
    this.disabledOnIOS = false,
    this.disabledOnLinux = false,
    this.disabledOnMacOS = false,
    this.disabledOnWindows = false,
    this.disabledOnWeb = false,
    this.disabledOnOthers = false,
    this.withoutSplashOnCupertino,
  });

  /// cupertino 模式下的个性化参数
  /// cupertino's mode custom params
  final Map<String, dynamic>? cupertino;

  /// material 模式下的个性化参数
  /// material's mode custom params
  final Map<String, dynamic>? material;

  /// andriod 的个性化参数
  /// andriod's custom params
  final Map<String, dynamic>? android;

  /// fuchsia 的个性化参数
  /// fuchsia's custom params
  final Map<String, dynamic>? fuchsia;

  /// iOS 的个性化参数
  /// iOS's custom params
  final Map<String, dynamic>? iOS;

  /// linux 的个性化参数
  /// linux's custom params
  final Map<String, dynamic>? linux;

  /// macOS 的个性化参数
  /// macOS's custom params
  final Map<String, dynamic>? macOS;

  /// windows 的个性化参数
  /// windows's custom params
  final Map<String, dynamic>? windows;

  /// web 的个性化参数
  /// web's custom params
  final Map<String, dynamic>? web;

  /// others 的个性化参数
  /// others's custom params
  final Map<String, dynamic>? others;

  /// 强制使用material模式
  /// force use material mode
  final bool forceUseMaterial;

  /// 强制使用cupertino模式
  /// force use cupertino mode
  final bool forceUseCupertino;

  /// 在material模式下禁用，使用Container()代替
  /// on material's mode, use Container() instead
  final bool disabledOnMaterial;

  /// 在cupertino模式下禁用，使用Container()代替
  /// on cupertino's mode, use Container() instead
  final bool disabledOnCupertino;

  /// 在andriod下禁用，使用Container()代替
  /// on andriod, use Container() instead
  final bool disabledOnAndroid;

  /// 在fuchsia下禁用，使用Container()代替
  /// on fuchsia, use Container() instead
  final bool disabledOnFuchsia;

  /// 在iOS下禁用，使用Container()代替
  /// on iOS, use Container() instead
  final bool disabledOnIOS;

  /// 在linux下禁用，使用Container()代替
  /// on linux, use Container() instead
  final bool disabledOnLinux;

  /// 在macOS下禁用，使用Container()代替
  /// on macOS, use Container() instead
  final bool disabledOnMacOS;

  /// 在windows下禁用，使用Container()代替
  /// on windows, use Container() instead
  final bool disabledOnWindows;

  /// 在web下禁用，使用Container()代替
  /// on web, use Container() instead
  final bool disabledOnWeb;

  /// 在others下禁用，使用Container()代替
  /// on others platform, use Container() instead
  final bool disabledOnOthers;

  /// 在cupertino模式下使用material组件是否禁用水波纹
  final bool? withoutSplashOnCupertino;

  dynamic valueOf(String key, dynamic value) {
    Map<String, dynamic>? _map;
    // 先根据平台取值
    if (kIsWeb && web != null) {
      _map = web;
    } else {
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          _map = android;
          break;
        case TargetPlatform.fuchsia:
          _map = fuchsia;
          break;
        case TargetPlatform.iOS:
          _map = iOS;
          break;
        case TargetPlatform.linux:
          _map = linux;
          break;
        case TargetPlatform.macOS:
          _map = macOS;
          break;
        case TargetPlatform.windows:
          _map = windows;
          break;
        default:
          _map = others;
          break;
      }
      // 再根据模式取值
      switch (currentBaseMode) {
        case BaseMode.cupertino:
          _map ??= forceUseMaterial ? material : cupertino;
          break;
        case BaseMode.material:
          _map ??= forceUseCupertino ? cupertino : material;
          break;
        default:
      }
    }
    return _map != null ? _map[key] ?? value : value;
  }
}
