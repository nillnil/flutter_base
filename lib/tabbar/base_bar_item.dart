import 'package:flutter/widgets.dart'
    show BuildContext, Color, Widget
    hide BottomNavigationBarItem;

import '../base_class.dart';
import '../flutter/widgets/bottom_navigation_bar_item.dart';

/// BaseBarItem
/// use BottomNavigationBarItem by cupertino
/// *** use cupertino = { forceUseMaterial: true } force use BottomNavigationBarItem on cuperitno.
/// use BottomNavigationBarItem by material
/// *** use material = { forceUseCupertino: true } force use BottomNavigationBarItem on material.
class BaseBarItem extends BaseClass {
  BaseBarItem({
    this.icon,
    this.title,
    this.activeIcon,
    this.backgroundColor,
    Map<String, dynamic> cupertino,
    Map<String, dynamic> material,
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
