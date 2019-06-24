import 'package:flutter/cupertino.dart' hide CupertinoNavigationBar;
import 'package:flutter/material.dart' hide AppBar;
import 'package:flutter/widgets.dart';

import '../base_stateless_widget.dart';
import '../flutter/flutter_modify.dart' show AppBar, CupertinoNavigationBar;
import '../platform/platform.dart';
import '../theme/base_theme.dart';
import '../theme/base_theme_data.dart';

/// BaseAppBar
///
/// *** You need to call the build method manually, otherwise [BaseThemeData.appBarHeight] won't work.
/// *** 使用时需手动调用build方法，否则 [BaseThemeData.appBarHeight] 不起作用
///
/// use CupertinoNavigationBar by cupertino
/// *** use cupertino = { forceUseMaterial: true } force use AppBar on cuperitno.
/// use AppBar by material
/// *** use material = { forceUseCupertino: true } force use CupertinoNavigationBar on material.
class BaseAppBar extends BaseStatelessWidget
    implements ObstructingPreferredSizeWidget {
  const BaseAppBar({
    Key baseKey,
    this.key,
    this.leading,
    this.trailing,
    this.automaticallyImplyLeading = true,
    this.automaticallyImplyMiddle = true,
    this.backgroundColor,
    this.previousPageTitle,
    this.middle,
    this.border = const Border(
      bottom: BorderSide(
        color: Color(0x4C000000),
        width: 0.0, // One physical pixel.
        style: BorderStyle.solid,
      ),
    ),
    this.padding,
    this.transitionBetweenRoutes,
    this.heroTag,
    this.backdropFilter,
    this.autoSetMiddleColor,
    this.autoSetLeadingColor,
    this.autoSetTrailingColor,
    this.autoSetBottomColor,
    this.height,
    this.title,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.elevation = 4.0,
    this.brightness,
    this.iconTheme,
    this.textTheme,
    this.primary = true,
    this.centerTitle,
    this.titleSpacing = NavigationToolbar.kMiddleSpacing,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
    Map<String, dynamic> cupertino,
    Map<String, dynamic> material,
  }) : super(key: baseKey, cupertino: cupertino, material: material);

  /// *** general properties start ***

  @override
  final Key key;

  /// [CupertinoNavigationBar.leading]
  /// or
  /// [AppBar.leading]
  final Widget leading;

  /// [CupertinoNavigationBar.automaticallyImplyLeading]
  /// or
  /// [AppBar.automaticallyImplyLeading]
  final bool automaticallyImplyLeading;

  /// [CupertinoNavigationBar.automaticallyImplyMiddle]
  /// or
  /// [AppBar.automaticallyImplyMiddle]
  final bool automaticallyImplyMiddle;

  /// [CupertinoNavigationBar.backgroundColor]
  /// or
  /// [AppBar.backgroundColor]
  final Color backgroundColor;

  /// [CupertinoNavigationBar.toolbarOpacity], cupertino also support
  /// or
  /// [AppBar.toolbarOpacity]
  final double toolbarOpacity;

  /// [CupertinoNavigationBar.bottom], cupertino also support
  /// or
  /// [AppBar.bottom]
  ///
  /// when the (title/middle = null && bootom != null)
  /// the bottom will replace title.
  ///
  /// 当(title/middle = null && bootom != null)时，bottom会替代title
  final PreferredSizeWidget bottom;

  /// [CupertinoNavigationBar.bottomOpacity], cupertino also support
  /// or
  /// [AppBar.bottomOpacity]
  final double bottomOpacity;

  /// [CupertinoNavigationBar.navBarPersistentHeight]
  /// default is [CupertinoNavigationBar._kNavBarPersistentHeight] = 44.0
  /// or
  /// [AppBar.toolbarHeight]
  /// default is [kToolbarHeight] = 56.0
  ///
  /// If this property is null, then [BaseThemeData.appBarHeight] is used
  /// 1. use by { appBar: BaseAppBar() }, the [BaseThemeData.appBarHeight] won't work,
  ///   will use [preferredSize]'s height
  /// 2. use by { appBar: BaseAppBar().build(context) }, the [BaseThemeData.appBarHeight] will work,
  ///   will replace the [preferredSize]'s height
  /// 3. Pay attention two ways's build order is different
  ///   1.build BaseScaffold brfore build BaseAppBar
  ///   2.build BaseScaffold after build BaseAppBar
  ///
  /// 当为null是，会使用[BaseThemeData.appBarHeight]参数
  /// 1、如果这样使用 { appBar: BaseAppBar() }，则[BaseThemeData.appBarHeight]该参数不起作用，
  ///   将会使用[preferredSize]'s height
  /// 2、如果这样使用 { appBar: BaseAppBar().build(context) }，则[BaseThemeData.appBarHeight]会起作用，
  ///   将会覆盖[preferredSize]'s height
  /// 3、注意2种方式的build顺序不一样，
  ///   1.是先build BaseScaffold, 再build BaseAppBar
  ///   2.是先build BaseAppBar, 再build BaseScaffold
  final double height;

  /// *** general properties end ***

  /// *** cupertino properties start ***

  /// [CupertinoNavigationBar.previousPageTitle]
  final String previousPageTitle;

  /// [CupertinoNavigationBar.middle]
  final Widget middle;

  /// [CupertinoNavigationBar.trailing]
  ///
  /// If this property is null, then [actions] is used, and use [Row] when actions.length > 1
  ///
  /// 当该参数为null时，会使用[actions], actions.length > 1时，会用[Row]组装
  final Widget trailing;

  /// [CupertinoNavigationBar.border]
  final Border border;

  /// [CupertinoNavigationBar.padding]
  final EdgeInsetsDirectional padding;

  /// [CupertinoNavigationBar.transitionBetweenRoutes]
  final bool transitionBetweenRoutes;

  /// [CupertinoNavigationBar.heroTag]
  final Object heroTag;

  /// [CupertinoNavigationBar.backdropFilter], default is true
  ///
  /// effective only backgroundColor is transparent.
  /// default is true, will add BackdropFilter when then backgroundColor is transparent.
  ///
  /// 是否加入高斯模糊效果，背景色为透明时有效
  /// 想实现全透明可以设置成false
  final bool backdropFilter;

  /// [CupertinoNavigationBar.autoSetMiddleColor], default is true
  ///
  /// Auto set middle's color follow the barightness
  /// will cover the navTitleTextStyle's color
  ///
  /// 标题跟随背景亮度自动改变黑白色
  final bool autoSetMiddleColor;

  /// [CupertinoNavigationBar.autoSetLeadingColor], defautl is true
  ///
  /// Auto set [leading]'s color follow the brightness
  /// event the BcakButton，will cover the navActionTextStyle's color
  ///
  /// leading跟随背景亮度自动改变黑白色, 当为true时，actionsForegroundColor参数会失效
  /// 当leading为icon时，实际上是actionsForegroundColor参数修改颜色，
  /// 此时的autoSetTrailingColor会失效
  final bool autoSetLeadingColor;

  /// [CupertinoNavigationBar.autoSetTrailingColor], default is true
  ///
  /// Auto set [trailing]'s color follow the barightness
  /// will cover the navActionTextStyle's color
  ///
  /// trailing跟随背景亮度自动改变黑白色, 当为true时，actionsForegroundColor参数会失效
  /// 当trailing为icon时，实际上是actionsForegroundColor参数修改颜色，
  /// 此时的autoSetLeadingColor会失效
  final bool autoSetTrailingColor;

  /// [CupertinoNavigationBar.autoSetBottomColor], default is true
  ///
  /// Auto set [bottom]'s color follow the barightness
  /// will cover the navActionTextStyle's color
  ///
  /// [bottom]跟随背景亮度自动改变黑白色
  final bool autoSetBottomColor;

  /// *** cupertino properties ened ***

  /// *** material properties start ***

  /// [AppBar.title]
  ///
  /// If this property is null, then [middle] is used
  ///
  /// 当该参数为null时，会使用[middle]
  final Widget title;

  /// [AppBar.actions]
  ///
  /// If this property is null, then [trailing] is used
  ///
  /// 当该参数为null时，会使用[trailing]
  final List<Widget> actions;

  /// [AppBar.flexibleSpace]
  final Widget flexibleSpace;

  /// [AppBar.elevation]
  final double elevation;

  /// [AppBar.brightness]
  final Brightness brightness;

  /// [AppBar.iconTheme]
  final IconThemeData iconTheme;

  /// [AppBar.textTheme]
  final TextTheme textTheme;

  /// [AppBar.primary]
  final bool primary;

  /// [AppBar.centerTitle]
  ///
  /// If this property is null, then [BaseThemeData.appBarCenterTitle] is used
  ///
  /// 当该参数为null时，会使用[BaseThemeData.appBarCenterTitle]
  final bool centerTitle;

  /// [AppBar.titleSpacing]
  final double titleSpacing;

  /// *** material properties end ***

  @override
  Widget buildByCupertino(BuildContext context) {
    final Widget _leading = valueFromCupertino('leading', leading);
    // trailing为null，且actions不为null，数量大于1，取trailing = adctions[0];
    Widget _trailing = valueFromCupertino('trailing', trailing);
    final List<Widget> _actions = valueFromMaterial('actions', actions);
    if (_actions != null && _actions.isNotEmpty && _trailing == null) {
      if (actions.length == 1) {
        _trailing = _actions[0];
      } else {
        _trailing = Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _actions,
        );
      }
    }
    final BaseThemeData baseTheme = BaseTheme.of(context);
    final Widget _title = valueFromCupertino('middle', middle) ??
        valueFromCupertino('title', title);
    // 没有backgroundColor使用CupertinoTheme里的barBackgroundColor，还没有使用原生的
    final Color _backgroundColor =
        valueFromCupertino('backgroundColor', backgroundColor) ??
            CupertinoTheme.of(context).barBackgroundColor ??
            const Color(0xCCF8F8F8);
    final double _toolbarOpacity =
        valueFromCupertino('toolbarOpacity', toolbarOpacity);

    final bool autoSetMiddleColor = this.autoSetMiddleColor ??
        baseTheme.valueFromCupertino(
          'appBarAutoSetMiddleColor',
          baseTheme.appBarAutoSetMiddleColor,
        ) ??
        true;
    final bool autoSetBottomColor = this.autoSetBottomColor ??
        baseTheme.valueFromCupertino(
          'appBarAutoSetBottomColor',
          baseTheme.appBarAutoSetBottomColor,
        ) ??
        true;

    final bool autoSetLeadingColor = this.autoSetLeadingColor ??
        baseTheme.valueFromCupertino(
          'appBarAutoSetLeadingColor',
          baseTheme.appBarAutoSetLeadingColor,
        ) ??
        true;
    final bool autoSetTrailingColor = this.autoSetTrailingColor ??
        baseTheme.valueFromCupertino(
          'appBarAutoSetTrailingColor',
          baseTheme.appBarAutoSetTrailingColor,
        ) ??
        true;
    // 当背景颜色非透明的，不加入高斯模糊
    bool _backdropFilter = backdropFilter ??
        baseTheme.valueFromCupertino(
          'appBarBackdropFilter',
          baseTheme.appBarBackdropFilter,
        ) ??
        true;
    // 背景色不透明不加模糊
    if (_backgroundColor.alpha == 0xFF) {
      _backdropFilter = false;
    }
    CupertinoNavigationBar cupertinoNavigationBar;
    final double _height = valueFromCupertino('height', height) ??
        baseTheme.valueFromCupertino('appBarHeight', baseTheme.appBarHeight) ??
        44.0;
    final bool transitionBetweenRoutes =
        this.transitionBetweenRoutes ?? baseTheme.appBarTransitionBetweenRoutes;
    if (heroTag != null) {
      cupertinoNavigationBar = CupertinoNavigationBar(
        key: valueFromCupertino('key', key),
        leading: _leading,
        automaticallyImplyLeading: valueFromCupertino(
          'automaticallyImplyLeading',
          automaticallyImplyLeading,
        ),
        automaticallyImplyMiddle: automaticallyImplyMiddle,
        previousPageTitle: previousPageTitle,
        middle: _title,
        trailing: _trailing,
        border: border,
        backgroundColor: _backgroundColor,
        padding: padding,
        transitionBetweenRoutes: transitionBetweenRoutes,
        heroTag: heroTag,
        backdropFilter: _backdropFilter,
        navBarPersistentHeight: _height,
        bottom: valueFromCupertino('bottom', bottom),
        bottomOpacity: valueFromCupertino('bottomOpacity', bottomOpacity),
        toolbarOpacity: _toolbarOpacity,
        autoSetLeadingColor: autoSetLeadingColor,
        autoSetMiddleColor: autoSetMiddleColor,
        autoSetTrailingColor: autoSetTrailingColor,
        autoSetBottomColor: autoSetBottomColor,
      );
    } else {
      cupertinoNavigationBar = CupertinoNavigationBar(
        key: valueFromCupertino('key', key),
        leading: _leading,
        automaticallyImplyLeading: valueFromCupertino(
          'automaticallyImplyLeading',
          automaticallyImplyLeading,
        ),
        automaticallyImplyMiddle: automaticallyImplyMiddle,
        previousPageTitle: previousPageTitle,
        middle: _title,
        trailing: _trailing,
        border: border,
        backgroundColor: _backgroundColor,
        padding: padding,
        transitionBetweenRoutes: transitionBetweenRoutes,
        backdropFilter: _backdropFilter,
        navBarPersistentHeight: _height,
        bottom: valueFromCupertino('bottom', bottom),
        bottomOpacity: valueFromCupertino('bottomOpacity', bottomOpacity),
        toolbarOpacity: _toolbarOpacity,
        autoSetLeadingColor: autoSetLeadingColor,
        autoSetMiddleColor: autoSetMiddleColor,
        autoSetTrailingColor: autoSetTrailingColor,
        autoSetBottomColor: autoSetBottomColor,
      );
    }
    return cupertinoNavigationBar;
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    final Widget _title = valueFromMaterial('title', title) ??
        valueFromMaterial('middle', middle);
    Widget _leading = valueFromMaterial('leading', leading);
    final EdgeInsetsDirectional _padding = valueFromMaterial(
      'padding',
      padding,
    );
    if (_padding != null && _leading != null) {
      _leading = Padding(
        padding: EdgeInsets.only(left: _padding.start),
        child: _leading,
      );
    }
    // actions为null，且trailing不为nul,，取trailing = [ trailing ];
    List<Widget> _actions = valueFromMaterial('actions', actions);
    final Widget _trailing = valueFromMaterial('trailing', trailing);
    if (_actions == null && _trailing != null) {
      _actions = <Widget>[_trailing];
    }
    final Color _backgroundColor = valueFromMaterial(
          'backgroundColor',
          backgroundColor,
        ) ??
        Theme.of(context).appBarTheme.color ??
        Theme.of(context).primaryColor;

    final BaseThemeData baseTheme = BaseTheme.of(context);
    final double _height = valueFromMaterial('height', height) ??
        baseTheme.valueFromMaterial('appBarHeight', baseTheme.appBarHeight) ??
        kToolbarHeight;
    final bool centerTitle = this.centerTitle ??
            baseTheme.valueFromMaterial(
              'appBarCenterTitle',
              baseTheme.appBarCenterTitle,
            ) ??
            Theme.of(context).platform == TargetPlatform.iOS
        ? true
        : false;
    return AppBar(
      key: valueFromMaterial('key', key),
      leading: _leading,
      automaticallyImplyLeading: valueFromMaterial(
        'automaticallyImplyLeading',
        automaticallyImplyLeading,
      ),
      title: _title,
      actions: _actions,
      flexibleSpace: flexibleSpace,
      bottom: valueFromMaterial('bottom', bottom),
      elevation: elevation,
      backgroundColor: _backgroundColor,
      brightness: brightness,
      iconTheme: iconTheme,
      textTheme: textTheme,
      primary: primary,
      centerTitle: centerTitle,
      titleSpacing: titleSpacing,
      toolbarOpacity: valueFromMaterial('toolbarOpacity', toolbarOpacity),
      bottomOpacity: valueFromMaterial('bottomOpacity', bottomOpacity),
      toolbarHeight: _height,
    );
  }

  @override
  bool get fullObstruction =>
      backgroundColor == null ? null : backgroundColor.alpha == 0xFF;

  /// 1. use by { appBar: BaseAppBar() }, the [BaseThemeData.appBarHeight] won't work,
  ///   will use [preferredSize]'s height
  /// 2. use by { appBar: BaseAppBar().build(context) }, the [BaseThemeData.appBarHeight] will work,
  ///   will replace the [preferredSize]'s height
  /// 3. Pay attention, two ways's build order is different
  ///   1.build BaseScaffold brfore build BaseAppBar
  ///   2.build BaseScaffold after build BaseAppBar
  ///
  /// 当为null是，会使用[BaseThemeData.appBarHeight]参数
  /// 1、如果这样使用 { appBar: BaseAppBar() }，则[BaseThemeData.appBarHeight]该参数不起作用，
  ///   将会使用[preferredSize]'s height
  /// 2、如果这样使用 { appBar: BaseAppBar().build(context) }，则[BaseThemeData.appBarHeight]会起作用，
  ///   将会覆盖[preferredSize]'s height
  /// 3、注意2种方式的build顺序不一样，
  ///   1.是先build BaseScaffold, 再build BaseAppBar
  ///   2.是先build BaseAppBar, 再build BaseScaffold
  @override
  Size get preferredSize {
    double _height =
        height != null ? height : (useCupertino ? 44.0 : kToolbarHeight);
    final Widget middle = valueFromMaterial('title', title) ??
        valueFromMaterial('middle', this.middle);
    if (middle != null && bottom != null) {
      _height += bottom.preferredSize.height;
    }
    return Size.fromHeight(_height);
  }
}
