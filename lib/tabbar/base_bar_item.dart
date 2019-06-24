import 'package:flutter/widgets.dart' show BuildContext, Color, Widget;

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

  /// *** general properties start ***

  /// [BottomNavigationBarItem.icon]
  /// can be null, when is null, default will add an indicator
  final Widget icon;

  /// [BottomNavigationBarItem.activeIcon]
  final Widget activeIcon;

  /// [BottomNavigationBarItem.title]
  final Widget title;

  /// [BottomNavigationBarItem.backgroundColor]
  final Color backgroundColor;

  /// *** material properties end ***

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
