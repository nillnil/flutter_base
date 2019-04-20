
import 'package:base/base_stateless_widget.dart';
import 'package:base/platform/platform.dart';
import 'package:base/utils/bsae_utils.dart';
import 'package:base/flutter/flutter_modify.dart' show AppBar, CupertinoNavigationBar;
import 'package:flutter/cupertino.dart' show CupertinoColors, CupertinoTheme, ObstructingPreferredSizeWidget, Size;
import 'package:flutter/material.dart' hide AppBar;

/// 基础导航栏
/// cupertino，使用CupertinoNavigationBar
/// *** 可使用 cupertino = { forceUseMaterial: true } 参数强制使用AppBar
/// material，使用AppBar
/// *** 可使用 material = { forceUseCupertino: true } 参数强制使用CupertinoNavigationBar
class BaseAppBar extends BaseStatelessWidget implements ObstructingPreferredSizeWidget {

	// general
	final Widget leading;
	final bool automaticallyImplyLeading;
	final bool automaticallyImplyMiddle;
	final Color backgroundColor;
	final double height;

	// cupertino
	final String previousPageTitle;
	final Widget middle;
	final Widget trailing;
	final Border border;
	final EdgeInsetsDirectional padding;
	final Color actionsForegroundColor;
	final bool transitionBetweenRoutes;
	final Object heroTag;
  // 修改源码添加（背景色为透明的）是否加入高斯模糊效果，默认true
  // 当背景色透明时默认为false，想加入请设置backdropFilter == true
	final bool backdropFilter;

	// 标题跟随背景亮度自动改变黑白色, 默认true
	final bool autoSetMiddleColor;
	// leading跟随背景亮度自动改变黑白色, 默认true，当为true时，actionsForegroundColor参数会失效
  // 当leading为icon时，实际上是actionsForegroundColor参数修改颜色，此时的autoSetTrailingColor会失效
	final bool autoSetLeadingColor;
	// trailing跟随背景亮度自动改变黑白色, 默认true，当为true时，actionsForegroundColor参数会失效
  // 当trailing为icon时，实际上是actionsForegroundColor参数修改颜色，此时的autoSetLeadingColor会失效
	final bool autoSetTrailingColor;
	// bottom跟随背景亮度自动改变黑白色, 默认true
	final bool autoSetBottomColor;

	// material
	final Widget title;
	final List<Widget> actions;
	final Widget flexibleSpace;
  // cupertino也支持
	final PreferredSizeWidget bottom;
	final double elevation;
	final Brightness brightness;
	final IconThemeData iconTheme;
	final TextTheme textTheme;
	final bool primary;
	final bool centerTitle;
	final double titleSpacing;
  // cupertino也支持
	final double toolbarOpacity;
  // cupertino也支持
	final double bottomOpacity;

	BaseAppBar({
		Key key,
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
		this.actionsForegroundColor = CupertinoColors.activeBlue,
		this.transitionBetweenRoutes = true,
		this.heroTag,
		this.backdropFilter = true,

		this.autoSetMiddleColor = true,
		this.autoSetLeadingColor = true,
		this.autoSetTrailingColor = true,
		this.autoSetBottomColor = true,

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
		Map<String, Object> cupertino,
		Map<String, Object> material,
	}) : super(cupertino: cupertino, material: material);
  
	@override
  Widget buildByCupertino(BuildContext context) {
		Widget _leading = valueFromCupertino('leading', leading);
		// trailing为null，且actions不为null，数量大于1，取trailing = adctions[0];
		Widget _trailing = valueFromCupertino('trailing', trailing);
		List<Widget> _actions = valueFromMaterial('actions', actions);
		if (_actions != null && _actions.length > 0 && _trailing == null) {
			_trailing = _actions[0];
		}
    Widget _title = valueFromCupertino('middle', middle) ?? valueFromCupertino('title', title);
		// 没有backgroundColor使用Theme里的primaryColor，还没有使用原生的
		Color _backgroundColor = valueFromCupertino('backgroundColor', backgroundColor)
			?? CupertinoTheme.of(context).barBackgroundColor
			?? Color(0xCCF8F8F8);
    double _toolbarOpacity = valueFromCupertino('toolbarOpacity', toolbarOpacity);
		Color _actionsForegroundColor = actionsForegroundColor;
		if (_backgroundColor != null) {
			Color statusBarTextColor = isLight(_backgroundColor) ? CupertinoColors.black.withOpacity(_toolbarOpacity) : CupertinoColors.white.withOpacity(_toolbarOpacity);
      // 当leading，trailing为icon时，实际上是利用actionsForegroundColor修改颜色
      if (autoSetLeadingColor || autoSetTrailingColor) {
				_actionsForegroundColor = statusBarTextColor;
			}
		}
    // 当背景颜色非透明的，不加入高斯模糊
    bool _backdropFilter = backdropFilter;
    if (_backgroundColor.alpha == 0xFF) {
      _backdropFilter = false;
    }

		CupertinoNavigationBar child = heroTag != null ? CupertinoNavigationBar(
			key: key,
			leading: _leading,
			automaticallyImplyLeading: valueFromCupertino('automaticallyImplyLeading', automaticallyImplyLeading),
			automaticallyImplyMiddle: automaticallyImplyMiddle,
			previousPageTitle: previousPageTitle,
			middle: _title,
			trailing: _trailing,
			border: border,
			backgroundColor: _backgroundColor,
			padding: padding,
			actionsForegroundColor: _actionsForegroundColor,
			transitionBetweenRoutes: transitionBetweenRoutes,
			heroTag: heroTag,

			backdropFilter: _backdropFilter,
      navBarPersistentHeight: valueFromCupertino('height', height),
      bottom: valueFromCupertino('bottom', bottom),
      bottomOpacity: valueFromCupertino('bottomOpacity', bottomOpacity),
      toolbarOpacity: _toolbarOpacity,
      autoSetLeadingColor: autoSetLeadingColor,
      autoSetMiddleColor: autoSetMiddleColor,
      autoSetTrailingColor: autoSetTrailingColor,
		) : CupertinoNavigationBar(
			key: key,
			leading: _leading,
			automaticallyImplyLeading: valueFromCupertino('automaticallyImplyLeading', automaticallyImplyLeading),
			automaticallyImplyMiddle: automaticallyImplyMiddle,
			previousPageTitle: previousPageTitle,
			middle: _title,
			trailing: _trailing,
			border: border,
			backgroundColor: _backgroundColor,
			padding: padding,
			actionsForegroundColor: _actionsForegroundColor,
			transitionBetweenRoutes: transitionBetweenRoutes,

			backdropFilter: _backdropFilter,
      navBarPersistentHeight: valueFromCupertino('height', height),
      bottom: valueFromCupertino('bottom', bottom),
      bottomOpacity: valueFromCupertino('bottomOpacity', bottomOpacity),
      toolbarOpacity: _toolbarOpacity,
      autoSetLeadingColor: autoSetLeadingColor,
      autoSetMiddleColor: autoSetMiddleColor,
      autoSetTrailingColor: autoSetTrailingColor,
		);
		return child;
	}

	@override
  Widget buildByMaterial(BuildContext context) {
		Widget _title = valueFromMaterial('title', title) ?? valueFromMaterial('middle', middle);
		// actions为null，且trailing不为nul,，取trailing = [ trailing ];
		List<Widget> _actions = valueFromMaterial('actions', actions);
		Widget _trailing = valueFromMaterial('trailing', trailing);
		if (_actions == null && _trailing != null) {
			_actions = [ _trailing ];
		}
		Color _backgroundColor = valueFromMaterial('backgroundColor', backgroundColor) 
      ?? Theme.of(context).appBarTheme.color
      ?? Theme.of(context).primaryColor;

    return AppBar(
      key: key,
      leading: valueFromMaterial('leading', leading),
      automaticallyImplyLeading: valueFromMaterial('automaticallyImplyLeading', automaticallyImplyLeading),
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
      toolbarHeight: valueFromMaterial('height', height) ?? kToolbarHeight,
    );
  }

  @override
  bool get fullObstruction => backgroundColor == null ? null : backgroundColor.alpha == 0xFF;

  @override
  Size get preferredSize {
    double _height = height != null ? height: (useCupertino ? 44.0 : kToolbarHeight);
    _height += bottom != null ? bottom.preferredSize.height : 0;
    return Size.fromHeight(_height);
  }

}