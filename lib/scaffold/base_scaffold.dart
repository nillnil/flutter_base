
import 'package:base/base_stateless_widget.dart';
import 'package:base/appbar/base_app_bar.dart';
import 'package:base/platform/platform.dart';
// import 'package:base/flutter/flutter_modify.dart' show CupertinoPageScaffold;
import 'package:base/tabbar/base_tab_bar.dart';
import 'package:flutter/cupertino.dart' show CupertinoPageScaffold, CupertinoTabScaffold, CupertinoTabView, CupertinoTheme, ObstructingPreferredSizeWidget;
import 'package:flutter/material.dart' show BuildContext, Color, DefaultTabController, EdgeInsets, FloatingActionButtonAnimator, FloatingActionButtonLocation, Key, MediaQuery, MediaQueryData, Padding, Scaffold, TabBarView, Theme, Widget, WidgetBuilder;

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

  // 自动添加包括状态栏，导航栏的顶部高度的padding，默认false
  // 因为如果导航栏的背景颜色是半透明的话，默认是不会加上这padding的，
  // 注意: 如果autoAddTopPadding = true时，已经自动添加padding，此时再使用BoxScrollView时没有padding参数，会默认加上padding，而本来就已经加了padding了，到导致加了2此padding了
  // 解决办法是: autoAddTopPadding=true，且使用了BoxScrollView，需要在BoxScrollView加上padding参数。
  final bool autoAddTopPadding;

  // 默认false，当有tabBar时的tabbarView页面需要设为true才会自动添加bottomPadding
  final bool autoAddBottomPadding;

  // 重置MediaQuery.of(context).padding.top的值为0
  // 当导航栏背景色不是透明的时候，body里是不用加top padding的，而BoxScrollView的padding为null时，还是会加上原来状态栏的高度padding，导致会出现多余的top padding
  // 当导航栏背景色为透明的时候，body默认是在导航栏下方的，此时MediaQuery.of(context).padding.top的值已经自动处理好了，为状态栏跟导航栏的高度之和。
  // BoxScrollView的padding为null时，会自动加上此高度，不用再处理
  // 如果要取得正确的padding
  // 1、不透明，在BasePage同个context里取，
  // 2、透明的，在BasePage不同context里取
  final bool resetMediaPaddingTop;

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

  final Map<String, Object> cupertino;
  final Map<String, Object> material;

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
    this.autoAddTopPadding = false,
    this.autoAddBottomPadding = false,
    this.resetMediaPaddingTop = true,

    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.drawer,
    this.endDrawer,
    this.bottomSheet,
    this.resizeToAvoidBottomPadding = true,
    this.primary = true,

    this.cupertino,
    this.material
  }) : super(key: key, cupertino: cupertino, material: material);

  @override
  Widget buildByCupertino(BuildContext context) {
    BaseTabBar tabBar = valueFromCupertino('tabBar', this.tabBar);
    List<Widget> tabViews = valueFromCupertino('tabViews', this.tabViews);
    if (tabBar != null && tabViews.length > 0) {
      return new CupertinoTabScaffold(
        key: valueFromCupertino('key', key),
        tabBar: tabBar.build(context),
        tabBuilder: (BuildContext context, int index) {
          return new CupertinoTabView(
            builder: (BuildContext context) {
              return tabViews[index];
            },
            routes: routes
          );
        }
      );
    } else {
      BaseAppBar navBar = valueFromCupertino('navBar', this.navBar) ?? valueFromCupertino('appBar', this.appBar);
      Color appBarBackgroundColor = navBar?.backgroundColor;
      if (appBarBackgroundColor == null) {
        if (useCupertino) {
          appBarBackgroundColor = CupertinoTheme.of(context).barBackgroundColor ?? Color(0xCCF8F8F8);
        } else {
          appBarBackgroundColor = Theme.of(context).appBarTheme.color ?? Theme.of(context).primaryColor;
        }
      }
      bool fullObstruction = appBarBackgroundColor?.alpha == 0xFF ?? false;
      double topPadding = 0.0;
      MediaQueryData mediaQueryData = MediaQuery.of(context);
      MediaQueryData _mediaQueryData;
      if (fullObstruction && resetMediaPaddingTop) {
        _mediaQueryData = mediaQueryData.copyWith(
          padding: MediaQuery.of(context).padding?.copyWith(top: 0.0)
        );
      }
      if (navBar != null) {
        topPadding = mediaQueryData.padding.top + navBar.preferredSize.height;
      }
      EdgeInsets padding;
      if (autoAddTopPadding && autoAddBottomPadding) {
        padding = EdgeInsets.only(top: topPadding, bottom: mediaQueryData.padding.bottom);
      } else if (autoAddTopPadding && !autoAddBottomPadding) {
        padding = EdgeInsets.only(top: topPadding);
      } else if (!autoAddTopPadding && autoAddBottomPadding) {
        padding = EdgeInsets.only(bottom: mediaQueryData.padding.bottom);
      }
      Widget body = valueFromCupertino('body', this.body);
      if (!fullObstruction && autoAddTopPadding && resetMediaPaddingTop) {
        _mediaQueryData = mediaQueryData.copyWith(
          padding: MediaQuery.of(context).padding?.copyWith(top: 0.0)
        );
      }
      return CupertinoPageScaffold(
        key: valueFromCupertino('key', key),
        navigationBar: navBar,
        backgroundColor: valueFromCupertino('backgroundColor', backgroundColor),
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        child: fullObstruction ? (
          _mediaQueryData != null ? MediaQuery(
            data: _mediaQueryData, child: body
          ) : body
        ) : (
          _mediaQueryData != null ? MediaQuery(
            data: _mediaQueryData,
            child: padding != null ? Padding(
              padding: padding,
              child: body
            ) : body
          ) : padding != null ? Padding(
            padding: padding,
            child: body
          ) : body
        )
      );
    }
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    BaseTabBar tabBar = valueFromMaterial('tabBar', this.tabBar);
    List<Widget> tabViews = valueFromMaterial('tabViews', this.tabViews);
    if (tabBar != null && tabViews.length > 0) {
      return Scaffold(
        key: valueFromMaterial('key', key),
        body: DefaultTabController(
          length: tabViews.length,
          child: TabBarView(
            children: tabViews
          )
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
        primary: primary
      );
    } else {
      BaseAppBar appBar = valueFromMaterial('appBar', this.appBar) ?? valueFromMaterial('navBar', navBar);
      return Scaffold(
        key: valueFromMaterial('key', key),
        appBar: appBar?.build(context),
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
        primary: primary
      );
    }
  }

}