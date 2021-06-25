import 'package:flutter/cupertino.dart' show CupertinoColors, CupertinoDynamicColor;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show MouseCursor;

import '../base_stateless_widget.dart';
import '../flutter/cupertino/bottom_tab_bar.dart';

/// BaseTabBar
/// use CupertinoTabBar by cupertino
/// *** not support cupertino = { forceUseMaterial: true }.
/// use BottomNavigationBar by material
/// *** not support material = { forceUseCupertino: true }.
///
/// CupertinoTabBar: 2020.11.03
/// BottomNavigationBar: 2021.04.02
/// modify 2021.06.25 by flutter 2.2.2
class BaseTabBar extends BaseStatelessWidget {
  const BaseTabBar({
    Key? key,
    this.items,
    this.onTap,
    this.currentIndex = 0,
    this.iconSize,
    this.backgroundColor,
    this.showIndicator = true,
    this.activeColor,
    this.inactiveColor = CupertinoColors.inactiveGray,
    this.border = const Border(
      top: BorderSide(
        color: _kDefaultTabBarBorderColor,
        width: 0.0, // One physical pixel.
        style: BorderStyle.solid,
      ),
    ),
    this.elevation = 8.0,
    this.type,
    this.fixedColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.selectedIconTheme = const IconThemeData(),
    this.unselectedIconTheme = const IconThemeData(),
    this.selectedFontSize = 14.0,
    this.unselectedFontSize = 12.0,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    this.showSelectedLabels = true,
    this.showUnselectedLabels,
    this.mouseCursor,
    this.enableFeedback,
    Map<String, dynamic>? cupertino,
    Map<String, dynamic>? material,
  }) : super(key: key, cupertino: cupertino, material: material);

  /// *** general properties start ***

  /// See also:
  ///   * [CupertinoTabBar.items]
  ///   * [BottomNavigationBar.items]
  final List<BottomNavigationBarItem>? items;

  /// [CupertinoTabBar.onTap]
  /// or
  /// [BottomNavigationBar.onTap]
  final ValueChanged<int>? onTap;

  /// [CupertinoTabBar.currentIndex]
  /// or
  /// [BottomNavigationBar.currentIndex]
  final int currentIndex;

  /// [CupertinoTabBar.iconSize]
  /// or
  /// [BottomNavigationBar.iconSize]
  final double? iconSize;

  /// [CupertinoTabBar.backgroundColor]
  /// or
  /// [BottomNavigationBar.backgroundColor]
  final Color? backgroundColor;

  /// when [icon is null], then will add an indicator
  // 显示指示器，当icon为null时，默认会添加一个指示器
  @Deprecated('已删除该字段，需要的请自定义')
  final bool showIndicator;

  /// *** general properties end ***

  /// *** cupertino properties start ***

  /// [CupertinoTabBar.activeColor]
  final Color? activeColor;

  /// [CupertinoTabBar.inactiveColor]
  final Color inactiveColor;

  /// [CupertinoTabBar.border]
  final Border? border;

  /// *** cupertino properties end ***

  /// *** material properties start ***

  /// [BottomNavigationBar.elevation]
  final double? elevation;

  /// [BottomNavigationBar.type]
  final BottomNavigationBarType? type;

  /// [BottomNavigationBar.fixedColor]
  final Color? fixedColor;

  /// [BottomNavigationBar.selectedItemColor]
  final Color? selectedItemColor;

  /// [BottomNavigationBar.unselectedItemColor]
  final Color? unselectedItemColor;

  /// [BottomNavigationBar.selectedIconTheme]
  final IconThemeData? selectedIconTheme;

  /// [BottomNavigationBar.unselectedIconTheme]
  final IconThemeData? unselectedIconTheme;

  /// [BottomNavigationBar.selectedFontSize]
  final double selectedFontSize;

  /// [BottomNavigationBar.unselectedFontSize]
  final double unselectedFontSize;

  /// [BottomNavigationBar.selectedLabelStyle]
  final TextStyle? selectedLabelStyle;

  /// [BottomNavigationBar.unselectedLabelStyle]
  final TextStyle? unselectedLabelStyle;

  /// [BottomNavigationBar.showSelectedLabels]
  final bool? showSelectedLabels;

  /// [BottomNavigationBar.showUnselectedLabels]
  final bool? showUnselectedLabels;

  /// [BottomNavigationBar.mouseCursor]
  final MouseCursor? mouseCursor;

  /// [BottomNavigationBar.enableFeedback]
  final bool? enableFeedback;

  /// *** material properties end ***

  /// 用户BaseTabScaffold里构建bottomNavigationBar
  BaseTabBar copyWith({
    ValueChanged<int>? onTap,
    required int currentIndex,
  }) {
    return BaseTabBar(
      items: items,
      onTap: onTap ?? this.onTap,
      currentIndex: currentIndex,
      iconSize: iconSize,
      backgroundColor: backgroundColor,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      border: border,
      elevation: elevation,
      type: type,
      fixedColor: fixedColor,
      selectedItemColor: selectedItemColor,
      unselectedItemColor: unselectedItemColor,
      selectedIconTheme: selectedIconTheme,
      unselectedIconTheme: unselectedIconTheme,
      selectedFontSize: selectedFontSize,
      unselectedFontSize: unselectedFontSize,
      selectedLabelStyle: selectedLabelStyle,
      unselectedLabelStyle: unselectedLabelStyle,
      showSelectedLabels: showSelectedLabels,
      showUnselectedLabels: showUnselectedLabels,
      mouseCursor: mouseCursor,
    );
  }

  @override
  Widget buildByCupertino(BuildContext context) {
    return CupertinoTabBar(
      items: valueFromCupertino('items', items),
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
    return BottomNavigationBar(
      items: valueFromMaterial('items', items),
      onTap: valueFromMaterial('onTap', onTap),
      currentIndex: valueFromMaterial('currentIndex', currentIndex) ?? 0,
      elevation: elevation,
      type: type,
      fixedColor: fixedColor,
      backgroundColor: valueFromMaterial('backgroundColor', backgroundColor),
      iconSize: valueFromMaterial('iconSize', iconSize) ?? 24.0,
      selectedItemColor: selectedItemColor,
      unselectedItemColor: unselectedItemColor,
      selectedIconTheme: selectedIconTheme,
      unselectedIconTheme: unselectedIconTheme,
      selectedFontSize: selectedFontSize,
      unselectedFontSize: unselectedFontSize,
      selectedLabelStyle: selectedLabelStyle,
      unselectedLabelStyle: unselectedLabelStyle,
      showSelectedLabels: showSelectedLabels,
      showUnselectedLabels: showSelectedLabels,
      mouseCursor: mouseCursor,
      enableFeedback: enableFeedback,
    );
  }

  // @Deprecated('已废弃')
  // List<BottomNavigationBarItem> _buildBarItem(
  //   BuildContext context,
  //   List<BaseBarItem> items,
  // ) {
  //   final List<BottomNavigationBarItem> barItems = <BottomNavigationBarItem>[];
  //   for (int i = 0; i < items.length; i++) {
  //     barItems.add(items[i].build(context));
  //   }
  //   return barItems;
  // }
}

const Color _kDefaultTabBarBorderColor = CupertinoDynamicColor.withBrightness(
  color: Color(0x4C000000),
  darkColor: Color(0x29000000),
);
