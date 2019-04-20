import 'package:base/base_class.dart';
import 'package:flutter/cupertino.dart' show CupertinoPageRoute, RoutePredicate;
import 'package:flutter/material.dart'
    show BuildContext, MaterialPageRoute, Navigator, RouteSettings;

/// 基础路由
/// cupertino，使用CupertinoPageRoute
/// *** 可使用 cupertino = { forceUseMaterial: true } 参数强制使用MaterialPageRoute
/// material，使用MaterialPageRoute
/// *** 可使用 material = { forceUseCupertino: true } 参数强制使用CupertinoPageRoute
class BaseRoute<T> extends BaseClass {
  BaseRoute(
    this.page, {
    this.title,
    this.settings,
    this.maintainState = true,
    this.fullscreenDialog = false,
    Map<String, Object> cupertino,
    Map<String, Object> material,
  }) : super(cupertino: cupertino, material: material);

  // general
  final Object page;
  final RouteSettings settings;
  final bool maintainState;
  final bool fullscreenDialog;

  // cupertino
  final String title;

  @override
  Object buildByCupertino(BuildContext context) {
    return CupertinoPageRoute<T>(
      title: title,
      settings: valueFromCupertino('settings', settings),
      maintainState: valueFromCupertino('maintainState', maintainState),
      fullscreenDialog:
          valueFromCupertino('fullscreenDialog', fullscreenDialog),
      builder: (BuildContext context) {
        return valueFromCupertino('page', page);
      },
    );
  }

  @override
  Object buildByMaterial(BuildContext context) {
    return MaterialPageRoute<T>(
      settings: valueFromMaterial('settings', settings),
      maintainState: valueFromMaterial('maintainState', maintainState),
      fullscreenDialog: valueFromMaterial('fullscreenDialog', fullscreenDialog),
      builder: (BuildContext context) {
        return valueFromMaterial('page', page);
      },
    );
  }

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
