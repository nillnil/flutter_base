import 'package:base/base_stateless_widget.dart';
import 'package:base/appbar/base_app_bar.dart';
import 'package:base/tabbar/base_tab_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 基础页面
/// cupertino，单页面使用CupertinoPageScaffold，Tab页面使用CupertinoTabScaffold
/// *** 可使用 cupertino = { forceUseMaterial: true } 参数强制使用Scaffold
/// material，使用Scaffold
/// *** 可使用 material = { forceUseCupertino: true } 参数强制使用CupertinoPageScaffold / CupertinoTabScaffold
class BaseScaffold extends BaseStatelessWidget {
  // general
  final BaseAppBar appBar;
  final BaseAppBar navBar;
  final Color backgroundColor;
  // 只有一个页面取body
  final Widget body;
  // 多个页面取tabViews，同时tab不能为空
  final BaseTabBar tabBar;
  final List<Widget> tabViews;

  // cupertino
  final bool resizeToAvoidBottomInset;
  final Map<String, WidgetBuilder> routes;

  // 相当于SafeArea的top，默认false
  // 当导航栏背景色为透明的，设置为true可以使页面起点在导航栏下方
  final bool safeAreaTop;

  // 相当于SafeArea的bottom，默认false
  // 设置为true可以避免页面被iphone下方的Home Indicator遮住
  final bool safeAreaBottom;

  // material
  final Widget floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final FloatingActionButtonAnimator floatingActionButtonAnimator;
  final List<Widget> persistentFooterButtons;
  final Widget drawer;
  final Widget endDrawer;
  final Widget bottomSheet;
  final bool resizeToAvoidBottomPadding;
  final bool primary;

  BaseScaffold({
    Key key,
    this.appBar,
    this.navBar,
    this.backgroundColor,
    this.body,
    this.tabBar,
    this.tabViews,
    this.resizeToAvoidBottomInset = true,
    this.routes = const {},
    this.safeAreaTop = false,
    this.safeAreaBottom = false,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.drawer,
    this.endDrawer,
    this.bottomSheet,
    this.resizeToAvoidBottomPadding = true,
    this.primary = true,
    Map<String, Object> cupertino,
    Map<String, Object> material,
  }) : super(cupertino: cupertino, material: material);

  @override
  Widget buildByCupertino(BuildContext context) {
    BaseTabBar tabBar = valueFromCupertino('tabBar', this.tabBar);
    List<Widget> tabViews = valueFromCupertino('tabViews', this.tabViews);
    if (tabBar != null || tabViews != null) {
      assert(tabBar != null && tabViews != null,
          'tabBar and tabViews can not be null');
    }
    if (tabBar != null && tabViews.length > 0) {
      return CupertinoTabScaffold(
        key: valueFromCupertino('key', key),
        tabBar: tabBar.build(context),
        tabBuilder: (BuildContext context, int index) {
          return CupertinoTabView(
            builder: (BuildContext context) {
              return tabViews[index];
            },
            routes: routes,
          );
        },
      );
    } else {
      BaseAppBar _appBar = valueFromMaterial('appBar', appBar) ?? valueFromMaterial('navBar', navBar);
      Widget body = valueFromCupertino('body', this.body);
      return CupertinoPageScaffold(
        key: valueFromCupertino('key', key),
        navigationBar: _appBar,
        backgroundColor: valueFromCupertino('backgroundColor', backgroundColor),
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        child: (!safeAreaTop && !safeAreaBottom) ? body
          : SafeArea(
            top: safeAreaTop,
            bottom: safeAreaBottom,
            child: body,
          ),
      );
    }
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    BaseTabBar tabBar = valueFromMaterial('tabBar', this.tabBar);
    List<Widget> tabViews = valueFromMaterial('tabViews', this.tabViews);
    if (tabBar != null || tabViews != null) {
      assert(tabBar != null && tabViews != null,
          'tabBar and tabViews can not be null');
    }
    if (tabBar != null && tabViews.length > 0) {
      return Scaffold(
        key: valueFromMaterial('key', key),
        body: DefaultTabController(
          length: tabViews.length,
          child: TabBarView(
            children: tabViews,
          ),
        ),
        bottomNavigationBar: tabBar.build(context),
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        floatingActionButtonAnimator: floatingActionButtonAnimator,
        persistentFooterButtons: persistentFooterButtons,
        drawer: drawer,
        endDrawer: endDrawer,
        bottomSheet: bottomSheet,
        backgroundColor: valueFromMaterial('backgroundColor', backgroundColor),
        resizeToAvoidBottomPadding: resizeToAvoidBottomPadding,
        primary: primary,
      );
    } else {
      BaseAppBar appBar = valueFromMaterial('appBar', this.appBar) ??
          valueFromMaterial('navBar', navBar);
      return Scaffold(
        key: valueFromMaterial('key', key),
        appBar: appBar,
        body: valueFromMaterial('body', body),
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        floatingActionButtonAnimator: floatingActionButtonAnimator,
        persistentFooterButtons: persistentFooterButtons,
        drawer: drawer,
        endDrawer: endDrawer,
        bottomSheet: bottomSheet,
        backgroundColor: valueFromMaterial('backgroundColor', backgroundColor),
        resizeToAvoidBottomPadding: resizeToAvoidBottomPadding,
        primary: primary,
      );
    }
  }
}
