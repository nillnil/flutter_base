import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';

import '../appbar/base_app_bar.dart';
import '../base_param.dart';
import '../base_stateless_widget.dart';
import '../theme/base_theme.dart';

/// BaseScaffold
/// use CupertinoPageScaffold by cupertino, tab's scaffold use CupertinoTabScaffold
/// *** use cupertino = { forceUseMaterial: true } force use Scaffold on cuperitno.
/// use Scaffold by material
/// *** use material = { forceUseCupertino: true } force use CupertinoPageScaffold/CupertinoTabScaffold on material.
///
/// CupertinoPageScaffold: 2021.03.12
/// Scaffold: 2021.04.03
/// modify 2021.06.25 by flutter 2.2.2
class BaseScaffold extends BaseStatelessWidget {
  const BaseScaffold({
    Key? key,
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
    this.onDrawerChanged,
    this.onEndDrawerChanged,
    this.restorationId,
    BaseParam? baseParam,
  }) : super(key: key, baseParam: baseParam);

  /// *** general properties start ***

  /// [CupertinoPageScaffold.navigationBar]
  /// or
  /// [Scaffold.appBar]
  /// If this properties is null, then [navBar] is use.
  ///
  /// 该参数为null，则会使用[navBar]
  final BaseAppBar? appBar;

  /// [CupertinoPageScaffold.navigationBar]
  /// or
  /// [Scaffold.appBar]
  ///
  /// If this properties is null, then [appBar] is use.
  ///
  /// 该参数为null，则会使用[appBar]
  final BaseAppBar? navBar;

  /// [CupertinoPageScaffold.backgroundColor]
  /// or
  /// [Scaffold.backgroundColor]
  final Color? backgroundColor;

  /// [CupertinoPageScaffold.body]
  /// or
  /// [Scaffold.body]
  final Widget? body;

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

  /// [Scaffold.bottomNavigationBar]
  final Widget? bottomNavigationBar;

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

  /// [Scaffold.restorationId]
  final String? restorationId;

  /// *** material properties end ***

  @override
  Widget buildByCupertino(BuildContext context) {
    final Widget body = valueOf('body', this.body);
    assert(body != null, 'body can\'t be null');
    final Color? backgroundColor = valueOf('backgroundColor', this.backgroundColor);
    final BaseAppBar? appBar = valueOf('appBar', this.appBar) ?? valueOf('navBar', navBar);
    final double? appBarHeight = BaseTheme.of(context).valueOf('appBarHeight', BaseTheme.of(context).appBarHeight);
    Widget? navigationBar;
    if (appBarHeight != null && appBar != null) {
      navigationBar = appBar.build(context);
    } else {
      navigationBar = appBar;
    }
    Widget _child;
    if (!safeAreaTop && !safeAreaBottom) {
      _child = body;
    } else {
      _child = SafeArea(
        top: safeAreaTop,
        bottom: safeAreaBottom,
        child: body,
      );
    }
    return CupertinoPageScaffold(
      navigationBar: navigationBar != null ? navigationBar as ObstructingPreferredSizeWidget : null,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: valueOf('resizeToAvoidBottomInset', resizeToAvoidBottomInset),
      child: _child,
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    final BaseAppBar? appBar = valueOf('appBar', this.appBar) ?? valueOf('navBar', navBar);
    final double? appBarHeight = BaseTheme.of(context).valueOf('appBarHeight', BaseTheme.of(context).appBarHeight);
    Widget? _appBar;
    if (appBarHeight != null && appBar != null) {
      _appBar = appBar.build(context);
    } else {
      _appBar = appBar;
    }
    return Scaffold(
      appBar: _appBar != null ? _appBar as PreferredSizeWidget : null,
      body: valueOf('body', body),
      floatingActionButton: valueOf('floatingActionButton', floatingActionButton),
      floatingActionButtonLocation: valueOf('floatingActionButtonLocation', floatingActionButtonLocation),
      floatingActionButtonAnimator: valueOf('floatingActionButtonAnimator', floatingActionButtonAnimator),
      persistentFooterButtons: valueOf('persistentFooterButtons', persistentFooterButtons),
      drawer: valueOf('drawer', drawer),
      onDrawerChanged: valueOf('onDrawerChanged', onDrawerChanged),
      endDrawer: valueOf('endDrawer', endDrawer),
      onEndDrawerChanged: valueOf('onEndDrawerChanged', onEndDrawerChanged),
      bottomNavigationBar: valueOf('bottomNavigationBar', bottomNavigationBar),
      bottomSheet: valueOf('bottomSheet', bottomSheet),
      backgroundColor: valueOf('backgroundColor', backgroundColor),
      resizeToAvoidBottomInset: valueOf('resizeToAvoidBottomInset', resizeToAvoidBottomInset),
      primary: valueOf('primary', primary),
      drawerDragStartBehavior: valueOf('drawerDragStartBehavior', drawerDragStartBehavior),
      extendBody: valueOf('extendBody', extendBody),
      extendBodyBehindAppBar: valueOf('extendBodyBehindAppBar', extendBodyBehindAppBar),
      drawerScrimColor: valueOf('drawerScrimColor', drawerScrimColor),
      drawerEdgeDragWidth: valueOf('drawerEdgeDragWidth', drawerEdgeDragWidth),
      drawerEnableOpenDragGesture: valueOf('drawerEnableOpenDragGesture', drawerEnableOpenDragGesture),
      endDrawerEnableOpenDragGesture: valueOf('endDrawerEnableOpenDragGesture', endDrawerEnableOpenDragGesture),
      restorationId: valueOf('restorationId', restorationId),
    );
  }
}
