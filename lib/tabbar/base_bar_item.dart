import 'package:flutter/widgets.dart' show BuildContext, Color, Widget, BottomNavigationBarItem;

import '../base_class.dart';

@Deprecated('已废弃，使用原生的BottomNavigationBarItem，需要个性化的自行自定义')
/// BaseBarItem
/// use BottomNavigationBarItem by cupertino
/// *** use cupertino = { forceUseMaterial: true } force use BottomNavigationBarItem on cuperitno.
/// use BottomNavigationBarItem by material
/// *** use material = { forceUseCupertino: true } force use BottomNavigationBarItem on material.
class BaseBarItem extends BaseClass {
  const BaseBarItem({
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
