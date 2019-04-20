import 'package:base/base_stateless_widget.dart';
import 'package:flutter/cupertino.dart' show CupertinoActivityIndicator;
import 'package:flutter/material.dart'
    show Animation, BuildContext, CircularProgressIndicator, Color, Key, Widget;

class BaseIndicator extends BaseStatelessWidget {
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
  }) : super(key: key, cupertino: cupertino, material: material);

  // cupertino
  final bool animating;
  final double radius;

  // material
  final double value;
  final Color backgroundColor;
  final Animation<Color> valueColor;
  final double strokeWidth;

  @override
  Widget buildByCupertino(BuildContext context) {
    return CupertinoActivityIndicator(
      animating: animating,
      radius: radius,
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    return CircularProgressIndicator(
      value: value,
      backgroundColor: backgroundColor,
      valueColor: valueColor,
      strokeWidth: strokeWidth,
    );
  }
}
