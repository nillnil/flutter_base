import 'package:flutter/widgets.dart' show BottomNavigationBarItem, BuildContext, Color, Widget;

import '../base_class.dart';

@Deprecated('已废弃，使用原生的BottomNavigationBarItem，需要个性化的自行自定义')

/// BaseBarItem
/// use BottomNavigationBarItem by cupertino
/// *** use cupertino = { forceUseMaterial: true } force use BottomNavigationBarItem on cuperitno.
/// use BottomNavigationBarItem by material
/// *** use material = { forceUseCupertino: true } force use BottomNavigationBarItem on material.
///
/// BottomNavigationBarItem: 2021.03.31
/// modify 2021.06.25 by flutter 2.2.2
class BaseBarItem extends BaseClass {
  const BaseBarItem({
    this.icon,
    this.label,
    this.activeIcon,
    this.backgroundColor,
    this.tooltip,
    Map<String, dynamic>? cupertino,
    Map<String, dynamic>? material,
  }) : super(cupertino: cupertino, material: material);

  /// *** general properties start ***

  /// [BottomNavigationBarItem.icon]
  /// can be null, when is null, default will add an indicator
  final Widget? icon;

  /// [BottomNavigationBarItem.activeIcon]
  final Widget? activeIcon;

  /// [BottomNavigationBarItem.label]
  final Widget? label;

  /// [BottomNavigationBarItem.backgroundColor]
  final Color? backgroundColor;

  /// [BottomNavigationBarItem.tooltip]
  final String? tooltip;

  /// *** material properties end ***

  @override
  Object buildByCupertino(BuildContext context) {
    return BottomNavigationBarItem(
      icon: valueFromCupertino('icon', icon),
      label: valueFromCupertino('label', label),
      activeIcon: valueFromCupertino('activeIcon', activeIcon),
      backgroundColor: valueFromCupertino('backgroundColor', backgroundColor),
      tooltip: valueFromCupertino('tooltip', tooltip),
    );
  }

  @override
  Object buildByMaterial(BuildContext context) {
    return BottomNavigationBarItem(
      icon: valueFromMaterial('icon', icon),
      label: valueFromMaterial('label', label),
      activeIcon: valueFromMaterial('activeIcon', activeIcon),
      backgroundColor: valueFromMaterial('backgroundColor', backgroundColor),
      tooltip: valueFromCupertino('tooltip', tooltip),
    );
  }
}
