import 'package:flutter/cupertino.dart' show RoutePredicate;
import 'package:flutter/material.dart'
    show BuildContext, MaterialPageRoute, Navigator, RouteSettings;
import 'package:flutter/material.dart';

import '../base_class.dart';
import '../flutter/cupertino/route.dart';
import '../theme/base_theme.dart';

/// BaseRoute
/// use CupertinoPageRoute or CupertinoButton.filled by cupertino
/// *** use cupertino = { forceUseMaterial: true } force use MaterialPageRoute on cuperitno.
/// use MaterialPageRoute
/// *** use material = { forceUseCupertino: true } force use CupertinoPageRoute on material.
class BaseRoute<T> extends BaseClass {
  BaseRoute({
    this.builder,
    this.title,
    this.settings,
    this.maintainState = true,
    this.fullscreenDialog = false,
    this.backGestureWidth = 20.0,
    this.fullscreenGackGesture,
    Map<String, dynamic> cupertino,
    Map<String, dynamic> material,
  }) : super(cupertino: cupertino, material: material);

  /// *** general properties start ***

  /// [CupertinoPageRoute.builder]
  /// or
  /// [MaterialPageRoute.builder]
  final WidgetBuilder builder;

  /// [CupertinoPageRoute.settings]
  /// or
  /// [MaterialPageRoute.settings]
  final RouteSettings settings;

  /// [CupertinoPageRoute.maintainState]
  /// or
  /// [MaterialPageRoute.maintainState]
  final bool maintainState;

  /// [CupertinoPageRoute.fullscreenDialog]
  /// or
  /// [MaterialPageRoute.fullscreenDialog]
  final bool fullscreenDialog;

  /// *** general properties end ***

  /// *** cupertino properties start ***

  /// [CupertinoPageRoute.title]
  final String title;

  /// default is [CupertinoPageRoute._kBackGestureWidth] = 20.0.
  /// 向右滑返回时离屏幕边缘的宽度
  final double backGestureWidth;

  /// if is true, [backGestureWidth] = MediaQuery.of(context).size.width.
  /// if is null, default is [BaseThemeData.routeFullscreenGackGesture]
  /// **Please pay attention to gesture conflict when using
  ///
  /// 是否启用全屏右滑返回, [backGestureWidth]参数会失效
  /// 默认是 [BaseThemeData.routeFullscreenGackGesture]
  /// ** 使用时请注意手势冲突
  final bool fullscreenGackGesture;

  /// *** cupertino properties end ***

  @override
  Object buildByCupertino(BuildContext context) {
    double _backGestureWidth = backGestureWidth;
    final bool fullscreenGackGesture = this.fullscreenGackGesture ??
        BaseTheme.of(context).routeFullscreenGackGesture;
    if (fullscreenGackGesture) {
      _backGestureWidth = MediaQuery.of(context).size.width;
    }
    return CupertinoPageRoute<T>(
      title: title,
      settings: valueFromCupertino('settings', settings),
      maintainState: valueFromCupertino('maintainState', maintainState),
      fullscreenDialog: valueFromCupertino(
        'fullscreenDialog',
        fullscreenDialog,
      ),
      builder: valueFromCupertino('builder', builder),
      backGestureWidth: _backGestureWidth,
    );
  }

  @override
  Object buildByMaterial(BuildContext context) {
    return MaterialPageRoute<T>(
      settings: valueFromMaterial('settings', settings),
      maintainState: valueFromMaterial('maintainState', maintainState),
      fullscreenDialog: valueFromMaterial('fullscreenDialog', fullscreenDialog),
      builder: valueFromCupertino('builder', builder),
    );
  }

  /// [Navigator.push]
  Future<T> push<T extends Object>(
    BuildContext context, {
    bool rootNavigator = false,
    bool nullOk = false,
  }) {
    return Navigator.of(
      context,
      rootNavigator: rootNavigator,
      nullOk: nullOk,
    ).push(build(context));
  }

  /// [Navigator.pushAndRemoveUntil]
  Future<T> pushAndRemoveUntil<T extends Object>(
    BuildContext context, {
    bool rootNavigator = false,
    bool nullOk = false,
    RoutePredicate predicate,
  }) {
    return Navigator.of(
      context,
      rootNavigator: rootNavigator,
      nullOk: nullOk,
    ).pushAndRemoveUntil(build(context), predicate);
  }
}

/// [Navigator.push]
Future<T> pushBaseRoute<T extends Object>(
  BaseRoute<T> baseRoute,
  BuildContext context, {
  bool rootNavigator = false,
  bool nullOk = false,
}) {
  return Navigator.of(
    context,
    rootNavigator: rootNavigator,
    nullOk: nullOk,
  ).push(baseRoute.build(context));
}

/// [Navigator.pushAndRemoveUntil]
Future<T> pushBaseRouteAndRemoveUntil<T extends Object>(
  BaseRoute<T> baseRoute,
  BuildContext context, {
  bool rootNavigator = false,
  bool nullOk = false,
  RoutePredicate predicate,
}) {
  return Navigator.of(
    context,
    rootNavigator: rootNavigator,
    nullOk: nullOk,
  ).pushAndRemoveUntil(baseRoute.build(context), predicate);
}
