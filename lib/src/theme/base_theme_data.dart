import 'package:flutter/cupertino.dart' show CupertinoApp, CupertinoThemeData;
import 'package:flutter/foundation.dart' show Diagnosticable, immutable;
import 'package:flutter/material.dart' show Brightness, Color, MaterialApp, ThemeData;

import '../app/base_app.dart';
import '../appbar/base_app_bar.dart';
import '../base_param.dart';
import '../mode/base_mode.dart';
import '../route/base_route.dart';

/// BaseThemeData
/// Special properties values global setting
/// 参考 [ThemeData]
@immutable
class BaseThemeData with Diagnosticable {
  factory BaseThemeData({
    Brightness? brightness,
    double? appBarHeight,
    bool appBarBackdropFilter = true,
    bool appBarTransitionBetweenRoutes = true,
    ThemeData? materialTheme,
    ThemeData? materialDarkTheme,
    ThemeData? materialHighContrastTheme,
    ThemeData? materialHighContrastDarkTheme,
    CupertinoThemeData? cupertinoTheme,
    bool routeFullscreenGackGesture = false,
    Color? sectionDividerColor,
    Color? tileBackgroundColor,
    BasePlatformMode? platformMode = const BasePlatformMode(),
    bool withoutSplashOnCupertino = true,
    BaseParam? baseParam,
  }) {
    brightness ??= Brightness.light;
    final bool isDark = brightness == Brightness.dark;
    return BaseThemeData.raw(
      brightness: brightness,
      appBarHeight: appBarHeight,
      appBarBackdropFilter: appBarBackdropFilter,
      appBarTransitionBetweenRoutes: appBarTransitionBetweenRoutes,
      materialTheme: materialTheme,
      materialDarkTheme: materialDarkTheme,
      materialHighContrastTheme: materialHighContrastTheme,
      materialHighContrastDarkTheme: materialHighContrastDarkTheme,
      cupertinoTheme: cupertinoTheme,
      routeFullscreenGackGesture: routeFullscreenGackGesture,
      sectionDividerColor: sectionDividerColor ?? (isDark ? const Color(0x1FFFFFFF) : const Color(0x1F000000)),
      tileBackgroundColor: tileBackgroundColor,
      platformMode: platformMode,
      withoutSplashOnCupertino: withoutSplashOnCupertino,
      baseParam: baseParam,
    );
  }
  const BaseThemeData.raw({
    this.brightness,
    this.appBarHeight,
    this.appBarBackdropFilter,
    this.appBarTransitionBetweenRoutes,
    this.materialTheme,
    this.materialDarkTheme,
    this.materialHighContrastTheme,
    this.materialHighContrastDarkTheme,
    this.cupertinoTheme,
    this.routeFullscreenGackGesture = false,
    this.sectionDividerColor,
    this.tileBackgroundColor,
    this.platformMode = const BasePlatformMode(),
    this.withoutSplashOnCupertino = true,
    this.baseParam,
  });

  final Brightness? brightness;

  /// [BaseAppBar.height]
  final double? appBarHeight;

  /// [BaseAppBar.appBarBackdropFilter]
  final bool? appBarBackdropFilter;

  /// [BaseAppBar.appBarTransitionBetweenRoutes]
  final bool? appBarTransitionBetweenRoutes;

  /// [BaseRoute.fullscreenGackGesture]
  final bool routeFullscreenGackGesture;

  /// [MaterialApp.theme]
  /// 在Cupertino模式下使用Material组件时，
  /// 可以使用 Theme.of(context) 获取到[BaseApp.materialTheme]
  ///
  /// Material模式下为null
  final ThemeData? materialTheme;

  /// [MaterialApp.materialDarkTheme]
  /// 在Cupertino模式下使用Material组件时，
  /// 可以使用 Theme.of(context) 获取到[BaseApp.materialDarkTheme]
  ///
  /// Material模式下为null
  final ThemeData? materialDarkTheme;

  /// [MaterialApp.highContrastTheme]
  /// 在Cupertino模式下使用Material组件时，
  /// 可以使用 Theme.of(context) 获取到[BaseApp.highContrastTheme]
  ///
  /// Material模式下为null
  final ThemeData? materialHighContrastTheme;

  /// [MaterialApp.highContrastDarkTheme]
  /// 在Cupertino模式下使用Material组件时，
  /// 可以使用 Theme.of(context) 获取到[BaseApp.highContrastDarkTheme]
  ///
  /// Material模式下为null
  final ThemeData? materialHighContrastDarkTheme;

  /// [CupertinoApp.theme]
  /// 在Material模式下使用Mupertino组件时,
  /// 可以使用 CupertinoTheme.of(context) 获取到[BaseApp.cupertinoTheme]
  ///
  /// Cupertino模式下为null
  final CupertinoThemeData? cupertinoTheme;

  /// BaseSection's divider's color
  /// BaseSection 的diviver的颜色
  final Color? sectionDividerColor;

  /// BaseTile's BackgroundColor
  /// BaseTile 的背景颜色
  /// 建议适应BaseColor().build(context), 构建2种颜色
  final Color? tileBackgroundColor;

  /// 平台模式
  /// baseplatform mode
  final BasePlatformMode? platformMode;

  /// Cupertino 模式下用Material组件是否去除水波纹
  /// Use Material Widget without splash on Cupertino's mode
  final bool withoutSplashOnCupertino;

  /// See also:
  ///
  ///  * [BaseStatelessWidget.baseParam], special parameters values on cupertino mode or target platform.
  ///  * [BaseStatelessWidget.baseParam], special parameters values on material mode or target platform.
  final BaseParam? baseParam;

  BaseThemeData copyWith({
    Brightness? brightness,
    double? appBarHeight,
    bool? appBarBackdropFilter,
    bool? appBarTransitionBetweenRoutes,
    ThemeData? materialTheme,
    ThemeData? materialDarkTheme,
    ThemeData? materialHighContrastTheme,
    ThemeData? materialHighContrastDarkTheme,
    CupertinoThemeData? cupertinoTheme,
    bool? routeFullscreenGackGesture,
    Color? sectionDividerColor,
    Color? tileBackgroundColor,
    BasePlatformMode? platformMode,
    bool? withoutSplashOnCupertino,
    BaseParam? baseParam,
  }) {
    return BaseThemeData.raw(
      brightness: brightness ?? this.brightness,
      appBarHeight: appBarHeight ?? this.appBarHeight,
      appBarBackdropFilter: appBarBackdropFilter ?? this.appBarBackdropFilter,
      appBarTransitionBetweenRoutes: appBarTransitionBetweenRoutes ?? this.appBarTransitionBetweenRoutes,
      materialTheme: materialTheme ?? this.materialTheme,
      materialDarkTheme: materialDarkTheme ?? this.materialDarkTheme,
      materialHighContrastTheme: materialHighContrastTheme ?? this.materialHighContrastTheme,
      materialHighContrastDarkTheme: materialHighContrastDarkTheme ?? this.materialHighContrastDarkTheme,
      cupertinoTheme: cupertinoTheme ?? this.cupertinoTheme,
      routeFullscreenGackGesture: routeFullscreenGackGesture ?? this.routeFullscreenGackGesture,
      sectionDividerColor: sectionDividerColor ?? this.sectionDividerColor,
      tileBackgroundColor: tileBackgroundColor ?? this.tileBackgroundColor,
      platformMode: platformMode ?? this.platformMode,
      withoutSplashOnCupertino: withoutSplashOnCupertino ?? this.withoutSplashOnCupertino,
      baseParam: baseParam ?? this.baseParam,
    );
  }

  dynamic valueOf(String key, dynamic value) {
    return baseParam != null ? baseParam!.valueOf(key, value) ?? value : value;
  }
}
