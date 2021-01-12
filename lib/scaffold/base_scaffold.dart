import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';

import '../appbar/base_app_bar.dart';
import '../base_stateless_widget.dart';
import '../theme/base_theme.dart';

/// BaseScaffold
/// use CupertinoPageScaffold by cupertino, tab's scaffold use CupertinoTabScaffold
/// *** use cupertino = { forceUseMaterial: true } force use Scaffold on cuperitno.
/// use Scaffold by material
/// *** use material = { forceUseCupertino: true } force use CupertinoPageScaffold/CupertinoTabScaffold on material.
/// 
/// CupertinoPageScaffold: 2020.06.11
/// Scaffold: 2020.09.11
/// modify 2021.01.12 by flutter 1.22.5
class BaseScaffold extends BaseStatelessWidget {
  const BaseScaffold({
    Key baseKey,
    this.key,
    this.appBar,
    this.navBar,
    this.backgroundColor,
    this.body,
    this.resizeToAvoidBottomInset = true,
    this.safeAreaTop = false,
    this.safeAreaBottom = false,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.drawer,
    this.endDrawer,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    Map<String, dynamic> cupertino,
    Map<String, dynamic> material,
  }) : super(key: baseKey, cupertino: cupertino, material: material);

  /// *** general properties start ***

  @override
  final Key key;

  /// [CupertinoPageScaffold.navigationBar]
  /// or
  /// [Scaffold.appBar]
  /// If this properties is null, then [navBar] is use.
  ///
  /// 该参数为null，则会使用[navBar]
  final BaseAppBar appBar;

  /// [CupertinoPageScaffold.navigationBar]
  /// or
  /// [Scaffold.appBar]
  ///
  /// If this properties is null, then [appBar] is use.
  ///
  /// 该参数为null，则会使用[appBar]
  final BaseAppBar navBar;

  /// [CupertinoPageScaffold.backgroundColor]
  /// or
  /// [Scaffold.backgroundColor]
  final Color backgroundColor;

  /// [CupertinoPageScaffold.body]
  /// or
  /// [Scaffold.body]
  final Widget body;

  /// [CupertinoPageScaffold.resizeToAvoidBottomInset]
  /// or
  /// [Scaffold.resizeToAvoidBottomInset]
  final bool resizeToAvoidBottomInset;

  /// *** general properties end ***

  /// *** cupertino properties start ***

  /// [SafeArea.top], default is false
  /// 相当于SafeArea的top，默认false
  /// 当导航栏背景色为透明的，设置为true可以使页面起点在导航栏下方
  final bool safeAreaTop;

  /// [SafeArea.bottom], default is false
  /// 相当于SafeArea的bottom，默认false
  /// 设置为true可以避免页面被iphone下方的Home Indicator遮住
  final bool safeAreaBottom;

  /// *** cupertino properties end ***

  /// *** material properties start ***

  /// [Scaffold.floatingActionButton]
  final Widget floatingActionButton;

  /// [Scaffold.floatingActionButtonLocation]
  final FloatingActionButtonLocation floatingActionButtonLocation;

  /// [Scaffold.floatingActionButtonAnimator]
  final FloatingActionButtonAnimator floatingActionButtonAnimator;

  /// [Scaffold.persistentFooterButtons]
  final List<Widget> persistentFooterButtons;

  /// [Scaffold.drawer]
  final Widget drawer;

  /// [Scaffold.endDrawer]
  final Widget endDrawer;

  /// [Scaffold.bottomNavigationBar]
  final Widget bottomNavigationBar;

  /// [Scaffold.bottomSheet]
  final Widget bottomSheet;

  /// [Scaffold.primary]
  final bool primary;

  /// [Scaffold.drawerDragStartBehavior]
  final DragStartBehavior drawerDragStartBehavior;

  /// [Scaffold.extendBody]
  final bool extendBody;

  /// [Scaffold.extendBodyBehindAppBar]
  final bool extendBodyBehindAppBar;

  /// [Scaffold.drawerScrimColor]
  final Color drawerScrimColor;

  /// [Scaffold.drawerEdgeDragWidth]
  final double drawerEdgeDragWidth;

  /// [Scaffold.drawerEnableOpenDragGesture]
  final bool drawerEnableOpenDragGesture;

  /// [Scaffold.endDrawerEnableOpenDragGesture]
  final bool endDrawerEnableOpenDragGesture;

  /// *** material properties end ***

  @override
  Widget buildByCupertino(BuildContext context) {
    final Color backgroundColor =
        valueFromCupertino('backgroundColor', this.backgroundColor);
    final BaseAppBar appBar = valueFromMaterial('appBar', this.appBar) ??
        valueFromMaterial('navBar', navBar);
    final Widget body = valueFromCupertino('body', this.body);
    Widget child;
    if (!safeAreaTop && !safeAreaBottom) {
      child = body;
    } else {
      child = SafeArea(
        top: safeAreaTop,
        bottom: safeAreaBottom,
        child: body,
      );
    }
    final double appBarHeight = BaseTheme.of(context).valueFromCupertino(
      'appBarHeight',
      null,
    );
    return CupertinoPageScaffold(
      key: valueFromCupertino('key', key),
      navigationBar: appBarHeight == null ? appBar : appBar?.build(context),
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: valueFromCupertino(
        'resizeToAvoidBottomInset',
        resizeToAvoidBottomInset,
      ),
      child: child,
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    final BaseAppBar appBar = valueFromMaterial('appBar', this.appBar) ??
        valueFromMaterial('navBar', navBar);
    final double appBarHeight = BaseTheme.of(context).valueFromMaterial(
      'appBarHeight',
      null,
    );
    return Scaffold(
      key: valueFromMaterial('key', key),
      appBar: appBarHeight == null ? appBar : appBar?.build(context),
      body: valueFromMaterial('body', body),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButtonAnimator: floatingActionButtonAnimator,
      persistentFooterButtons: persistentFooterButtons,
      drawer: drawer,
      endDrawer: endDrawer,
      bottomNavigationBar: bottomNavigationBar,
      bottomSheet: bottomSheet,
      backgroundColor: valueFromMaterial('backgroundColor', backgroundColor),
      resizeToAvoidBottomInset: valueFromMaterial(
        'resizeToAvoidBottomInset',
        resizeToAvoidBottomInset,
      ),
      primary: primary,
      drawerDragStartBehavior: drawerDragStartBehavior,
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      drawerScrimColor: drawerScrimColor,
      drawerEdgeDragWidth: drawerEdgeDragWidth,
      drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
      endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
    );
  }
}
