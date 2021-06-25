import 'package:flutter/cupertino.dart' show CupertinoThemeData;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show Diagnosticable, immutable;
import 'package:flutter/material.dart' show Color, ThemeData;
import 'package:flutter/material.dart';

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
    bool? appBarCenterTitle,
    ThemeData? materialTheme,
    CupertinoThemeData? cupertinoTheme,
    bool routeFullscreenGackGesture = false,
    Color? sectionDividerColor,
    Color? tileBackgroundColor,
    Map<String, dynamic>? cupertino,
    Map<String, dynamic>? material,
  }) {
    brightness ??= Brightness.light;
    final bool isDark = brightness == Brightness.dark;
    return BaseThemeData.raw(
      brightness: brightness,
      appBarHeight: appBarHeight,
      appBarBackdropFilter: appBarBackdropFilter,
      appBarTransitionBetweenRoutes: appBarTransitionBetweenRoutes,
      appBarCenterTitle: appBarCenterTitle,
      materialTheme: materialTheme,
      cupertinoTheme: cupertinoTheme,
      routeFullscreenGackGesture: routeFullscreenGackGesture,
      sectionDividerColor: sectionDividerColor ?? (isDark ? const Color(0x1FFFFFFF) : const Color(0x1F000000)),
      tileBackgroundColor: tileBackgroundColor,
      cupertino: cupertino ?? const <String, dynamic>{},
      material: material ?? const <String, dynamic>{},
    );
  }
  const BaseThemeData.raw({
    this.brightness,
    this.appBarHeight,
    this.cupertino,
    this.material,
    this.appBarBackdropFilter,
    this.appBarTransitionBetweenRoutes,
    this.appBarCenterTitle,
    this.materialTheme,
    this.cupertinoTheme,
    this.routeFullscreenGackGesture = false,
    this.sectionDividerColor,
    this.tileBackgroundColor,
  });

  final Brightness? brightness;

  /// [BaseAppBar.height]
  final double? appBarHeight;

  /// [BaseAppBar.appBarBackdropFilter]
  final bool? appBarBackdropFilter;

  /// [BaseAppBar.appBarTransitionBetweenRoutes]
  final bool? appBarTransitionBetweenRoutes;

  /// [BaseAppBar.appBarCenterTitle]
  final bool? appBarCenterTitle;

  /// [BaseRoute.fullscreenGackGesture]
  final bool routeFullscreenGackGesture;

  /// [ThemeData]
  /// 在Cupertino模式下使用Material组件时，
  /// 可以使用 Theme.of(context) 获取到[BaseApp.materialTheme]
  ///
  /// Material模式下为null
  final ThemeData? materialTheme;

  /// [CupertinoThemeData]
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

  /// See also:
  ///
  ///  * [BaseStatelessWidget.cupertino], special parameters values on cupertino mode.
  ///  * [BaseStatelessWidget.material], special parameters values on material mode.
  final Map<String, dynamic>? cupertino;
  final Map<String, dynamic>? material;

  BaseThemeData copyWith({
    Brightness? brightness,
    double? appBarHeight,
    bool? appBarBackdropFilter,
    bool? appBarTransitionBetweenRoutes,
    bool? appBarCenterTitle,
    ThemeData? materialTheme,
    CupertinoThemeData? cupertinoTheme,
    bool? routeFullscreenGackGesture,
    Color? sectionDividerColor,
    Color? tileBackgroundColor,
    Map<String, dynamic>? cupertino,
    Map<String, dynamic>? material,
  }) {
    return BaseThemeData.raw(
      brightness: brightness ?? this.brightness,
      appBarHeight: appBarHeight ?? this.appBarHeight,
      appBarBackdropFilter: appBarBackdropFilter ?? this.appBarBackdropFilter,
      appBarTransitionBetweenRoutes: appBarTransitionBetweenRoutes ?? this.appBarTransitionBetweenRoutes,
      appBarCenterTitle: appBarCenterTitle ?? this.appBarCenterTitle,
      materialTheme: materialTheme ?? this.materialTheme,
      cupertinoTheme: cupertinoTheme ?? this.cupertinoTheme,
      routeFullscreenGackGesture: routeFullscreenGackGesture ?? this.routeFullscreenGackGesture,
      sectionDividerColor: sectionDividerColor ?? this.sectionDividerColor,
      tileBackgroundColor: tileBackgroundColor ?? this.tileBackgroundColor,
      cupertino: cupertino ?? this.cupertino,
      material: material ?? this.material,
    );
  }

  /// will get the parameter value from [cupertino] first.
  ///
  /// 会先获取 [cupertino] 里的值
  dynamic valueFromCupertino(String key, dynamic value) {
    return cupertino != null ? cupertino![key] ?? value : value;
  }

  /// will get the parameter value from [material] first.
  ///
  /// 会先获取 [material] 里的值
  dynamic valueFromMaterial(String key, dynamic value) {
    return material != null ? material![key] ?? value : value;
  }
}
