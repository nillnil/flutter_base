import 'package:flutter/cupertino.dart' show CupertinoSlider;
import 'package:flutter/material.dart';

import '../base_stateless_widget.dart';

/// BaseSlider
/// cupertino，use CupertinoSlider
/// *** use cupertino = { forceUseMaterial: true } force use Slider
/// material，use Slider
/// *** use material = { forceUseCupertino: true } force use CupertinoSlider
class BaseSlider extends BaseStatelessWidget {
  BaseSlider({
    Key baseKey,
    this.key,
    this.value,
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.activeColor,
    this.label,
    this.inactiveColor,
    this.semanticFormatterCallback,
    Map<String, dynamic> cupertino,
    Map<String, dynamic> material,
  }) : super(key: baseKey, cupertino: cupertino, material: material);

  // general
  @override
  final Key key;
  final double value;
  final ValueChanged<double> onChanged;
  final ValueChanged<double> onChangeStart;
  final ValueChanged<double> onChangeEnd;
  final double min;
  final double max;
  final int divisions;
  final Color activeColor;

  // material
  final String label;
  final Color inactiveColor;
  final SemanticFormatterCallback semanticFormatterCallback;

  @override
  Widget buildByCupertino(BuildContext context) {
    return CupertinoSlider(
      key: valueFromCupertino('key', key),
      value: valueFromCupertino('value', value),
      onChanged: valueFromCupertino('onChanged', onChanged),
      onChangeStart: valueFromCupertino('onChangeStart', onChangeStart),
      onChangeEnd: valueFromCupertino('onChangeEnd', onChangeEnd),
      min: valueFromCupertino('min', min),
      max: valueFromCupertino('max', max),
      divisions: valueFromCupertino('divisions', divisions),
      activeColor: valueFromCupertino('activeColor', activeColor),
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    return Slider(
      key: valueFromMaterial('key', key),
      value: valueFromMaterial('value', value),
      onChanged: valueFromMaterial('onChanged', onChanged),
      onChangeStart: valueFromMaterial('onChangeStart', onChangeStart),
      onChangeEnd: valueFromMaterial('onChangeEnd', onChangeEnd),
      min: valueFromMaterial('min', min),
      max: valueFromMaterial('max', max),
      divisions: valueFromMaterial('divisions', divisions),
      label: valueFromMaterial('label', label),
      activeColor: valueFromMaterial('activeColor', activeColor),
      inactiveColor: inactiveColor,
      semanticFormatterCallback: semanticFormatterCallback,
    );
  }
}
