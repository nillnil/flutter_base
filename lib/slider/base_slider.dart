import 'package:flutter/cupertino.dart' show CupertinoColors, CupertinoSlider;
import 'package:flutter/material.dart';

import '../base_stateless_widget.dart';

/// BaseSlider
/// cupertino，use CupertinoSlider
/// *** use cupertino = { forceUseMaterial: true } force use Slider
/// material，use Slider
/// *** use material = { forceUseCupertino: true } force use CupertinoSlider
class BaseSlider extends BaseStatelessWidget {
  const BaseSlider({
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
    this.thumbColor = CupertinoColors.white,
    this.label,
    this.inactiveColor,
    this.semanticFormatterCallback,
    Map<String, dynamic> cupertino,
    Map<String, dynamic> material,
  }) : super(key: baseKey, cupertino: cupertino, material: material);

  /// *** general properties end ***

  @override
  final Key key;

  /// [CupertinoSlider.value]
  /// or
  /// [Slider.value]
  final double value;

  /// [CupertinoSlider.onChanged]
  /// or
  /// [Slider.onChanged]
  final ValueChanged<double> onChanged;

  /// [CupertinoSlider.onChangeStart]
  /// or
  /// [Slider.onChangeStart]
  final ValueChanged<double> onChangeStart;

  /// [CupertinoSlider.onChangeEnd]
  /// or
  /// [Slider.onChangeEnd]
  final ValueChanged<double> onChangeEnd;

  /// [CupertinoSlider.min]
  /// or
  /// [Slider.min]
  final double min;

  /// [CupertinoSlider.max]
  /// or
  /// [Slider.max]
  final double max;

  /// [CupertinoSlider.divisions]
  /// or
  /// [Slider.divisions]
  final int divisions;

  /// [CupertinoSlider.activeColor]
  /// or
  /// [Slider.activeColor]
  final Color activeColor;

  /// *** general properties end ***

  /// *** cupertino properties start ***

  /// [CupertinoSlider.thumbColor]
  final Color thumbColor;

  /// *** cupertino properties end ***

  /// *** material properties start ***

  /// [Slider.label]
  final String label;

  /// [Slider.inactiveColor]
  final Color inactiveColor;

  /// [Slider.semanticFormatterCallback]
  final SemanticFormatterCallback semanticFormatterCallback;

  /// *** material properties end ***

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
      thumbColor: thumbColor,
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
