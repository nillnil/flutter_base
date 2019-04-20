import 'package:base/base_stateless_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseTabView extends BaseStatelessWidget {
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
    Map<String, Object> cupertino,
    Map<String, Object> material,
  }) : super(key: key, cupertino: cupertino, material: material);

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

  @override
  Widget buildByCupertino(BuildContext context) {
    return CupertinoTabView(
      builder: builder,
      defaultTitle: defaultTitle,
      routes: routes,
      onGenerateRoute: onGenerateRoute,
      navigatorObservers: navigatorObservers,
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    return TabBarView(
      children: children,
      controller: controller,
      physics: physics,
    );
  }
}
