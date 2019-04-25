import 'package:base/baritem/base_bar_item.dart';
import 'package:base/base_stateless_widget.dart';
import 'package:flutter/cupertino.dart' show CupertinoColors, CupertinoTabBar;
import 'package:flutter/material.dart'
    show
        Border,
        BorderSide,
        BorderStyle,
        BottomNavigationBar,
        BottomNavigationBarItem,
        BottomNavigationBarType,
        BuildContext,
        Color,
        Key,
        ValueChanged,
        Widget;
import 'package:flutter/widgets.dart';

/// BaseTabBar
/// use CupertinoTabBar by cupertino
/// *** use cupertino = { forceUseMaterial: true } force use BottomNavigationBar on cuperitno.
/// use BottomNavigationBar by material
/// *** use material = { forceUseCupertino: true } force use CupertinoTabBar on material.
class BaseTabBar extends BaseStatelessWidget {
  BaseTabBar({
    Key key,
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
    this.type,
    this.fixedColor,
    Map<String, dynamic> cupertino,
    Map<String, dynamic> material,
  }) : super(key: key, cupertino: cupertino, material: material);

  // general
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
  final BottomNavigationBarType type;
  final Color fixedColor;

  @override
  Widget buildByCupertino(BuildContext context) {
    final List<BaseBarItem> itemWidgets =
        valueFromCupertino('items', this.items);
    final List<BottomNavigationBarItem> items = <BottomNavigationBarItem>[];
    if (itemWidgets != null && itemWidgets.isNotEmpty) {
      for (BaseBarItem item in itemWidgets) {
        items.add(item.buildByCupertino(context));
      }
    }
    return CupertinoTabBar(
      key: valueFromCupertino('key', key),
      items: items,
      onTap: valueFromCupertino('onTap', onTap),
      currentIndex: valueFromCupertino('currentIndex', currentIndex),
      backgroundColor: valueFromCupertino('backgroundColor', backgroundColor),
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      iconSize: valueFromCupertino('iconSize', iconSize) ?? 30.0,
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    final List<BaseBarItem> itemWidgets =
        valueFromMaterial('items', this.items);
    final List<BottomNavigationBarItem> items = <BottomNavigationBarItem>[];
    if (itemWidgets != null && itemWidgets.isNotEmpty) {
      for (BaseBarItem item in itemWidgets) {
        items.add(item.buildByMaterial(context));
      }
    }
    return BottomNavigationBar(
      key: valueFromMaterial('key', key),
      items: items,
      onTap: valueFromMaterial('onTap', onTap),
      currentIndex: valueFromMaterial('currentIndex', currentIndex),
      type: type,
      fixedColor: fixedColor,
      iconSize: valueFromMaterial('iconSize', iconSize) ?? 24.0,
    );
  }
}
