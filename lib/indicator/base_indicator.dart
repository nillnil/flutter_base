import 'package:flutter/cupertino.dart' show CupertinoActivityIndicator;
import 'package:flutter/material.dart'
    show Animation, BuildContext, CircularProgressIndicator, Color, Key, Widget;

import '../base_stateless_widget.dart';

/// BaseIndicator
/// use CupertinoActivityIndicator by cupertino
/// *** use cupertino = { forceUseMaterial: true } force use CircularProgressIndicator on cuperitno.
/// use CircularProgressIndicator by material
/// *** use material = { forceUseCupertino: true } force use CupertinoActivityIndicator on material.
/// 
/// CupertinoActivityIndicator: 2020.08.13
/// CircularProgressIndicator: 2020.07.30
/// modify 2021.01.12 by flutter 1.22.5
class BaseIndicator extends BaseStatelessWidget {
  const BaseIndicator({
    Key key,
    this.animating = true,
    this.radius = 10.0,
    this.value,
    this.backgroundColor,
    this.valueColor,
    this.strokeWidth = 4.0,
    this.semanticsLabel,
    this.semanticsValue,
    Map<String, dynamic> cupertino,
    Map<String, dynamic> material,
  }) : super(key: key, cupertino: cupertino, material: material);

  /// *** cupertino properties start ***

  /// [CupertinoActivityIndicator.animating]
  final bool animating;

  /// [CupertinoActivityIndicator.radius]
  final double radius;

  /// *** cupertino properties end ***

  /// *** material properties start ***

  /// [CircularProgressIndicator.value]
  final double value;

  /// [CircularProgressIndicator.backgroundColor]
  final Color backgroundColor;

  /// [CircularProgressIndicator.valueColor]
  final Animation<Color> valueColor;

  /// [CircularProgressIndicator.strokeWidth]
  final double strokeWidth;

  /// [CircularProgressIndicator.semanticsLabel]
  final String semanticsLabel;

  /// [CircularProgressIndicator.semanticsValue]
  final String semanticsValue;

  /// *** material properties end ***

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
      semanticsLabel: semanticsLabel,
      semanticsValue: semanticsValue,
    );
  }
}
