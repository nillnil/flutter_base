
import 'dart:async';

import 'package:base/base_stateless_widget.dart';
import 'package:base/navbar/base_navbar.dart';
import 'package:base/tabbar/cupertino_top_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 基础TopTab页面, 页面内顶部tab
/// 如果有导航栏，则tab放在最顶部，导航栏之下，tab的labelStyle使用的是导航栏的样式
/// 如果没有导航栏，则tab放在导航栏的middle/title中，且tab高度不能大于导航栏高度，即tab的icon跟text不能同时都使用，这样的好处是状态栏的底色会跟导航栏统一
/// *** 如果要在tab前面加widget则只能加在导航栏中，如搜索栏
/// cupertino，使用自定义pageView
/// *** 可使用 cupertino = { forceUseMaterial: true } 参数强制使用PageView
/// material，使用appBar里的bottom
/// *** 如果要在tab前面加widget则只能加在导航栏中，如搜索栏
/// *** 可使用 material = { forceUseCupertino: true } 参数强制使用Scaffold
class BaseTopTabPage extends BaseStatelessWidget {

  // general
  final BaseNavBar appBar;
  final BaseNavBar navBar;
  final Color backgroundColor;
  final TabBar tabBar;
  final Widget body;
	final Color tabBarBackgroundColor;

  // cupertino
  final bool resizeToAvoidBottomInset;
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

  final Map<String, Object> cupertino;
  final Map<String, Object> material;

  BaseTopTabPage({
    Key key,
    this.appBar,
    this.navBar,
    this.backgroundColor = Colors.white,
		this.tabBar,
    this.body,
		this.tabBarBackgroundColor,

    this.resizeToAvoidBottomInset = true,
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

    this.cupertino,
    this.material
  }) : super(key: key, cupertino: cupertino, material: material);

  @override
  Widget buildByCupertino(BuildContext context) {
		BaseNavBar navBar = valueFromCupertino('navBar', this.navBar) ?? valueFromCupertino('appBar', this.appBar);
		Widget navBarWidget = navBar?.build(context) ?? null;
		bool fullObstruction = navBar?.finalBackgroundColor?.alpha == 0xFF && navBarWidget != null ?? true;
		MediaQueryData mediaQueryData = MediaQuery.of(context);
		double topPadding = mediaQueryData.padding.top;
		Widget body = valueFromCupertino('body', this.body);
		TextStyle labelStyle = TextStyle();
		// tabBar不为null且body是PageView，则创建CupertinoTopBar
		if (tabBar != null && body is PageView) {
			PageView bodyPageView = body as PageView;
			GlobalKey<CupertinoTopBarState> cupertinoBottomBarKey = GlobalKey<CupertinoTopBarState>();
			Widget bottomWidget;
			if (navBarWidget == null) {
				navBar = BaseNavBar(
					backgroundColor: tabBarBackgroundColor,
					middle: CupertinoTopBar(
						key: cupertinoBottomBarKey,
						tabBar: tabBar,
						labelStyle: labelStyle,
						pageController:  (body as PageView).controller,
					)
				);
				navBarWidget = navBar.build(context);
				fullObstruction = navBar?.finalBackgroundColor?.alpha == 0xFF ?? true;
				Timer(Duration(seconds: 1), () {
					print(cupertinoBottomBarKey.currentContext.size);
				});
			} else {
				bottomWidget = CupertinoTopBar(
					key: cupertinoBottomBarKey,
					tabBar: tabBar,
					backgroundColor: tabBarBackgroundColor ?? navBar?.finalBackgroundColor,
					labelStyle: labelStyle,
					pageController:  (body as PageView).controller,
				);
			}
			PageView newBody = PageView.custom(
				key: bodyPageView.key,
				scrollDirection: bodyPageView.scrollDirection,
				reverse: bodyPageView.reverse,
				controller: bodyPageView.controller,
				physics: bodyPageView.physics,
				pageSnapping: bodyPageView.pageSnapping,
				onPageChanged: (int index) {
					if (index < tabBar.tabs.length) {
						cupertinoBottomBarKey.currentState.changeTab(index);
						if (bodyPageView.onPageChanged != null) {
							bodyPageView.onPageChanged(index);
						}
					}
				},
				childrenDelegate: bodyPageView.childrenDelegate
			);
			body = Container(
				child: bottomWidget != null ? Column(
					children: <Widget>[
						Padding(
							padding: EdgeInsets.only(top: 0.0),
							child: bottomWidget,
						),
						Expanded(
							child: newBody
						)
					]
				) : newBody
			);
		}
		if (navBarWidget != null) {
			topPadding += (navBarWidget as ObstructingPreferredSizeWidget).preferredSize.height;
		}
		EdgeInsets padding;
		if (autoAddTopPadding && autoAddBottomPadding) {
			padding = EdgeInsets.only(top: topPadding, bottom: mediaQueryData.padding.bottom);
		} else if (autoAddTopPadding && !autoAddBottomPadding) {
			padding = EdgeInsets.only(top: topPadding);
		} else if (!autoAddTopPadding && autoAddBottomPadding) {
			padding = EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom);
		}
		return CupertinoPageScaffold(
			key: valueFromCupertino('key', key),
			navigationBar: navBarWidget,
			backgroundColor: valueFromCupertino('backgroundColor', backgroundColor),
			resizeToAvoidBottomInset: resizeToAvoidBottomInset,
			child: fullObstruction ? body : padding != null ? Padding(
				padding: padding,
				child: body
			) : body
		);
  }

  @override
  Widget buildByMaterial(BuildContext context) {
		BaseNavBar appBar = valueFromMaterial('appBar', this.appBar) ?? valueFromMaterial('navBar', navBar);
		Widget body = valueFromMaterial('body', this.body);
		if (tabBar != null) {
			if (appBar != null) {
				appBar = appBar.copyWith(bottom: tabBar);
			} else {
				appBar = BaseNavBar(
					title: tabBar,
					titleSpacing: 0.0
				);
			}
		}
		return Scaffold(
			key: valueFromMaterial('key', key),
			appBar: appBar?.build(context),
			body: body,
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