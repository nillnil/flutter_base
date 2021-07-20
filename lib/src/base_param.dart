import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

import 'mode/base_mode.dart';

/// 个性化参数
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
    this.forceUseMaterial,
    this.forceUseCupertino,
    this.disabledOnMaterial,
    this.disabledOnCupertino,
    this.disabledOnAndroid,
    this.disabledOnFuchsia,
    this.disabledOniOS,
    this.disabledOnLinux,
    this.disabledOnMacOS,
    this.disabledOnWindows,
    this.disabledOnWeb,
    this.disabledOnOthers,
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
  final bool? forceUseMaterial;

  /// 强制使用cupertino模式
  /// force use cupertino mode
  final bool? forceUseCupertino;

  /// 在material模式下禁用，使用Container()代替
  /// on material's mode, use container() instead
  final bool? disabledOnMaterial;

  /// 在cupertino模式下禁用，使用Container()代替
  /// on cupertino's mode, use container() instead
  final bool? disabledOnCupertino;

  /// 在andriod下禁用，使用Container()代替
  /// on andriod, use container() instead
  final bool? disabledOnAndroid;

  /// 在fuchsia下禁用，使用Container()代替
  /// on fuchsia, use container() instead
  final bool? disabledOnFuchsia;

  /// 在iOS下禁用，使用Container()代替
  /// on iOS, use container() instead
  final bool? disabledOniOS;

  /// 在linux下禁用，使用Container()代替
  /// on linux, use container() instead
  final bool? disabledOnLinux;

  /// 在macOS下禁用，使用Container()代替
  /// on macOS, use container() instead
  final bool? disabledOnMacOS;

  /// 在windows下禁用，使用Container()代替
  /// on windows, use container() instead
  final bool? disabledOnWindows;

  /// 在web下禁用，使用Container()代替
  /// on web, use container() instead
  final bool? disabledOnWeb;

  /// 在others下禁用，使用Container()代替
  /// on others platform, use container() instead
  final bool? disabledOnOthers;

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
        _map ??= cupertino;
        break;
      case BaseMode.material:
        _map ??= material;
        break;
      default:
    }
    }
    return _map != null ? _map[key] ?? value : value;
  }

}
