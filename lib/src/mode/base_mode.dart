import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// 当前的运行模式
BaseMode? _currentBaseMode;

BaseMode get currentBaseMode {
  if (_currentBaseMode == null) {
    setBasePlatformMode();
  }
  return _currentBaseMode!;
}

/// 默认的运行模式
BaseMode? defaultBaseMode;

/// 平台构建模式
enum BaseMode {
  /// use cupertino's widgets
  cupertino,

  /// use material's widgets
  material,
}

/// 组件构建模式
enum WidgetBuildMode {
  /// Cupertino模式
  cupertino,

  /// Material模式
  material,

  /// 强制使用Cupertino模式
  forceUseCupertino,

  /// 强制使用Material模式
  forceUseMaterial,

  /// 静止构建，使用Container代替
  disabled,
}

/// 运行的平台模式
/// 默认iOS, macOS使用cupertino模式，其余使用material模式
class BasePlatformMode {
  /// 运行的平台模式
  const BasePlatformMode({
    this.android = BaseMode.material,
    this.fuchsia = BaseMode.material,
    this.iOS = BaseMode.cupertino,
    this.linux = BaseMode.material,
    this.macOS = BaseMode.cupertino,
    this.windows = BaseMode.material,
    this.web,
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

  /// web, 默认跟随系统
  final BaseMode? web;

  /// others
  final BaseMode others;

  BasePlatformMode copyWith({
    BaseMode? android,
    BaseMode? fuchsia,
    BaseMode? iOS,
    BaseMode? linux,
    BaseMode? macOS,
    BaseMode? windows,
    BaseMode? web,
    BaseMode? others,
  }) {
    return BasePlatformMode(
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

  /// 改变某平台的构建模式，不包括web
  BasePlatformMode changePlatformMode({
    BaseMode? mode,
  }) {
    final TargetPlatform targetPlatform = defaultTargetPlatform;
    BasePlatformMode? platformMode;
    // web
    if (kIsWeb && mode != null) {
      platformMode = copyWith(web: mode);
    } else {
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
    }
    return platformMode;
  }
}

/// build baseApp 之前必须调用该方法
/// set the platform
void setBasePlatformMode({
  BasePlatformMode? basePlatformMode = const BasePlatformMode(),
}) {
  const BasePlatformMode defalutPlatformMode = BasePlatformMode();
  // web
  if (kIsWeb && basePlatformMode!.web != null) {
    _currentBaseMode = basePlatformMode.web!;
    defaultBaseMode = basePlatformMode.web!;
    return;
  }
  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      _currentBaseMode = basePlatformMode!.android;
      defaultBaseMode = defalutPlatformMode.android;
      break;
    case TargetPlatform.fuchsia:
      _currentBaseMode = basePlatformMode!.fuchsia;
      defaultBaseMode = defalutPlatformMode.fuchsia;
      break;
    case TargetPlatform.iOS:
      _currentBaseMode = basePlatformMode!.iOS;
      defaultBaseMode = defalutPlatformMode.iOS;
      break;
    case TargetPlatform.linux:
      _currentBaseMode = basePlatformMode!.linux;
      defaultBaseMode = defalutPlatformMode.linux;
      break;
    case TargetPlatform.macOS:
      _currentBaseMode = basePlatformMode!.macOS;
      defaultBaseMode = defalutPlatformMode.macOS;
      break;
    case TargetPlatform.windows:
      _currentBaseMode = basePlatformMode!.windows;
      defaultBaseMode = defalutPlatformMode.windows;
      break;
    default:
      _currentBaseMode = basePlatformMode!.others;
      defaultBaseMode = defalutPlatformMode.others;
  }
}

/// build by Cupertino
bool get isCupertinoMode => currentBaseMode == BaseMode.cupertino;

/// build by Material
bool get isMaterialMode => currentBaseMode == BaseMode.material;
