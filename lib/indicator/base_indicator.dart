import 'package:base/base_stateless_widget.dart';
import 'package:flutter/cupertino.dart' show CupertinoActivityIndicator;
import 'package:flutter/material.dart'
    show Animation, BuildContext, CircularProgressIndicator, Color, Key, Widget;

class BaseIndicator extends BaseStatelessWidget {
  // cupertino
  final bool animating;
  final double radius;

  // material
  final double value;
  final Color backgroundColor;
  final Animation<Color> valueColor;
  final double strokeWidth;

  BaseIndicator({
    Key key,
    this.animating = true,
    this.radius = 10.0,
    this.value,
    this.backgroundColor,
    this.valueColor,
    this.strokeWidth = 4.0,
    Map<String, Object> cupertino,
    Map<String, Object> material,
  }) : super(cupertino: cupertino, material: material);

  @override
  Widget buildByCupertino(BuildContext context) {
    return CupertinoActivityIndicator(
      key: key,
      animating: animating,
      radius: radius,
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    return CircularProgressIndicator(
      key: key,
      value: value,
      backgroundColor: backgroundColor,
      valueColor: valueColor,
      strokeWidth: strokeWidth,
    );
  }
}
