import 'package:flutter/cupertino.dart' show CupertinoActivityIndicator;
import 'package:flutter/material.dart' show Animation, BuildContext, CircularProgressIndicator, Color, Key, LinearProgressIndicator, Widget;

import '../base_stateless_widget.dart';

/// BaseIndicator
/// use CupertinoActivityIndicator by cupertino
/// *** use cupertino = { forceUseMaterial: true } force use CircularProgressIndicator on cuperitno.
/// use CircularProgressIndicator by material
/// *** use material = { forceUseCupertino: true } force use CupertinoActivityIndicator on material.
///
/// CupertinoActivityIndicator: 2020.11.03
/// CircularProgressIndicator or LinearProgressIndicator: 2021.03.13
/// modify 2021.06.25 by flutter 2.2.2
class BaseIndicator extends BaseStatelessWidget {
  const BaseIndicator({
    Key? key,
    this.animating = true,
    this.radius = 10.0,
    this.value,
    this.backgroundColor,
    this.color,
    this.valueColor,
    this.strokeWidth = 4.0,
    this.minHeight,
    this.semanticsLabel,
    this.semanticsValue,
    this.linear = false,
    Map<String, dynamic>? cupertino,
    Map<String, dynamic>? material,
  }) : super(key: key, cupertino: cupertino, material: material);

  /// *** cupertino properties start ***

  /// [CupertinoActivityIndicator.animating]
  final bool animating;

  /// [CupertinoActivityIndicator.radius]
  final double radius;

  /// *** cupertino properties end ***

  /// *** material properties start ***

  /// [ProgressIndicator.value]
  final double? value;

  /// [ProgressIndicator.backgroundColor]
  final Color? backgroundColor;

  /// [ProgressIndicator.valueColor]
  final Animation<Color?>? valueColor;

  /// [ProgressIndicator.semanticsLabel]
  final String? semanticsLabel;

  /// [ProgressIndicator.semanticsValue]
  final String? semanticsValue;

  /// [LinearProgressIndicator.minHeight]
  final double? minHeight;

  /// [CircularProgressIndicator.strokeWidth]
  final double strokeWidth;

  /// [CircularProgressIndicator.color]
  final Color? color;

  /// if true use LinearProgressIndicator,
  /// if false use CircularProgressIndicator,
  /// default is false
  final bool linear;

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
    if (linear) {
      return LinearProgressIndicator(
        value: value,
        backgroundColor: backgroundColor,
        color: color,
        valueColor: valueColor,
        minHeight: minHeight,
        semanticsLabel: semanticsLabel,
        semanticsValue: semanticsValue,
      );
    }
    return CircularProgressIndicator(
      value: value,
      backgroundColor: backgroundColor,
      color: color,
      valueColor: valueColor,
      strokeWidth: strokeWidth,
      semanticsLabel: semanticsLabel,
      semanticsValue: semanticsValue,
    );
  }
}
