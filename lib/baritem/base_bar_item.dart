import 'package:flutter/widgets.dart' show BottomNavigationBarItem, BuildContext, Color, Widget;
import 'package:base/base_class.dart';

/// 基础baritem
/// cupertino，使用BottomNavigationBarItem
/// material，使用BottomNavigationBarItem
class BaseBarItem extends BaseClass{

	// general
	final Widget icon;
	final Widget activeIcon;
	final Widget title;
	final Color backgroundColor;

	// 个性化cupertino配置
	final Map<String, Object> cupertino;
	// 个性化material配置
	final Map<String, Object> material;

	BaseBarItem({
		this.icon,
		this.title,
		this.activeIcon,
		this.backgroundColor,

		this.cupertino,
		this.material
	}) : super(cupertino: cupertino, material: material);

	@override
	Object buildByCupertino(BuildContext context) {
		return BottomNavigationBarItem(
			icon: valueFromCupertino('icon', icon),
			title: valueFromCupertino('title', title),
			activeIcon: valueFromCupertino('activeIcon', activeIcon),
			backgroundColor: valueFromCupertino('backgroundColor', backgroundColor)
		);
	}

	@override
	Object buildByMaterial(BuildContext context) {
		return BottomNavigationBarItem(
			icon: valueFromMaterial('icon', icon),
			title: valueFromMaterial('title', title),
			activeIcon: valueFromMaterial('activeIcon', activeIcon),
			backgroundColor: valueFromMaterial('backgroundColor', backgroundColor)
		);
	}

}