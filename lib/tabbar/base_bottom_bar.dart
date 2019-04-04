
import 'package:base/base_stateful_widget.dart';
import 'package:flutter/material.dart';

class BaseBottomBar extends BaseStatefulWidget {

	// cupertino
	final Color backgroundColor;
	
	// material
	final List<Widget> tabs;
	final TabController controller;
	final bool isScrollable;
	final Color indicatorColor;
	final double indicatorWeight;
	final EdgeInsetsGeometry indicatorPadding;
	final Decoration indicator;
	final TabBarIndicatorSize indicatorSize;
	final Color labelColor;
	final TextStyle labelStyle;
	final EdgeInsetsGeometry labelPadding;
	final Color unselectedLabelColor;
	final TextStyle unselectedLabelStyle;
	
	final Map<String, Object> cupertino;
	final Map<String, Object> material;

  BaseBottomBar({
		Key key,

		this.backgroundColor,

		this.tabs,
		this.controller,
		this.isScrollable = false,
		this.indicatorColor,
		this.indicatorWeight = 2.0,
		this.indicatorPadding = EdgeInsets.zero,
		this.indicator,
		this.indicatorSize,
		this.labelColor,
		this.labelStyle,
		this.labelPadding,
		this.unselectedLabelColor,
		this.unselectedLabelStyle,

		this.cupertino,
		this.material
	}) : super(key: key, cupertino: cupertino, material: material);
	
  @override
  _BaseBottomBarState createState() => _BaseBottomBarState();
  
}

class _BaseBottomBarState extends BaseState<BaseBottomBar> {

	static const EdgeInsets kTabLabelPadding = EdgeInsets.symmetric(horizontal: 16.0);

	/// 自定义
	@override
	Widget buildByCupertino(BuildContext context) {
		return Container(
			width: 1000.0,
			height: 50.0,
			color: widget.backgroundColor ?? Colors.blueAccent,
			child: ListView(
				scrollDirection: Axis.horizontal,
				children: widget.tabs
			)
		);
	}

	@override
	Widget buildByMaterial(BuildContext context) {
		return TabBar(
			key: widget.key,
			tabs: widget.tabs,
			controller: widget.controller,
			isScrollable: widget.isScrollable,
			indicatorColor: widget.indicatorColor,
			indicatorWeight: widget.indicatorWeight,
			indicatorPadding: widget.indicatorPadding,
			indicator: widget.indicator,
			indicatorSize: widget.indicatorSize,
			labelColor: widget.labelColor,
			labelStyle: widget.labelStyle,
			labelPadding: widget.labelPadding,
			unselectedLabelColor: widget.unselectedLabelColor,
			unselectedLabelStyle: widget.unselectedLabelStyle
		);
	}

	Decoration get _indicator {
		if (widget.indicator != null)
			return widget.indicator;
		final TabBarTheme tabBarTheme = TabBarTheme.of(context);
		if (tabBarTheme.indicator != null)
			return tabBarTheme.indicator;

		Color color = widget.indicatorColor ?? Theme
			.of(context)
			.indicatorColor;
		return UnderlineTabIndicator(
			insets: widget.indicatorPadding,
			borderSide: BorderSide(
				width: widget.indicatorWeight,
				color: color,
			),
		);
	}

	Widget _buildStyledTab(Widget child, bool selected, Animation<double> animation) {
		return _TabStyle(
			animation: animation,
			selected: selected,
			labelColor: widget.labelColor,
			unselectedLabelColor: widget.unselectedLabelColor,
			labelStyle: widget.labelStyle,
			unselectedLabelStyle: widget.unselectedLabelStyle,
			child: child,
		);
	}
	
}

class _TabStyle extends AnimatedWidget {
	const _TabStyle({
		Key key,
		Animation<double> animation,
		this.selected,
		this.labelColor,
		this.unselectedLabelColor,
		this.labelStyle,
		this.unselectedLabelStyle,
		@required this.child,
	}) : super(key: key, listenable: animation);

	final TextStyle labelStyle;
	final TextStyle unselectedLabelStyle;
	final bool selected;
	final Color labelColor;
	final Color unselectedLabelColor;
	final Widget child;

	@override
	Widget build(BuildContext context) {
		final ThemeData themeData = Theme.of(context);
		final TabBarTheme tabBarTheme = TabBarTheme.of(context);

		final TextStyle defaultStyle = labelStyle ?? themeData.primaryTextTheme.body2;
		final TextStyle defaultUnselectedStyle = unselectedLabelStyle ?? labelStyle ?? themeData.primaryTextTheme.body2;
		final Animation<double> animation = listenable;
		final TextStyle textStyle = selected
			? TextStyle.lerp(defaultStyle, defaultUnselectedStyle, animation.value)
			: TextStyle.lerp(defaultUnselectedStyle, defaultStyle, animation.value);
		final Color selectedColor =
			labelColor
				?? tabBarTheme.labelColor
				?? themeData.primaryTextTheme.body2.color;
		final Color unselectedColor =
			unselectedLabelColor
				?? tabBarTheme.unselectedLabelColor
				?? selectedColor.withAlpha(0xB2); // 70% alpha
		final Color color = selected
			? Color.lerp(selectedColor, unselectedColor, animation.value)
			: Color.lerp(unselectedColor, selectedColor, animation.value);

		return DefaultTextStyle(
			style: textStyle.copyWith(color: color),
			child: IconTheme.merge(
				data: IconThemeData(
					size: 24.0,
					color: color,
				),
				child: child,
			),
		);
	}
}
