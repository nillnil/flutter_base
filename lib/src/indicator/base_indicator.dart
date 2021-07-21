import 'package:flutter/cupertino.dart' show CupertinoActivityIndicator;
import 'package:flutter/material.dart' show Animation, BuildContext, CircularProgressIndicator, Color, Key, LinearProgressIndicator, Widget;

import '../base_param.dart';
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
    this.linearIndicator = false,
    BaseParam? baseParam,
  }) : super(key: key, baseParam: baseParam);

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
  final bool linearIndicator;

  /// *** material properties end ***

  @override
  Widget buildByCupertino(BuildContext context) {
    return CupertinoActivityIndicator(
      animating: valueOf('animating', animating),
      radius: valueOf('radius', radius),
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    final double? _value = valueOf('value', value);
    final Color? _backgroundColor = valueOf('backgroundColor', backgroundColor);
    final Color? _color = valueOf('color', color);
    final Animation<Color?>? _valueColor = valueOf('valueColor', valueColor);
    final String? _semanticsLabel = valueOf('semanticsLabel', semanticsLabel);
    final String? _semanticsValue = valueOf('semanticsValue', semanticsValue);
    if (linearIndicator) {
      return LinearProgressIndicator(
        value: _value,
        backgroundColor: _backgroundColor,
        color: _color,
        valueColor: _valueColor,
        minHeight: valueOf('minHeight', minHeight),
        semanticsLabel: _semanticsLabel,
        semanticsValue: _semanticsValue,
      );
    }
    return CircularProgressIndicator(
      value: _value,
      backgroundColor: _backgroundColor,
      color: _color,
      valueColor: _valueColor,
      strokeWidth: valueOf('strokeWidth', strokeWidth),
      semanticsLabel: _semanticsLabel,
      semanticsValue: _semanticsValue,
    );
  }
}
