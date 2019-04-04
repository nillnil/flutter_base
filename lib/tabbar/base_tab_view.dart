
import 'package:base/base_stateless_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseTabView extends BaseStatelessWidget {

	// cupertino
	final WidgetBuilder builder;
	final String defaultTitle;
	final Map<String, WidgetBuilder> routes;
	final RouteFactory onGenerateRoute;
	final RouteFactory onUnknownRoute;
	final List<NavigatorObserver> navigatorObservers;

	// material
	final List<Widget> children;
	final TabController controller;
	final ScrollPhysics physics;

	final Map<String, Object> cupertino;
	final Map<String, Object> material;

  BaseTabView({
		Key key,
		this.builder,
		this.defaultTitle,
		this.routes,
		this.onGenerateRoute,
		this.onUnknownRoute,
		this.navigatorObservers = const <NavigatorObserver>[],

		this.children,
		this.controller,
		this.physics,

		this.cupertino,
		this.material
	});

  @override
  Widget buildByCupertino(BuildContext context) {
    return CupertinoTabView(
			key: valueFromCupertino('key', key),
			builder: builder,
			defaultTitle: defaultTitle,
			routes: routes,
			onGenerateRoute: onGenerateRoute,
			navigatorObservers: navigatorObservers
		);
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    return TabBarView(
			children: children,
			controller: controller,
			physics: physics
		);
  }

}