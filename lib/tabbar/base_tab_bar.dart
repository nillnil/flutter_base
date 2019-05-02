import 'package:flutter/cupertino.dart'
    show CupertinoColors
    hide CupertinoTabBar, BottomNavigationBarItem;
import 'package:flutter/material.dart'
    hide BottomNavigationBarItem, BottomNavigationBar;

import '../base_stateless_widget.dart';
import '../flutter/cupertino/bottom_tab_bar.dart';
import '../flutter/material/bottom_navigation_bar.dart';
import '../flutter/widgets/bottom_navigation_bar_item.dart';
import 'base_bar_item.dart';

/// BaseTabBar
/// use CupertinoTabBar by cupertino
/// *** not support cupertino = { forceUseMaterial: true }.
/// use BottomNavigationBar by material
/// *** not support material = { forceUseCupertino: true }.
class BaseTabBar extends BaseStatelessWidget {
  BaseTabBar({
    this.key,
    this.items,
    this.onTap,
    this.currentIndex = 0,
    this.iconSize,
    this.backgroundColor,
    this.showIndicator = true,
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
  }) : super(cupertino: cupertino, material: material);

  // general
  @override
  final Key key;
  final List<BaseBarItem> items;
  final ValueChanged<int> onTap;
  final int currentIndex;
  final double iconSize;
  final Color backgroundColor;
  // 显示指示器，当icon为null时，默认会添加一个指示器
  final bool showIndicator;

  // cupertino
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

  /// 用户BaseTabScaffold里构建bottomNavigationBar
  BaseTabBar copyWith({
    ValueChanged<int> onTap,
    int currentIndex = 0,
  }) {
    return BaseTabBar(
      key: key,
      items: items,
      onTap: onTap ?? this.onTap,
      currentIndex: currentIndex ?? currentIndex,
      elevation: elevation,
      type: type,
      fixedColor: fixedColor,
      backgroundColor: backgroundColor,
      iconSize: iconSize,
      selectedItemColor: selectedItemColor,
      unselectedItemColor: unselectedItemColor,
      selectedFontSize: selectedFontSize,
      unselectedFontSize: unselectedFontSize,
      showSelectedLabels: showSelectedLabels,
      showUnselectedLabels: showSelectedLabels,
      showIndicator: showIndicator,
    );
  }

  @override
  Widget buildByCupertino(BuildContext context) {
    final List<BaseBarItem> items = valueFromCupertino('items', this.items);
    return CupertinoTabBar(
      key: valueFromCupertino('key', key),
      items: _buildBarItem(context, items),
      onTap: valueFromCupertino('onTap', onTap),
      currentIndex: valueFromCupertino('currentIndex', currentIndex),
      backgroundColor: valueFromCupertino('backgroundColor', backgroundColor) ??
          const Color(0xCCF8F8F8),
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      iconSize: valueFromCupertino('iconSize', iconSize) ?? 30.0,
      border: valueFromCupertino('border', border),
      showIndicator: valueFromCupertino('showIndicator', showIndicator),
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
      backgroundColor: valueFromMaterial('backgroundColor', backgroundColor),
      iconSize: valueFromMaterial('iconSize', iconSize) ?? 24.0,
      selectedItemColor: selectedItemColor,
      unselectedItemColor: unselectedItemColor,
      selectedFontSize: selectedFontSize,
      unselectedFontSize: unselectedFontSize,
      showSelectedLabels: showSelectedLabels,
      showUnselectedLabels: showSelectedLabels,
      showIndicator: valueFromMaterial('showIndicator', showIndicator),
    );
  }

  List<BottomNavigationBarItem> _buildBarItem(
    BuildContext context,
    List<BaseBarItem> items,
  ) {
    final List<BottomNavigationBarItem> barItems = <BottomNavigationBarItem>[];
    for (int i = 0; i < items.length; i++) {
      barItems.add(items[i].build(context));
    }
    return barItems;
  }
}
