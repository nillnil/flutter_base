import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';

import '../appbar/base_app_bar.dart';
import '../base_stateless_widget.dart';

/// BaseScaffold
/// use CupertinoPageScaffold by cupertino, tab's scaffold use CupertinoTabScaffold
/// *** use cupertino = { forceUseMaterial: true } force use Scaffold on cuperitno.
/// use Scaffold by material
/// *** use material = { forceUseCupertino: true } force use CupertinoPageScaffold/CupertinoTabScaffold on material.
class BaseScaffold extends BaseStatelessWidget {
  BaseScaffold({
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
    this.bottomSheet,
    this.resizeToAvoidBottomPadding = true,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    Map<String, dynamic> cupertino,
    Map<String, dynamic> material,
  }) : super(key: baseKey, cupertino: cupertino, material: material);

  // general
  @override
  final Key key;
  final BaseAppBar appBar;
  final BaseAppBar navBar;
  final Color backgroundColor;
  final Widget body;

  // cupertino
  final bool resizeToAvoidBottomInset;

  /// 相当于SafeArea的top，默认false
  /// 当导航栏背景色为透明的，设置为true可以使页面起点在导航栏下方
  final bool safeAreaTop;

  /// 相当于SafeArea的bottom，默认false
  /// 设置为true可以避免页面被iphone下方的Home Indicator遮住
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
  final DragStartBehavior drawerDragStartBehavior;
  final bool extendBody;

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
    return CupertinoPageScaffold(
      key: valueFromCupertino('key', key),
      navigationBar: appBar,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: valueFromCupertino(
          'resizeToAvoidBottomInset', resizeToAvoidBottomInset),
      child: child,
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    final BaseAppBar appBar = valueFromMaterial('appBar', this.appBar) ??
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
      resizeToAvoidBottomInset: valueFromMaterial(
          'resizeToAvoidBottomInset', resizeToAvoidBottomInset),
      primary: primary,
      drawerDragStartBehavior: drawerDragStartBehavior,
      extendBody: extendBody,
    );
  }
}
