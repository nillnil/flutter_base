import 'package:base/base_stateless_widget.dart';
import 'package:flutter/cupertino.dart' show CupertinoColors, CupertinoTabBar;
import 'package:flutter/material.dart';

import 'base_bar_item.dart';

/// BaseTabBar
/// use CupertinoTabBar by cupertino
/// *** not support cupertino = { forceUseMaterial: true }.
/// use BottomNavigationBar by material
/// *** not support material = { forceUseCupertino: true }.
class BaseTabBar extends BaseStatelessWidget {
  BaseTabBar({
    Key baseKey,
    this.key,
    this.items,
    this.onTap,
    this.currentIndex = 0,
    this.iconSize,
    this.backgroundColor = const Color(0xCCF8F8F8),
    this.activeColor = CupertinoColors.activeBlue,
    this.inactiveColor = CupertinoColors.inactiveGray,
    this.border = const Border(
      top: BorderSide(
        color: Color(0x4C000000),
        width: 0.0, // One physical pixel.
        style: BorderStyle.solid,
      ),
    ),
    this.elevation = 8.0,
    this.type,
    this.fixedColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.selectedFontSize = 14.0,
    this.unselectedFontSize = 12.0,
    this.showSelectedLabels = true,
    this.showUnselectedLabels,
    Map<String, dynamic> cupertino,
    Map<String, dynamic> material,
  }) : super(key: baseKey, cupertino: cupertino, material: material);

  // general
  @override
  final Key key;
  final List<BaseBarItem> items;
  final ValueChanged<int> onTap;
  final int currentIndex;
  final double iconSize;

  // cupertino
  final Color backgroundColor;
  final Color activeColor;
  final Color inactiveColor;
  final Border border;

  // material
  final double elevation;
  final BottomNavigationBarType type;
  final Color fixedColor;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final double selectedFontSize;
  final double unselectedFontSize;
  final bool showSelectedLabels;
  final bool showUnselectedLabels;

  @override
  Widget buildByCupertino(BuildContext context) {
    final List<BaseBarItem> items = valueFromCupertino('items', this.items);
    return CupertinoTabBar(
      key: valueFromCupertino('key', key),
      items: _buildBarItem(context, items),
      onTap: valueFromCupertino('onTap', onTap),
      currentIndex: valueFromCupertino('currentIndex', currentIndex),
      backgroundColor: valueFromCupertino('backgroundColor', backgroundColor),
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      iconSize: valueFromCupertino('iconSize', iconSize) ?? 30.0,
      border: valueFromCupertino('border', border),
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    final List<BaseBarItem> items = valueFromMaterial('items', this.items);
    return BottomNavigationBar(
      key: valueFromMaterial('key', key),
      items: _buildBarItem(context, items),
      onTap: valueFromMaterial('onTap', onTap),
      currentIndex: valueFromMaterial('currentIndex', currentIndex),
      elevation: elevation,
      type: type,
      fixedColor: fixedColor,
      iconSize: valueFromMaterial('iconSize', iconSize) ?? 24.0,
      selectedItemColor: selectedItemColor,
      unselectedItemColor: unselectedItemColor,
      selectedFontSize: selectedFontSize,
      unselectedFontSize: unselectedFontSize,
      showSelectedLabels: showSelectedLabels,
      showUnselectedLabels: showSelectedLabels,
    );
  }

  List<BottomNavigationBarItem> _buildBarItem(
      BuildContext context, List<BaseBarItem> items) {
    final List<BottomNavigationBarItem> barItems = <BottomNavigationBarItem>[];
    for (int i = 0; i < items.length; i++) {
      barItems.add(items[i].build(context));
    }
    return barItems;
  }
}
