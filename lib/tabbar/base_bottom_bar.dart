import 'package:base/base_stateless_widget.dart';
import 'package:flutter/material.dart';

class BaseBottomBar extends BaseStatelessWidget {
  // general
  final List<Widget> tabs;

  // cupertino
  final Color backgroundColor;

  // material
  final TabController controller;
  final bool isScrollable;
  final Color indicatorColor;
  final double indicatorWeight;
  final EdgeInsetsGeometry indicatorPadding;
  final Decoration indicator;
  final TabBarIndicatorSize indicatorSize;
  final Color labelColor;
  final TextStyle labelStyle;
  final EdgeInsetsGeometry labelPadding;
  final Color unselectedLabelColor;
  final TextStyle unselectedLabelStyle;

  BaseBottomBar({
    Key key,
    this.backgroundColor = Colors.white,
    this.tabs,
    this.controller,
    this.isScrollable = false,
    this.indicatorColor,
    this.indicatorWeight = 2.0,
    this.indicatorPadding = EdgeInsets.zero,
    this.indicator,
    this.indicatorSize,
    this.labelColor,
    this.labelStyle,
    this.labelPadding,
    this.unselectedLabelColor,
    this.unselectedLabelStyle,
    Map<String, Object> cupertino,
    Map<String, Object> material,
  }) : super(cupertino: cupertino, material: material);

  static const EdgeInsets kTabLabelPadding =
      EdgeInsets.symmetric(horizontal: 16.0);

  /// 自定义
  @override
  Widget buildByCupertino(BuildContext context) {
    return Container(
      width: 1000.0,
      height: 50.0,
      color: backgroundColor,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: tabs,
      ),
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    return TabBar(
      key: key,
      tabs: tabs,
      controller: controller,
      isScrollable: isScrollable,
      indicatorColor: indicatorColor,
      indicatorWeight: indicatorWeight,
      indicatorPadding: indicatorPadding,
      indicator: indicator,
      indicatorSize: indicatorSize,
      labelColor: labelColor,
      labelStyle: labelStyle,
      labelPadding: labelPadding,
      unselectedLabelColor: unselectedLabelColor,
      unselectedLabelStyle: unselectedLabelStyle,
    );
  }
}
