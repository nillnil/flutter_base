import 'package:flutter/cupertino.dart' show CupertinoPageRoute, RoutePredicate;
import 'package:flutter/material.dart'
    show BuildContext, MaterialPageRoute, Navigator, RouteSettings;

import '../base_class.dart';

/// BaseRoute
/// use CupertinoPageRoute or CupertinoButton.filled by cupertino
/// *** use cupertino = { forceUseMaterial: true } force use MaterialPageRoute on cuperitno.
/// use MaterialPageRoute
/// *** use material = { forceUseCupertino: true } force use CupertinoPageRoute on material.
class BaseRoute<T> extends BaseClass {
  BaseRoute(
    this.page, {
    this.title,
    this.settings,
    this.maintainState = true,
    this.fullscreenDialog = false,
    Map<String, dynamic> cupertino,
    Map<String, dynamic> material,
  }) : super(cupertino: cupertino, material: material);

  /// *** general properties start ***

  /// [CupertinoPageRoute.page]
  /// or
  /// [MaterialPageRoute.page]
  final Object page;

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

  /// *** cupertino properties end ***

  @override
  Object buildByCupertino(BuildContext context) {
    return CupertinoPageRoute<T>(
      title: title,
      settings: valueFromCupertino('settings', settings),
      maintainState: valueFromCupertino('maintainState', maintainState),
      fullscreenDialog: valueFromCupertino(
        'fullscreenDialog',
        fullscreenDialog,
      ),
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
