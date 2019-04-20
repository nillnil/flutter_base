import 'package:base/base_stateless_widget.dart';
import 'package:base/appbar/base_app_bar.dart';
import 'package:base/tabbar/base_tab_bar.dart';
import 'package:flutter/cupertino.dart'
    show CupertinoTabScaffold, CupertinoTabView;
import 'package:flutter/material.dart';

/// 基础Tab页面
/// cupertino，使用CupertinoTabScaffold
/// *** 可使用 cupertino = { forceUseMaterial: true } 参数强制使用Scaffold
/// material，使用Scaffold
/// *** 可使用 material = { forceUseCupertino: true } 参数强制使用CupertinoTabScaffold
class BaseTabPage extends BaseStatelessWidget {
  // general
  final BaseAppBar appBar;
  final BaseAppBar navBar;
  final Color backgroundColor;

  // 多个页面取tabViews，同时tab不能为空
  final BaseTabBar tabBar;
  final List<Widget> tabViews;

  final Map<String, WidgetBuilder> routes;

  // 自动添加包括状态栏，导航栏的顶部高度的padding
  // 因为如果导航栏的背景颜色是半透明的话，默认是不会加上这padding的，
  // 这里默认为true，自动添加高度padding
  // 注意: 如果autoAddTopPadding = true时，已经自动添加padding，此时再使用BoxScrollView时没有padding参数，会默认加上padding，而本来就已经加了padding了，到导致加了2此padding了
  // 解决办法是: autoAddTopPadding=true，且使用了BoxScrollView，需要在BoxScrollView加上padding参数。
  final bool autoAddTopPadding;

  // 默认false，当有tabBar时的tabbarView页面需要设为true才会自动添加bottomPadding
  final bool autoAddBottomPadding;

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
  final TabController controller;

  BaseTabPage({
    Key key,
    this.appBar,
    this.navBar,
    this.backgroundColor = Colors.white,
    this.tabBar,
    this.tabViews,
    this.routes = const {},
    this.autoAddTopPadding = true,
    this.autoAddBottomPadding = false,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.drawer,
    this.endDrawer,
    this.bottomSheet,
    this.resizeToAvoidBottomPadding = true,
    this.primary = true,
    this.controller,
    Map<String, Object> cupertino,
    Map<String, Object> material,
  }) : super(cupertino: cupertino, material: material);

  @override
  Widget buildByCupertino(BuildContext context) {
    BaseTabBar tabBar = valueFromCupertino('tabBar', this.tabBar);
    List<Widget> tabViews = valueFromCupertino('tabViews', this.tabViews);
    return new CupertinoTabScaffold(
      key: valueFromCupertino('key', key),
      tabBar: tabBar.build(context),
      tabBuilder: (BuildContext context, int index) {
        return new CupertinoTabView(
          builder: (BuildContext context) {
            return tabViews[index];
          },
          routes: routes,
        );
      },
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    BaseTabBar tabBar = valueFromMaterial('tabBar', this.tabBar);
    List<Widget> tabViews = valueFromMaterial('tabViews', this.tabViews);
    return Scaffold(
      key: valueFromMaterial('key', key),
      body: tabViews[tabBar.currentIndex],
//			body: controller != null ? TabBarView(
//				controller: controller,
//				children: tabViews
//			): DefaultTabController(
//				length: tabViews.length,
//				child: TabBarView(
//					children: tabViews,
//				)
//			),
      bottomNavigationBar: tabBar,
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
