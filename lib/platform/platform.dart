import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform;

/// 当前运行模式的键对
PlatformMode _platformMode = const PlatformMode();

/// 当前的运行模式
BaseMode currentPlatformMode = BaseMode.material;

/// 默认的运行模式
BaseMode defaultPlatformMode = BaseMode.material;

/// 再cupertino模式下是否禁用水波纹
bool withoutSplashOnCupertino = true;

/// 构建模式
enum BaseMode {
  /// use cupertino's widgets
  cupertino,

  /// use material's widgets
  material,
}

/// 运行的平台模式
/// 默认iOS, macOS使用cupertino模式，其余使用material模式
class PlatformMode {
  /// 运行的平台模式
  const PlatformMode({
    this.android = BaseMode.material,
    this.fuchsia = BaseMode.material,
    this.iOS = BaseMode.cupertino,
    this.linux = BaseMode.material,
    this.macOS = BaseMode.cupertino,
    this.windows = BaseMode.material,
    this.web = BaseMode.material,
    this.others = BaseMode.material,
  });

  /// [TargetPlatform.android]
  final BaseMode android;

  /// [TargetPlatform.fuchsia]
  final BaseMode fuchsia;

  /// [TargetPlatform.iOS]
  final BaseMode iOS;

  /// [TargetPlatform.linux]
  final BaseMode linux;

  /// [TargetPlatform.macOS]
  final BaseMode macOS;

  /// [TargetPlatform.windows]
  final BaseMode windows;

  /// web
  final BaseMode web;

  /// others
  final BaseMode others;

  PlatformMode copyWith({
    BaseMode? android,
    BaseMode? fuchsia,
    BaseMode? iOS,
    BaseMode? linux,
    BaseMode? macOS,
    BaseMode? windows,
    BaseMode? web,
    BaseMode? others,
  }) {
    return PlatformMode(
      android: android ?? this.android,
      fuchsia: fuchsia ?? this.fuchsia,
      iOS: iOS ?? this.iOS,
      linux: linux ?? this.linux,
      macOS: macOS ?? this.macOS,
      windows: windows ?? this.windows,
      web: web ?? this.web,
      others: others ?? this.others,
    );
  }

  PlatformMode changePlatformMode({
    TargetPlatform? targetPlatform,
    BaseMode? mode,
  }) {
    targetPlatform ??= defaultTargetPlatform;
    PlatformMode? platformMode;
    switch (targetPlatform) {
      case TargetPlatform.android:
        platformMode = copyWith(android: mode);
        break;
      case TargetPlatform.fuchsia:
        platformMode = copyWith(fuchsia: mode);
        break;
      case TargetPlatform.iOS:
        platformMode = copyWith(iOS: mode);
        break;
      case TargetPlatform.linux:
        platformMode = copyWith(linux: mode);
        break;
      case TargetPlatform.macOS:
        platformMode = copyWith(macOS: mode);
        break;
      case TargetPlatform.windows:
        platformMode = copyWith(windows: mode);
        break;
      default:
        platformMode = copyWith(others: mode);
    }
    return platformMode;
  }
}

/// 设置当前的运行模式
void setCurrentPlatformMode({TargetPlatform? targetPlatform}) {
  targetPlatform ??= defaultTargetPlatform;
  const PlatformMode platformMode = PlatformMode();
  switch (targetPlatform) {
    case TargetPlatform.android:
      currentPlatformMode = _platformMode.android;
      defaultPlatformMode = platformMode.android;
      break;
    case TargetPlatform.fuchsia:
      currentPlatformMode = _platformMode.fuchsia;
      defaultPlatformMode = platformMode.fuchsia;
      break;
    case TargetPlatform.iOS:
      currentPlatformMode = _platformMode.iOS;
      defaultPlatformMode = platformMode.iOS;
      break;
    case TargetPlatform.linux:
      currentPlatformMode = _platformMode.linux;
      defaultPlatformMode = platformMode.linux;
      break;
    case TargetPlatform.macOS:
      currentPlatformMode = _platformMode.macOS;
      defaultPlatformMode = platformMode.macOS;
      break;
    case TargetPlatform.windows:
      currentPlatformMode = _platformMode.windows;
      defaultPlatformMode = platformMode.windows;
      break;
    default:
      currentPlatformMode = _platformMode.others;
      defaultPlatformMode = platformMode.others;
  }
}

/// build baseApp 之前必须调用该方法
/// set the platform
void setPlatformMode({
  PlatformMode? platformMode,
  bool withoutSplashOnCupertino = true,
}) {
  _platformMode = platformMode ?? _platformMode;
  withoutSplashOnCupertino = withoutSplashOnCupertino;
  setCurrentPlatformMode();
}

/// build by Cupertino
bool get useCupertino => currentPlatformMode == BaseMode.cupertino;

/// build by Material
bool get useMaterial => currentPlatformMode == BaseMode.material;
