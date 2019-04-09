
import 'package:base/base_stateless_widget.dart';
import 'package:base/utils/bsae_utils.dart';
import 'package:base/flutter/flutter_modify.dart';
import 'package:flutter/cupertino.dart' show Container, CupertinoColors, CupertinoTheme, DefaultTextStyle, ObstructingPreferredSizeWidget, Size, StatelessWidget;
import 'package:flutter/material.dart' show Border, BorderSide, BorderStyle, Brightness, BuildContext, Color, Column, EdgeInsetsDirectional, IconThemeData, Key, NavigationToolbar, PreferredSizeWidget, TextTheme, Theme, Widget;
import 'package:flutter/services.dart';

/// 基础导航栏
/// cupertino，使用CupertinoNavigationBar
/// *** 可使用 cupertino = { forceUseMaterial: true } 参数强制使用AppBar
/// material，使用AppBar
/// *** 可使用 material = { forceUseCupertino: true } 参数强制使用CupertinoNavigationBar
class BaseNavBar extends BaseStatelessWidget {

	// general
	final Widget leading;
	final bool automaticallyImplyLeading;
	final bool automaticallyImplyMiddle;
	final Color backgroundColor;

	// cupertino
	final String previousPageTitle;
	final Widget middle;
	final Widget trailing;
	final Border border;
	final EdgeInsetsDirectional padding;
	final Color actionsForegroundColor;
	final bool transitionBetweenRoutes;
	final Object heroTag;

	// 标题跟随背景亮度自动改变黑白色, 默认true
	final bool middleColorAutoSet;
	// leading跟随背景亮度自动改变黑白色, 默认true，当为true时，actionsForegroundColor参数会失效
	final bool leadingColorAutoSet;
	// trailing跟随背景亮度自动改变黑白色, 默认true，当为true时，actionsForegroundColor参数会失效
	final bool trailingColorAutoSet;
	// bottom跟随背景亮度自动改变黑白色, 默认true
	final bool bottomColorAutoSet;

	final bool fullScreen;
	final double height;

  // 是否添加高斯模糊效果，默认true（即使背景色为透明的）
	final bool useBackdropFilter;

	// material
	final Widget title;
	final List<Widget> actions;
	final Widget flexibleSpace;
	final PreferredSizeWidget bottom;
	final double elevation;
	final Brightness brightness;
	final IconThemeData iconTheme;
	final TextTheme textTheme;
	final bool primary;
	final bool centerTitle;
	final double titleSpacing;
	final double toolbarOpacity;
	final double bottomOpacity;

	final Map<String, Object> cupertino;
	final Map<String, Object> material;

	// page里会用到这2个参数
	Color finalBackgroundColor;
	Widget finalTitle;
	Color titleTextColor;

	BaseNavBar({
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

		this.middleColorAutoSet = true,
		this.leadingColorAutoSet = true,
		this.trailingColorAutoSet = true,
		this.bottomColorAutoSet = true,
		this.fullScreen = false,

		this.height,
		this.useBackdropFilter = true,

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
		this.cupertino,
		this.material
	}) : super(key: key, cupertino: cupertino, material: material);

	BaseNavBar copyWith({
		PreferredSizeWidget bottom,
		Widget middle,
		Widget title,
	}) {
		return BaseNavBar(
			key: key,
			leading: leading,
			trailing: trailing,
			automaticallyImplyLeading: automaticallyImplyLeading,
			automaticallyImplyMiddle: automaticallyImplyMiddle,
			backgroundColor: backgroundColor,
			previousPageTitle: previousPageTitle,
			middle: middle ?? this.middle,
			border: border,
			padding: padding,
			actionsForegroundColor: actionsForegroundColor,
			transitionBetweenRoutes: transitionBetweenRoutes,
			heroTag: heroTag,
			middleColorAutoSet: middleColorAutoSet,
			leadingColorAutoSet: leadingColorAutoSet,
			trailingColorAutoSet: trailingColorAutoSet,
			bottomColorAutoSet: bottomColorAutoSet,
			fullScreen: fullScreen,
			height: height,
			useBackdropFilter: useBackdropFilter,
			title: title ?? this.title,
			actions: actions,
			flexibleSpace: flexibleSpace,
			bottom: bottom ?? this.bottom,
			elevation: elevation,
			brightness: brightness,
			iconTheme: iconTheme,
			textTheme: textTheme,
			primary: primary,
			centerTitle: centerTitle,
			titleSpacing: titleSpacing,
			toolbarOpacity: toolbarOpacity,
			bottomOpacity: bottomOpacity,
			cupertino: cupertino,
			material: material
		);
	}

	@override
	void buildByCupertinoBefore(BuildContext context) {
    super.buildByCupertinoBefore(context);
		// 没有backgroundColor使用Theme里的primaryColor，还没有使用原生的
		finalBackgroundColor = valueFromCupertino('backgroundColor', backgroundColor)
			?? CupertinoTheme.of(context).barBackgroundColor
			?? Theme.of(context).primaryColor
			?? Color(0xCCF8F8F8);
		finalTitle = valueFromCupertino('middle', middle) ?? valueFromCupertino('title', title);
	}

	@override
	void buildByMaterialBefore(BuildContext context) {
    super.buildByMaterialBefore(context);
		finalBackgroundColor = valueFromMaterial('backgroundColor', backgroundColor) ?? Theme.of(context).primaryColor;
		finalTitle = valueFromMaterial('title', title) ?? valueFromMaterial('middle', middle);
  }

	@override
  Widget buildByCupertino(BuildContext context) {
		Widget _leading = valueFromCupertino('leading', leading);
		// trailing为null，且actions不为null，数量大于1，取trailing = adctions[0];
		Widget _trailing = valueFromCupertino('trailing', trailing);
		List<Widget> _actions = valueFromMaterial('actions', actions);
		Color _actionsForegroundColor = actionsForegroundColor;
		if (_actions != null && _actions.length > 0 && _trailing == null) {
			_trailing = _actions[0];
		}
		Brightness brightness = colorBrightness(finalBackgroundColor);
		if (brightness != null) {
			titleTextColor =
			isLight(finalBackgroundColor) ? CupertinoColors.black : CupertinoColors
				.white;
			// middle字体颜色随背景色亮度改变
			if (finalTitle != null) {
				finalTitle = DefaultTextStyle(
					style: DefaultTextStyle.of(context).style.copyWith(color: titleTextColor),
					child: finalTitle
				);
			}
			if (leadingColorAutoSet || trailingColorAutoSet) {
				_actionsForegroundColor = titleTextColor;
			}
			// leading字体颜色随背景色亮度改变
			if (_leading != null && leadingColorAutoSet) {
				_leading = DefaultTextStyle(
					style: DefaultTextStyle.of(context).style.copyWith(color: titleTextColor),
					child: _leading
				);
				_actionsForegroundColor = titleTextColor;
			}
			// trailing字体颜色随背景色亮度改变
			if (_trailing != null && trailingColorAutoSet) {
				_trailing = DefaultTextStyle(
					style: DefaultTextStyle.of(context).style.copyWith(color: titleTextColor),
					child: _trailing
				);
				_actionsForegroundColor = titleTextColor;
			}
		}
		bool fullObstruction = finalBackgroundColor.alpha == 0xFF;
		CupertinoNavigationBar child = heroTag != null ? CupertinoNavigationBar(
			key: key,
			leading: _leading,
			automaticallyImplyLeading: valueFromCupertino('automaticallyImplyLeading', automaticallyImplyLeading),
			automaticallyImplyMiddle: automaticallyImplyMiddle,
			previousPageTitle: previousPageTitle,
			middle: finalTitle,
			trailing: _trailing,
			border: border,
			backgroundColor: finalBackgroundColor,
			padding: padding,
			actionsForegroundColor: _actionsForegroundColor,
			transitionBetweenRoutes: transitionBetweenRoutes,
			heroTag: heroTag,

			useBackdropFilter: useBackdropFilter
		) : CupertinoNavigationBar(
			key: key,
			leading: _leading,
			automaticallyImplyLeading: valueFromCupertino('automaticallyImplyLeading', automaticallyImplyLeading),
			automaticallyImplyMiddle: automaticallyImplyMiddle,
			previousPageTitle: previousPageTitle,
			middle: finalTitle,
			trailing: _trailing,
			border: border,
			backgroundColor: finalBackgroundColor,
			padding: padding,
			actionsForegroundColor: _actionsForegroundColor,
			transitionBetweenRoutes: transitionBetweenRoutes,
			useBackdropFilter: useBackdropFilter
		);

		return fullScreen ? _CupertinoNavBar(
			child: child,
			backgroundColor: finalBackgroundColor,
		) : child;
	}

	@override
  Widget buildByMaterial(BuildContext context) {
		Widget _bottom = bottom;
		if (bottom != null) {
			if (finalTitle == null) {
				finalTitle = bottom;
				_bottom = null;
			}
		}
		// actions为null，且trailing不为nul,，取trailing = [ trailing ];
		List<Widget> _actions = valueFromMaterial('actions', actions);
		Widget _trailing = valueFromMaterial('trailing', trailing);
		if (_actions == null && _trailing != null) {
			_actions = [ _trailing ];
		}
		if (height != null) {
			return _MaterialAppBar(
				key: key,
				leading: leading,
				automaticallyImplyLeading: valueFromMaterial('automaticallyImplyLeading', automaticallyImplyLeading),
				title: finalTitle,
				actions: _actions,
				flexibleSpace: flexibleSpace,
				bottom: _bottom,
				elevation: elevation,
				backgroundColor: finalBackgroundColor,
				brightness: brightness,
				iconTheme: iconTheme,
				textTheme: textTheme,
				primary: primary,
				centerTitle: centerTitle,
				titleSpacing: titleSpacing,
				toolbarOpacity: toolbarOpacity,
				bottomOpacity: bottomOpacity,
				height: height,
			);
		} else {
			return AppBar(
				key: key,
				leading: leading,
				automaticallyImplyLeading: valueFromMaterial('automaticallyImplyLeading', automaticallyImplyLeading),
				title: finalTitle,
				actions: _actions,
				flexibleSpace: flexibleSpace,
				bottom: _bottom,
				elevation: elevation,
				backgroundColor: finalBackgroundColor,
				brightness: brightness,
				iconTheme: iconTheme,
				textTheme: textTheme,
				primary: primary,
				centerTitle: centerTitle,
				titleSpacing: titleSpacing,
				toolbarOpacity: toolbarOpacity,
				bottomOpacity: bottomOpacity
			);
		}
  }

}

class _CupertinoNavBar extends StatelessWidget implements ObstructingPreferredSizeWidget {

	final CupertinoNavigationBar child;
	final Color backgroundColor;

  _CupertinoNavBar({this.child, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Column(
			children: <Widget>[
				Container(
					height: 20,
					color: fullObstruction ? backgroundColor: backgroundColor.withAlpha(backgroundColor.alpha ~/ 2)
				),
				child
			]
		);
  }

	@override
	Size get preferredSize => Size(child.preferredSize.width, child.preferredSize.height + 20.0);

  @override
  bool get fullObstruction => backgroundColor.alpha == 0xFF;

}

/// 实现自定义appBar高度
class _MaterialAppBar extends AppBar {

	final Widget leading;
	final bool automaticallyImplyLeading;
	final bool automaticallyImplyMiddle;
	final Color backgroundColor;

	final Widget title;
	final List<Widget> actions;
	final Widget flexibleSpace;
	final PreferredSizeWidget bottom;
	final double elevation;
	final Brightness brightness;
	final IconThemeData iconTheme;
	final TextTheme textTheme;
	final bool primary;
	final bool centerTitle;
	final double titleSpacing;
	final double toolbarOpacity;
	final double bottomOpacity;
	final double height;

  _MaterialAppBar({
		Key key,
		this.leading,
		this.automaticallyImplyLeading = true,
		this.automaticallyImplyMiddle = true,
		this.backgroundColor,
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

		this.height
	}): preferredSize = Size.fromHeight(height + (bottom?.preferredSize?.height ?? 0.0));

	@override
	final Size preferredSize;

}
