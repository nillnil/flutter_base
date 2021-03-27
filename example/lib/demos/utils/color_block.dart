import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// 色块
class ColorBlock extends StatelessWidget {
  const ColorBlock({
    Key? key,
    this.margin = const EdgeInsets.only(right: 10.0, top: 3.0, bottom: 3.0),
    this.color = Colors.black,
    this.height = 16.0,
    this.width = 10.0,
  }) : super(key: key);

  final EdgeInsetsGeometry margin;
  final Color color;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      color: color,
      width: width,
      height: height,
    );
  }

  static ColorBlock material() {
    return const ColorBlock(
      margin: EdgeInsets.only(right: 10.0, top: 3.0, bottom: 3.0),
      color: Colors.pinkAccent,
      width: 10.0,
      height: 16.0,
    );
  }

  static ColorBlock cupertino() {
    return const ColorBlock(
      margin: EdgeInsets.only(right: 10.0, top: 3.0, bottom: 3.0),
      color: Colors.lightBlueAccent,
      width: 10.0,
      height: 16.0,
    );
  }

  static ColorBlock attributes() {
    return const ColorBlock(
      margin: EdgeInsets.only(right: 10.0, top: 3.0, bottom: 3.0),
      color: Colors.indigo,
      width: 10.0,
      height: 16.0,
    );
  }
}
