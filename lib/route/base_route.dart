

import 'package:base/base_class.dart';
import 'package:flutter/cupertino.dart' show CupertinoPageRoute;
import 'package:flutter/material.dart' show BuildContext, MaterialPageRoute, Navigator, RouteSettings;

/// 基础路由
/// cupertino，使用CupertinoPageRoute
/// *** 可使用 cupertino = { forceUseMaterial: true } 参数强制使用MaterialPageRoute
/// material，使用MaterialPageRoute
/// *** 可使用 material = { forceUseCupertino: true } 参数强制使用CupertinoPageRoute
class BaseRoute extends BaseClass {

	// general
	final Object page;
	final RouteSettings settings;
	final bool maintainState;
	final bool fullscreenDialog;

	// cupertino
	final String title;

	final Map<String, Object> cupertino;
	final Map<String, Object> material;

	BaseRoute(this.page, {
		this.title,
		this.settings,
		this.maintainState = true,
		this.fullscreenDialog = false,
		this.cupertino,
		this.material
  });

  @override
  Object buildByCupertino(BuildContext context) {
		return CupertinoPageRoute(
			title: title,
			settings: valueFromCupertino('settings', settings),
			maintainState: valueFromCupertino('maintainState', maintainState),
			fullscreenDialog: valueFromCupertino('fullscreenDialog', fullscreenDialog),
			builder: (BuildContext context) {
				return valueFromCupertino('page', page);
			}
		);
  }

  @override
  Object buildByMaterial(BuildContext context) {
  	return MaterialPageRoute(
			settings: valueFromMaterial('settings', settings),
			maintainState: valueFromMaterial('maintainState', maintainState),
			fullscreenDialog: valueFromMaterial('fullscreenDialog', fullscreenDialog),
			builder: (BuildContext context) {
				return valueFromMaterial('page', page);
			}
		);
  }

  push(BuildContext context, {
		bool rootNavigator = false,
		bool nullOk = false
	}) {
		Navigator.of(context, rootNavigator: rootNavigator, nullOk: nullOk).push(this.build(context));
	}

  pushAndRemoveUntil(BuildContext context, {
		bool rootNavigator = false,
		bool nullOk = false
	}) {
		Navigator.of(context, rootNavigator: rootNavigator, nullOk: nullOk).pushAndRemoveUntil(this.build(context), null);
	}

}