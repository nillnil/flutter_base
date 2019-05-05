import 'package:flutter/foundation.dart'
    show Diagnosticable, immutable, required;

/// BaseThemeData
/// Special properties values global setting
/// 参考 [ThemeData]
@immutable
class BaseThemeData extends Diagnosticable {
  factory BaseThemeData({
    double appBarHeight,
    bool appBarBackdropFilter = true,
    bool appBarAutoSetMiddleColor = true,
    bool appBarAutoSetLeadingColor = true,
    bool appBarAutoSetTrailingColor = true,
    bool appBarAutoSetBottomColor = true,
    bool appBarTransitionBetweenRoutes = true,
    bool appBarCenterTitle,
    Map<String, dynamic> cupertino,
    Map<String, dynamic> material,
  }) {
    return BaseThemeData.raw(
      appBarHeight: appBarHeight,
      appBarBackdropFilter: appBarBackdropFilter,
      appBarAutoSetMiddleColor: appBarAutoSetMiddleColor,
      appBarAutoSetLeadingColor: appBarAutoSetLeadingColor,
      appBarAutoSetTrailingColor: appBarAutoSetTrailingColor,
      appBarAutoSetBottomColor: appBarAutoSetBottomColor,
      appBarTransitionBetweenRoutes: appBarTransitionBetweenRoutes,
      appBarCenterTitle: appBarCenterTitle,
      cupertino: cupertino ?? const <String, dynamic>{},
      material: material ?? const <String, dynamic>{},
    );
  }
  const BaseThemeData.raw({
    @required this.appBarHeight,
    @required this.cupertino,
    @required this.material,
    @required this.appBarBackdropFilter,
    @required this.appBarAutoSetMiddleColor,
    @required this.appBarAutoSetLeadingColor,
    @required this.appBarAutoSetTrailingColor,
    @required this.appBarAutoSetBottomColor,
    @required this.appBarTransitionBetweenRoutes,
    @required this.appBarCenterTitle,
  });

  /// [BaseAppBar.height]
  final double appBarHeight;

  /// [BaseAppBar.appBarBackdropFilter]
  final bool appBarBackdropFilter;

  /// [BaseAppBar.appBarAutoSetMiddleColor]
  final bool appBarAutoSetMiddleColor;

  /// [BaseAppBar.appBarAutoSetLeadingColor]
  final bool appBarAutoSetLeadingColor;

  /// [BaseAppBar.autoSetTrailingColor]
  final bool appBarAutoSetTrailingColor;

  /// [BaseAppBar.autoSetBottomColor]
  final bool appBarAutoSetBottomColor;

  /// [BaseAppBar.appBarTransitionBetweenRoutes]
  final bool appBarTransitionBetweenRoutes;

  /// [BaseAppBar.appBarCenterTitle]
  final bool appBarCenterTitle;

  /// See also:
  ///
  ///  * [BaseStatelessWidget.cupertino], special parameters values on cupertino mode.
  ///  * [BaseStatelessWidget.material], special parameters values on material mode.
  final Map<String, dynamic> cupertino;
  final Map<String, dynamic> material;

  BaseThemeData copyWith({
    double appBarHeight,
    bool appBarBackdropFilter,
    bool appBarAutoSetMiddleColor,
    bool appBarAutoSetLeadingColor,
    bool appBarAutoSetTrailingColor,
    bool appBarAutoSetBottomColor,
    bool appBarTransitionBetweenRoutes,
    bool appBarCenterTitle,
    Map<String, dynamic> cupertino,
    Map<String, dynamic> material,
  }) {
    return BaseThemeData.raw(
      appBarHeight: appBarHeight ?? this.appBarHeight,
      appBarBackdropFilter: appBarBackdropFilter ?? this.appBarBackdropFilter,
      appBarAutoSetMiddleColor:
          appBarAutoSetMiddleColor ?? this.appBarAutoSetMiddleColor,
      appBarAutoSetLeadingColor:
          appBarAutoSetLeadingColor ?? this.appBarAutoSetLeadingColor,
      appBarAutoSetTrailingColor:
          appBarAutoSetTrailingColor ?? this.appBarAutoSetTrailingColor,
      appBarAutoSetBottomColor:
          appBarAutoSetBottomColor ?? this.appBarAutoSetBottomColor,
      appBarTransitionBetweenRoutes:
          appBarTransitionBetweenRoutes ?? this.appBarTransitionBetweenRoutes,
      appBarCenterTitle: appBarCenterTitle ?? this.appBarCenterTitle,
      cupertino: cupertino ?? this.cupertino,
      material: material ?? this.material,
    );
  }

  /// will get the parameter value from [cupertino] first.
  ///
  /// 会先获取 [cupertino] 里的值
  dynamic valueFromCupertino(String key, dynamic value) {
    Object newValue;
    if (cupertino != null) {
      newValue = cupertino[key] ?? value;
    } else {
      newValue = value;
    }
    return newValue;
  }

  /// will get the parameter value from [material] first.
  ///
  /// 会先获取 [material] 里的值
  dynamic valueFromMaterial(String key, dynamic value) {
    Object newValue;
    if (cupertino != null) {
      newValue = material[key] ?? value;
    } else {
      newValue = value;
    }
    return newValue;
  }
}
