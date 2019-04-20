import 'package:base/base_stateless_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 基础页面
/// cupertino，单页面使用CupertinoSlider
/// *** 可使用 cupertino = { forceUseMaterial: true } 参数强制使用Slider
/// material，使用Slider
/// *** 可使用 material = { forceUseCupertino: true } 参数强制使用CupertinoSlider
class BaseSlider extends BaseStatelessWidget {
  BaseSlider({
    Key key,
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
    Map<String, Object> cupertino,
    Map<String, Object> material,
  }) : super(key: key, cupertino: cupertino, material: material);

  // general
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
