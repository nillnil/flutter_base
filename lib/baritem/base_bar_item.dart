import 'package:flutter/widgets.dart'
    show BottomNavigationBarItem, BuildContext, Color, Widget;
import 'package:base/base_class.dart';

/// 基础baritem
/// cupertino，使用BottomNavigationBarItem
/// material，使用BottomNavigationBarItem
class BaseBarItem extends BaseClass {
  BaseBarItem({
    this.icon,
    this.title,
    this.activeIcon,
    this.backgroundColor,
    Map<String, Object> cupertino,
    Map<String, Object> material,
  }) : super(cupertino: cupertino, material: material);

  // general
  final Widget icon;
  final Widget activeIcon;
  final Widget title;
  final Color backgroundColor;

  @override
  Object buildByCupertino(BuildContext context) {
    return BottomNavigationBarItem(
      icon: valueFromCupertino('icon', icon),
      title: valueFromCupertino('title', title),
      activeIcon: valueFromCupertino('activeIcon', activeIcon),
      backgroundColor: valueFromCupertino('backgroundColor', backgroundColor),
    );
  }

  @override
  Object buildByMaterial(BuildContext context) {
    return BottomNavigationBarItem(
      icon: valueFromMaterial('icon', icon),
      title: valueFromMaterial('title', title),
      activeIcon: valueFromMaterial('activeIcon', activeIcon),
      backgroundColor: valueFromMaterial('backgroundColor', backgroundColor),
    );
  }
}
