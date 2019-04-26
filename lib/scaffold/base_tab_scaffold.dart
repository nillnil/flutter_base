import 'package:base/appbar/base_app_bar.dart';
import 'package:base/platform/platform.dart';
import 'package:base/tabbar/base_tab_bar.dart';
import 'package:flutter/cupertino.dart'
    show CupertinoTabScaffold, CupertinoTabView;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../base_stateful_widget.dart';

/// BaseTabScaffold
/// use CupertinoTabScaffold by cupertino
/// *** use cupertino = { forceUseMaterial: true } to force use Scaffold
/// material，use Scaffold by material
/// *** use material = { forceUseCupertino: true } to force use CupertinoTabScaffold
class BaseTabScaffold extends BaseStatefulWidget {
  BaseTabScaffold({
    Key baseKey,
    this.key,
    this.appBar,
    this.navBar,
    this.backgroundColor,
    this.tabBar,
    this.tabViews,
    this.resizeToAvoidBottomInset = true,
    this.routes = const <String, WidgetBuilder>{},
    this.navigatorKey,
    this.onGenerateRoute,
    this.defaultTitle,
    this.onUnknownRoute,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.drawer,
    this.endDrawer,
    this.bottomSheet,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.tabViewKey,
    Map<String, dynamic> cupertino,
    Map<String, dynamic> material,
  }) : super(key: baseKey, cupertino: cupertino, material: material);

  // general
  @override
  final Key key;
  final Key tabViewKey;

  final BaseAppBar appBar;
  final BaseAppBar navBar;
  final Color backgroundColor;
  final BaseTabBar tabBar;
  final List<Widget> tabViews;
  final bool resizeToAvoidBottomInset;

  // cupertino
  /// 在CupertinoTabView里自己维护一套路由
  final Map<String, WidgetBuilder> routes;
  final GlobalKey<NavigatorState> navigatorKey;
  final String defaultTitle;
  final RouteFactory onGenerateRoute;
  final RouteFactory onUnknownRoute;
  final List<NavigatorObserver> navigatorObservers;

  // material
  final Widget floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final FloatingActionButtonAnimator floatingActionButtonAnimator;
  final List<Widget> persistentFooterButtons;
  final Widget drawer;
  final Widget endDrawer;
  final Widget bottomSheet;
  final bool primary;
  final DragStartBehavior drawerDragStartBehavior;
  final bool extendBody;

  @override
  State<BaseTabScaffold> createState() => _BaseTabScaffoldState();
}

class _BaseTabScaffoldState extends BaseState<BaseTabScaffold> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    if (useMaterial) {
      final BaseTabBar tabBar = valueFromMaterial('tabBar', widget.tabBar);
      _currentIndex =
          tabBar.valueFromMaterial('currentIndex', tabBar.currentIndex);
    }
  }

  @override
  Widget buildByCupertino(BuildContext context) {
    final BaseTabBar tabBar = valueFromCupertino('tabBar', widget.tabBar);
    final List<Widget> tabViews =
        valueFromCupertino('tabViews', widget.tabViews);
    if (tabBar != null || tabViews != null) {
      assert(tabBar != null && tabViews != null,
          'tabBar and tabView can not be null');
    }
    return CupertinoTabScaffold(
      key: valueFromCupertino('key', widget.key),
      tabBar: tabBar.build(context),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          key: valueFromCupertino('tabViewKey', widget.tabViewKey),
          navigatorKey: widget.navigatorKey,
          builder: (BuildContext context) {
            return tabViews[index];
          },
          routes: widget.routes,
          defaultTitle: widget.defaultTitle,
          onGenerateRoute: widget.onGenerateRoute,
          onUnknownRoute: widget.onUnknownRoute,
          navigatorObservers: widget.navigatorObservers,
        );
      },
      backgroundColor:
          valueFromMaterial('backgroundColor', widget.backgroundColor),
      resizeToAvoidBottomInset: valueFromCupertino(
          'resizeToAvoidBottomInset', widget.resizeToAvoidBottomInset),
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    final BaseTabBar tabBar = valueFromMaterial('tabBar', widget.tabBar);
    final List<Widget> tabViews =
        valueFromMaterial('tabViews', widget.tabViews);
    return Scaffold(
      key: valueFromMaterial('key', widget.key),
      body: tabViews[_currentIndex],
      bottomNavigationBar: BaseTabBar(
        items: tabBar.valueFromMaterial('items', tabBar.items),
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
          final ValueChanged<int> onTap =
              tabBar.valueFromMaterial('onTap', tabBar.onTap);
          if (onTap != null) {
            onTap(index);
          }
        },
        currentIndex: _currentIndex,
        elevation: tabBar.elevation,
        type: tabBar.type,
        fixedColor: tabBar.fixedColor,
        iconSize: valueFromMaterial('iconSize', tabBar.iconSize) ?? 24.0,
        selectedItemColor: tabBar.selectedItemColor,
        unselectedItemColor: tabBar.unselectedItemColor,
        selectedFontSize: tabBar.selectedFontSize,
        unselectedFontSize: tabBar.unselectedFontSize,
        showSelectedLabels: tabBar.showSelectedLabels,
        showUnselectedLabels: tabBar.showSelectedLabels,
      ),
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
      persistentFooterButtons: widget.persistentFooterButtons,
      drawer: widget.drawer,
      endDrawer: widget.endDrawer,
      bottomSheet: widget.bottomSheet,
      backgroundColor:
          valueFromMaterial('backgroundColor', widget.backgroundColor),
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      primary: widget.primary,
      drawerDragStartBehavior: widget.drawerDragStartBehavior,
      extendBody: widget.extendBody,
    );
  }
}
