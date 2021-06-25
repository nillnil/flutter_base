import 'package:flutter/cupertino.dart' show CupertinoColors, CupertinoSlider;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../base_stateless_widget.dart';

/// BaseSlider
/// cupertino，use CupertinoSlider
/// *** use cupertino = { forceUseMaterial: true } force use Slider
/// material，use Slider
/// *** use material = { forceUseCupertino: true } force use CupertinoSlider
///
/// CupertinoSlider: 2021.03.27
/// Slider: 2021.03.31
/// modify 2021.05.25 by flutter 2.2.2
class BaseSlider extends BaseStatelessWidget {
  const BaseSlider({
    Key? key,
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
    this.mouseCursor,
    this.focusNode,
    this.autofocus = false,
    this.semanticFormatterCallback,
    Map<String, dynamic>? cupertino,
    Map<String, dynamic>? material,
  }) : super(key: key, cupertino: cupertino, material: material);

  /// *** general properties end ***

  /// [CupertinoSlider.value]
  /// or
  /// [Slider.value]
  final double? value;

  /// [CupertinoSlider.onChanged]
  /// or
  /// [Slider.onChanged]
  final ValueChanged<double>? onChanged;

  /// [CupertinoSlider.onChangeStart]
  /// or
  /// [Slider.onChangeStart]
  final ValueChanged<double>? onChangeStart;

  /// [CupertinoSlider.onChangeEnd]
  /// or
  /// [Slider.onChangeEnd]
  final ValueChanged<double>? onChangeEnd;

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
  final int? divisions;

  /// [CupertinoSlider.activeColor]
  /// or
  /// [Slider.activeColor]
  final Color? activeColor;

  /// *** general properties end ***

  /// *** cupertino properties start ***

  /// [CupertinoSlider.thumbColor]
  final Color thumbColor;

  /// *** cupertino properties end ***

  /// *** material properties start ***

  /// [Slider.label]
  final String? label;

  /// [Slider.inactiveColor]
  final Color? inactiveColor;

  /// [Slider.mouseCursor]
  final MouseCursor? mouseCursor;

  /// [Slider.focusNode]
  final FocusNode? focusNode;

  /// [Slider.autofocus]
  final bool autofocus;

  /// [Slider.semanticFormatterCallback]
  final SemanticFormatterCallback? semanticFormatterCallback;

  /// *** material properties end ***

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
      thumbColor: thumbColor,
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
      mouseCursor: mouseCursor,
      semanticFormatterCallback: semanticFormatterCallback,
      focusNode: focusNode,
      autofocus: autofocus,
    );
  }
}
