import 'package:flutter/cupertino.dart' show CupertinoTabView;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../base_param.dart';
import '../base_stateful_widget.dart';
import '../flutter/cupertino/bottom_tab_bar.dart';
import '../flutter/cupertino/tab_scaffold.dart';
import '../mode/base_mode.dart';
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
    BaseParam? baseParam,
  }) : super(key: key, baseParam: baseParam);

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
    if (isMaterialMode) {
      final BaseTabBar tabBar = valueOf('tabBar', widget.tabBar);
      _currentIndex = tabBar.valueOf(
        'currentIndex',
        tabBar.currentIndex,
      );
    }
  }

  @override
  Widget buildByCupertino(BuildContext context) {
    final BaseTabBar tabBar = valueOf('tabBar', widget.tabBar);
    final List<Widget> tabViews = valueOf(
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
          key: valueOf('tabViewKeys', widget.tabViewKeys)?[index],
          navigatorKey: valueOf('navigatorKeys', widget.navigatorKeys)?[index],
          builder: (BuildContext context) {
            return tabViews[index];
          },
          routes: valueOf('routes', widget.routes),
          defaultTitle: valueOf('defaultTitle', widget.defaultTitle),
          onGenerateRoute: valueOf('onGenerateRoute', widget.onGenerateRoute),
          onUnknownRoute: valueOf('onUnknownRoute', widget.onUnknownRoute),
          navigatorObservers: valueOf('navigatorObservers', widget.navigatorObservers),
          restorationScopeId: valueOf('restorationScopeIds', widget.restorationScopeIds)?[index],
        );
      },
      controller: valueOf('controller', widget.controller),
      backgroundColor: valueOf('backgroundColor', widget.backgroundColor),
      resizeToAvoidBottomInset: valueOf('resizeToAvoidBottomInset', widget.resizeToAvoidBottomInset),
      restorationId: valueOf('restorationId', widget.restorationId),
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    final BaseTabBar tabBar = valueOf('tabBar', widget.tabBar);
    final List<Widget> tabViews = valueOf('tabViews', widget.tabViews);
    return Scaffold(
      key: valueOf('key', widget.key),
      body: tabViews[_currentIndex],
      bottomNavigationBar: tabBar.copyWith(
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
          final ValueChanged<int> onTap = tabBar.valueOf('onTap', tabBar.onTap);
          if (onTap != null) {
            onTap(index);
          }
        },
        currentIndex: _currentIndex,
      ),
      floatingActionButton: valueOf('floatingActionButton', widget.floatingActionButton),
      floatingActionButtonLocation: valueOf('floatingActionButtonLocation', widget.floatingActionButtonLocation),
      floatingActionButtonAnimator: valueOf('floatingActionButtonAnimator', widget.floatingActionButtonAnimator),
      persistentFooterButtons: valueOf('persistentFooterButtons', widget.persistentFooterButtons),
      drawer: valueOf('drawer', widget.drawer),
      onDrawerChanged: valueOf('onDrawerChanged', widget.onDrawerChanged),
      endDrawer: valueOf('endDrawer', widget.endDrawer),
      onEndDrawerChanged: valueOf('onEndDrawerChanged', widget.onEndDrawerChanged),
      bottomSheet: valueOf('bottomSheet', widget.bottomSheet),
      backgroundColor: valueOf('backgroundColor', widget.backgroundColor),
      resizeToAvoidBottomInset: valueOf('resizeToAvoidBottomInset', widget.resizeToAvoidBottomInset),
      primary: valueOf('primary', widget.primary),
      drawerDragStartBehavior: valueOf('drawerDragStartBehavior', widget.drawerDragStartBehavior),
      extendBody: valueOf('extendBody', widget.extendBody),
      extendBodyBehindAppBar: valueOf('extendBodyBehindAppBar', widget.extendBodyBehindAppBar),
      drawerScrimColor: valueOf('drawerScrimColor', widget.drawerScrimColor),
      drawerEdgeDragWidth: valueOf('drawerEdgeDragWidth', widget.drawerEdgeDragWidth),
      drawerEnableOpenDragGesture: valueOf('drawerEnableOpenDragGesture', widget.drawerEnableOpenDragGesture),
      endDrawerEnableOpenDragGesture: valueOf('endDrawerEnableOpenDragGesture', widget.endDrawerEnableOpenDragGesture),
      restorationId: valueOf('restorationId', widget.restorationId),
    );
  }
}
