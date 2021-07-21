import 'package:flutter/cupertino.dart' hide CupertinoNavigationBar;
import 'package:flutter/material.dart' hide AppBar;
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:flutter/widgets.dart';

import '../base_param.dart';
import '../base_stateless_widget.dart';
import '../flutter/cupertino/nav_bar.dart';
import '../flutter/material/app_bar.dart';
import '../mode/base_mode.dart';
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
///
/// CupertinoNavigationBar: 2021.04.01
/// AppBar: 2021.03.30
/// modify 2021.06.25 by flutter 2.2.2
class BaseAppBar extends BaseStatelessWidget implements ObstructingPreferredSizeWidget {
  const BaseAppBar({
    Key? key,
    this.leading,
    this.trailing,
    this.automaticallyImplyLeading = true,
    this.automaticallyImplyMiddle = true,
    this.backgroundColor,
    this.brightness,
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
    this.height,
    this.title,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.elevation = 4.0,
    this.iconTheme,
    this.shadowColor,
    this.shape,
    this.actionsIconTheme,
    this.textTheme,
    this.primary = true,
    this.centerTitle,
    this.titleSpacing = NavigationToolbar.kMiddleSpacing,
    this.excludeHeaderSemantics = false,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
    this.foregroundColor,
    this.leadingWidth,
    this.backwardsCompatibility,
    this.toolbarTextStyle,
    this.titleTextStyle,
    this.systemOverlayStyle,
    BaseParam? baseParam,
  }) : super(key: key, baseParam: baseParam);

  /// *** general properties start ***

  /// [CupertinoNavigationBar.leading]
  /// or
  /// [AppBar.leading]
  final Widget? leading;

  /// [CupertinoNavigationBar.automaticallyImplyLeading]
  /// or
  /// [AppBar.automaticallyImplyLeading]
  final bool automaticallyImplyLeading;

  /// [CupertinoNavigationBar.automaticallyImplyMiddle]
  /// or
  /// [AppBar.automaticallyImplyMiddle]
  final bool automaticallyImplyMiddle;

  /// [CupertinoNavigationBar.backgroundColor]
  final Color? backgroundColor;

  /// [AppBar.brightness]
  /// or
  /// [CupertinoNavigationBar.backgroundColor]
  final Brightness? brightness;

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
  final PreferredSizeWidget? bottom;

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
  final double? height;

  /// *** general properties end ***

  /// *** cupertino properties start ***

  /// [CupertinoNavigationBar.previousPageTitle]
  final String? previousPageTitle;

  /// [CupertinoNavigationBar.middle]
  final Widget? middle;

  /// [CupertinoNavigationBar.trailing]
  ///
  /// If this property is null, then [actions] is used, and use [Row] when actions.length > 1
  ///
  /// 当该参数为null时，会使用[actions], actions.length > 1时，会用[Row]组装
  final Widget? trailing;

  /// [CupertinoNavigationBar.border]
  final Border? border;

  /// [CupertinoNavigationBar.padding]
  final EdgeInsetsDirectional? padding;

  /// [CupertinoNavigationBar.transitionBetweenRoutes]
  final bool? transitionBetweenRoutes;

  /// [CupertinoNavigationBar.heroTag]
  final Object? heroTag;

  /// [CupertinoNavigationBar.backdropFilter], default is true
  ///
  /// effective only backgroundColor is transparent.
  /// default is true, will add BackdropFilter when then backgroundColor is transparent.
  ///
  /// 是否加入高斯模糊效果，背景色为透明时有效
  /// 想实现全透明可以设置成false
  final bool? backdropFilter;

  /// *** cupertino properties ened ***

  /// *** material properties start ***

  /// [AppBar.title]
  ///
  /// If this property is null, then [middle] is used
  ///
  /// 当该参数为null时，会使用[middle]
  final Widget? title;

  /// [AppBar.shadowColor]
  final Color? shadowColor;

  /// [AppBar.shape]
  final ShapeBorder? shape;

  /// [AppBar.foregroundColor]
  final Color? foregroundColor;

  /// [AppBar.actions]
  ///
  /// If this property is null, then [trailing] is used
  ///
  /// 当该参数为null时，会使用[trailing]
  final List<Widget>? actions;

  /// [AppBar.flexibleSpace]
  final Widget? flexibleSpace;

  /// [AppBar.elevation]
  final double? elevation;

  /// [AppBar.iconTheme]
  final IconThemeData? iconTheme;

  /// [AppBar.actionsIconTheme]
  final IconThemeData? actionsIconTheme;

  /// [AppBar.textTheme]
  final TextTheme? textTheme;

  /// [AppBar.primary]
  final bool primary;

  /// [AppBar.centerTitle]
  ///
  /// If this property is null, then [BaseThemeData.appBarCenterTitle] is used
  ///
  /// 当该参数为null时，会使用[BaseThemeData.appBarCenterTitle]
  final bool? centerTitle;

  /// [AppBar.titleSpacing]
  final double? titleSpacing;

  /// [AppBar.excludeHeaderSemantics]
  final bool excludeHeaderSemantics;

  /// [AppBar.leadingWidth]
  final double? leadingWidth;

  /// [AppBar.backwardsCompatibility]
  final bool? backwardsCompatibility;

  /// [AppBar.toolbarTextStyle]
  final TextStyle? toolbarTextStyle;

  /// [AppBar.titleTextStyle]
  final TextStyle? titleTextStyle;

  /// [AppBar.systemOverlayStyle]
  final SystemUiOverlayStyle? systemOverlayStyle;

  /// *** material properties end ***

  @override
  Widget buildByCupertino(BuildContext context) {
    final Widget? _leading = valueOf('leading', leading);
    // trailing为null，且actions不为null，数量大于1，取trailing = adctions[0];
    Widget? _trailing = valueOf('trailing', trailing);
    final List<Widget>? _actions = valueOf('actions', actions);
    if (_actions != null && _actions.isNotEmpty && _trailing == null) {
      if (actions!.length == 1) {
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
    final Widget? _title = valueOf('middle', middle) ?? valueOf('title', title);
    // 没有backgroundColor使用CupertinoTheme里的barBackgroundColor，还没有使用原生的
    final Color? _backgroundColor = valueOf('backgroundColor', backgroundColor);
    final double _toolbarOpacity = valueOf('toolbarOpacity', toolbarOpacity);

    // 当背景颜色透明时，不加入高斯模糊
    bool _backdropFilter = valueOf('backdropFilter', backdropFilter) ??
        baseTheme.valueOf(
          'appBarBackdropFilter',
          baseTheme.appBarBackdropFilter,
        ) ??
        true;
    // 背景色不透明不加模糊
    if (_backgroundColor?.alpha == 0xFF) {
      _backdropFilter = false;
    }
    CupertinoNavigationBar cupertinoNavigationBar;
    final double? _height = valueOf('height', height) ?? baseTheme.valueOf('appBarHeight', baseTheme.appBarHeight);
    final bool? _transitionBetweenRoutes = valueOf('transitionBetweenRoutes', transitionBetweenRoutes) ?? baseTheme.appBarTransitionBetweenRoutes;
    final Object? _heroTag = valueOf('heroTag', heroTag);
    if (_heroTag != null) {
      cupertinoNavigationBar = CupertinoNavigationBar(
        leading: _leading,
        automaticallyImplyLeading: valueOf(
          'automaticallyImplyLeading',
          automaticallyImplyLeading,
        ),
        automaticallyImplyMiddle: automaticallyImplyMiddle,
        previousPageTitle: previousPageTitle,
        middle: _title,
        trailing: _trailing,
        border: valueOf('border', border),
        backgroundColor: _backgroundColor,
        brightness: valueOf('brightness', brightness),
        padding: valueOf('padding', padding),
        transitionBetweenRoutes: _transitionBetweenRoutes!,
        heroTag: _heroTag,
        backdropFilter: _backdropFilter,
        navBarPersistentHeight: _height,
        bottom: valueOf('bottom', bottom),
        bottomOpacity: valueOf('bottomOpacity', bottomOpacity),
        toolbarOpacity: _toolbarOpacity,
      );
    } else {
      cupertinoNavigationBar = CupertinoNavigationBar(
        key: valueOf('key', key),
        leading: _leading,
        automaticallyImplyLeading: valueOf(
          'automaticallyImplyLeading',
          automaticallyImplyLeading,
        ),
        automaticallyImplyMiddle: automaticallyImplyMiddle,
        previousPageTitle: previousPageTitle,
        middle: _title,
        trailing: _trailing,
        border: valueOf('border', border),
        backgroundColor: _backgroundColor,
        brightness: valueOf('brightness', brightness),
        padding: valueOf('padding', padding),
        transitionBetweenRoutes: _transitionBetweenRoutes!,
        backdropFilter: _backdropFilter,
        navBarPersistentHeight: _height,
        bottom: valueOf('bottom', bottom),
        bottomOpacity: valueOf('bottomOpacity', bottomOpacity),
        toolbarOpacity: _toolbarOpacity,
      );
    }
    return cupertinoNavigationBar;
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    final Widget? _title = valueOf('title', title) ?? valueOf('middle', middle);
    Widget? _leading = valueOf('leading', leading);
    final EdgeInsetsDirectional? _padding = valueOf(
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
    List<Widget>? _actions = valueOf('actions', actions);
    final Widget? _trailing = valueOf('trailing', trailing);
    if (_actions == null && _trailing != null) {
      _actions = <Widget>[_trailing];
    }
    final Color? _backgroundColor = valueOf(
      'backgroundColor',
      backgroundColor,
    );

    final BaseThemeData baseTheme = BaseTheme.of(context);
    final double? _height = valueOf('height', height) ?? baseTheme.valueOf('appBarHeight', baseTheme.appBarHeight);
    final bool centerTitle = this.centerTitle ??
        baseTheme.valueOf(
          'appBarCenterTitle',
          baseTheme.appBarCenterTitle,
        ) ??
        Theme.of(context).platform == TargetPlatform.iOS;
    return AppBar(
      leading: _leading,
      automaticallyImplyLeading: valueOf(
        'automaticallyImplyLeading',
        automaticallyImplyLeading,
      ),
      title: _title,
      actions: _actions,
      flexibleSpace: valueOf('flexibleSpace', flexibleSpace),
      bottom: valueOf('bottom', bottom),
      elevation: valueOf('elevation', elevation),
      shadowColor: valueOf('shadowColor', shadowColor),
      shape: valueOf('shape', shape),
      backgroundColor: _backgroundColor,
      foregroundColor: valueOf('foregroundColor', foregroundColor),
      brightness: valueOf('brightness', brightness),
      iconTheme: valueOf('iconTheme', iconTheme),
      actionsIconTheme: valueOf('actionsIconTheme', actionsIconTheme),
      textTheme: valueOf('textTheme', textTheme),
      primary: valueOf('primary', primary),
      centerTitle: centerTitle,
      excludeHeaderSemantics: valueOf('excludeHeaderSemantics', excludeHeaderSemantics),
      titleSpacing: valueOf('titleSpacing', titleSpacing),
      toolbarOpacity: valueOf('toolbarOpacity', toolbarOpacity),
      bottomOpacity: valueOf('bottomOpacity', bottomOpacity),
      toolbarHeight: _height,
      backwardsCompatibility: valueOf('backwardsCompatibility', backwardsCompatibility),
      toolbarTextStyle: valueOf('toolbarTextStyle', toolbarTextStyle),
      titleTextStyle: valueOf('titleTextStyle', titleTextStyle),
      systemOverlayStyle: valueOf('systemOverlayStyle', systemOverlayStyle),
    );
  }

  @override
  bool shouldFullyObstruct(BuildContext context) {
    if (isCupertinoMode) {
      final Color backgroundColor = CupertinoDynamicColor.maybeResolve(this.backgroundColor, context) ?? CupertinoTheme.of(context).barBackgroundColor;
      return backgroundColor.alpha == 0xFF;
    }
    return true;
  }

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
    double _height = height != null ? height! : (isCupertinoMode ? 44.0 : kToolbarHeight);
    final Widget? middle = valueOf('title', title) ?? valueOf('middle', this.middle);
    if (middle != null && bottom != null) {
      _height += bottom!.preferredSize.height;
    }
    return Size.fromHeight(_height);
  }
}
