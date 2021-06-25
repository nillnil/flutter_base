import 'package:flutter/cupertino.dart' show CupertinoTabView;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../base_stateful_widget.dart';
import '../flutter/cupertino/bottom_tab_bar.dart';
import '../flutter/cupertino/tab_scaffold.dart';
import '../platform/platform.dart';
import '../tabbar/base_tab_bar.dart';

/// BaseTabScaffold
/// use CupertinoTabScaffold by cupertino
/// *** use cupertino = { forceUseMaterial: true } to force use Scaffold
/// material，use Scaffold by material
/// *** use material = { forceUseCupertino: true } to force use CupertinoTabScaffold
///
/// CupertinoTabScaffold: 2021.04.01
/// Scaffold: 2021.04.03
/// modify 2021.06.25 by flutter 2.2.2
class BaseTabScaffold extends BaseStatefulWidget {
  const BaseTabScaffold({
    Key? key,
    this.backgroundColor,
    this.tabBar,
    this.tabViews,
    this.resizeToAvoidBottomInset = true,
    this.controller,
    this.routes = const <String, WidgetBuilder>{},
    this.restorationId,
    this.restorationScopeIds,
    this.navigatorKeys,
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
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.tabViewKeys,
    this.onDrawerChanged,
    this.onEndDrawerChanged,
    Map<String, dynamic>? cupertino,
    Map<String, dynamic>? material,
  }) : super(key: key, cupertino: cupertino, material: material);

  /// *** general properties start ***

  /// [CupertinoTabScaffold.backgroundColor]
  /// or
  /// [Scaffold.backgroundColor]
  final Color? backgroundColor;

  /// [CupertinoTabBar]
  /// or
  /// [BottomNavigationBar]
  final BaseTabBar? tabBar;

  /// [CupertinoTabView.builder]
  /// or
  /// [Scaffold.body]
  final List<Widget>? tabViews;

  /// [CupertinoTabView.restorationScopeId]
  final List<String?>? restorationScopeIds;

  /// [CupertinoTabScaffold.resizeToAvoidBottomInset]
  /// or
  /// [Scaffold.resizeToAvoidBottomInset]
  final bool resizeToAvoidBottomInset;

  /// [CupertinoTabScaffold.restorationId]
  /// or
  /// [Scaffold.restorationId]
  final String? restorationId;

  /// *** general properties end ***

  /// *** cupertino properties start ***

  /// [CupertinoTabScaffold.controller]
  final CupertinoTabController? controller;

  /// [CupertinoTabView.tabViewKey]
  final List<Key?>? tabViewKeys;

  /// [CupertinoTabView.routes]
  final Map<String, WidgetBuilder>? routes;

  /// [CupertinoTabView.navigatorKey]
  final List<GlobalKey<NavigatorState>?>? navigatorKeys;

  /// [CupertinoTabView.defaultTitle]
  final String? defaultTitle;

  /// [CupertinoTabView.onGenerateRoute]
  final RouteFactory? onGenerateRoute;

  /// [CupertinoTabView.onUnknownRoute]
  final RouteFactory? onUnknownRoute;

  /// [CupertinoTabView.navigatorObservers]
  final List<NavigatorObserver> navigatorObservers;

  /// *** cupertino properties end ***

  /// *** material properties start ***

  /// [Scaffold.floatingActionButton]
  final Widget? floatingActionButton;

  /// [Scaffold.floatingActionButtonLocation]
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// [Scaffold.floatingActionButtonAnimator]
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;

  /// [Scaffold.persistentFooterButtons]
  final List<Widget>? persistentFooterButtons;

  /// [Scaffold.drawer]
  final Widget? drawer;

  /// [Scaffold.onDrawerChanged]
  final DrawerCallback? onDrawerChanged;

  /// [Scaffold.endDrawer]
  final Widget? endDrawer;

  /// [Scaffold.onEndDrawerChanged]
  final DrawerCallback? onEndDrawerChanged;

  /// [Scaffold.bottomSheet]
  final Widget? bottomSheet;

  /// [Scaffold.primary]
  final bool primary;

  /// [Scaffold.drawerDragStartBehavior]
  final DragStartBehavior drawerDragStartBehavior;

  /// [Scaffold.extendBody]
  final bool extendBody;

  /// [Scaffold.extendBodyBehindAppBar]
  final bool extendBodyBehindAppBar;

  /// [Scaffold.drawerScrimColor]
  final Color? drawerScrimColor;

  /// [Scaffold.drawerEdgeDragWidth]
  final double? drawerEdgeDragWidth;

  /// [Scaffold.drawerEnableOpenDragGesture]
  final bool drawerEnableOpenDragGesture;

  /// [Scaffold.endDrawerEnableOpenDragGesture]
  final bool endDrawerEnableOpenDragGesture;

  /// *** material properties end ***

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
      _currentIndex = tabBar.valueFromMaterial(
        'currentIndex',
        tabBar.currentIndex,
      );
    }
  }

  @override
  Widget buildByCupertino(BuildContext context) {
    final BaseTabBar tabBar = valueFromCupertino('tabBar', widget.tabBar);
    final List<Widget> tabViews = valueFromCupertino(
      'tabViews',
      widget.tabViews,
    );
    if (tabBar != null || tabViews != null) {
      assert(
        tabBar != null && tabViews != null,
        'tabBar and tabView can not be null',
      );
    }
    return CupertinoTabScaffold(
      tabBar: tabBar.build(context) as CupertinoTabBar,
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          key: widget.tabViewKeys?[index],
          navigatorKey: widget.navigatorKeys?[index],
          builder: (BuildContext context) {
            return tabViews[index];
          },
          routes: widget.routes,
          defaultTitle: widget.defaultTitle,
          onGenerateRoute: widget.onGenerateRoute,
          onUnknownRoute: widget.onUnknownRoute,
          navigatorObservers: widget.navigatorObservers,
          restorationScopeId: widget.restorationScopeIds?[index],
        );
      },
      controller: widget.controller,
      backgroundColor: valueFromCupertino('backgroundColor', widget.backgroundColor),
      resizeToAvoidBottomInset: valueFromCupertino('resizeToAvoidBottomInset', widget.resizeToAvoidBottomInset),
      restorationId: valueFromCupertino('restorationId', widget.restorationId),
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    final BaseTabBar tabBar = valueFromMaterial('tabBar', widget.tabBar);
    final List<Widget> tabViews = valueFromMaterial('tabViews', widget.tabViews);
    return Scaffold(
      key: valueFromMaterial('key', widget.key),
      body: tabViews[_currentIndex],
      bottomNavigationBar: tabBar.copyWith(
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
          final ValueChanged<int> onTap = tabBar.valueFromMaterial('onTap', tabBar.onTap);
          if (onTap != null) {
            onTap(index);
          }
        },
        currentIndex: _currentIndex,
      ),
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
      persistentFooterButtons: widget.persistentFooterButtons,
      drawer: widget.drawer,
      onDrawerChanged: widget.onDrawerChanged,
      endDrawer: widget.endDrawer,
      onEndDrawerChanged: widget.onEndDrawerChanged,
      bottomSheet: widget.bottomSheet,
      backgroundColor: valueFromMaterial('backgroundColor', widget.backgroundColor),
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      primary: widget.primary,
      drawerDragStartBehavior: widget.drawerDragStartBehavior,
      extendBody: widget.extendBody,
      extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
      drawerScrimColor: widget.drawerScrimColor,
      drawerEdgeDragWidth: widget.drawerEdgeDragWidth,
      drawerEnableOpenDragGesture: widget.drawerEnableOpenDragGesture,
      endDrawerEnableOpenDragGesture: widget.endDrawerEnableOpenDragGesture,
      restorationId: widget.restorationId,
    );
  }
}
