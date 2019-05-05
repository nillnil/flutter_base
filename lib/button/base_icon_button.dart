import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../base_stateless_widget.dart';

/// BaseIconButton
/// use CupertinoButton by cupertino
/// *** use cupertino = { forceUseMaterial: true } force use IconButton on cuperitno.
/// use IconButton by material
/// *** use material = { forceUseCupertino: true } force use CupertinoButton on material.
class BaseIconButton extends BaseStatelessWidget {
  BaseIconButton({
    Key baseKey,
    this.key,
    this.icon,
    this.color,
    this.disabledColor,
    this.padding = const EdgeInsets.all(8.0),
    this.onPressed,
    this.minSize = 24.0,
    this.pressedOpacity = 0.1,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.iconSize = 24.0,
    this.alignment = Alignment.center,
    this.highlightColor,
    this.splashColor,
    this.tooltip,
    Map<String, dynamic> cupertino,
    Map<String, dynamic> material,
  }) : super(key: baseKey, cupertino: cupertino, material: material);

  /// *** general properties start ***

  @override
  final Key key;

  /// [CupertinoButton.padding]
  /// or
  /// [IconButton.padding]
  final EdgeInsets padding;

  /// [CupertinoButton]
  /// or
  /// [IconButton.icon]
  final Widget icon;

  /// [CupertinoButton.color]
  /// or
  /// [IconButton.color]
  final Color color;

  /// [CupertinoButton.disabledColor]
  /// or
  /// [IconButton.disabledColor]
  final Color disabledColor;

  /// [CupertinoButton.onPressed]
  /// or
  /// [IconButton.onPressed]
  final VoidCallback onPressed;

  /// *** general properties end ***

  /// *** cupertino properties start ***

  /// [CupertinoButton.minSize]
  final double minSize;

  /// [CupertinoButton.pressedOpacity]
  final double pressedOpacity;

  /// [CupertinoButton.borderRadius]
  final BorderRadius borderRadius;

  /// *** cupertino properties end ***

  /// *** material properties start ***

  /// [IconButton.iconSize]
  final double iconSize;

  /// [IconButton.alignment]
  final Alignment alignment;

  /// [IconButton.highlightColor]
  final Color highlightColor;

  /// [IconButton.splashColor]
  final Color splashColor;

  /// [IconButton.tooltip]
  final String tooltip;

  /// *** material properties end ***

  @override
  Widget buildByCupertino(BuildContext context) {
    return CupertinoButton(
      key: valueFromCupertino('key', key),
      child: valueFromCupertino('icon', icon),
      padding: valueFromCupertino('padding', padding),
      color: valueFromCupertino('color', color),
      disabledColor: valueFromCupertino('disabledColor', disabledColor),
      minSize: minSize,
      pressedOpacity: pressedOpacity,
      borderRadius: borderRadius,
      onPressed: valueFromCupertino('onPressed', onPressed),
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    return IconButton(
      key: valueFromMaterial('key', key),
      iconSize: valueFromMaterial('iconSize', iconSize),
      padding: valueFromMaterial('padding', padding),
      alignment: valueFromMaterial('alignment', alignment),
      icon: valueFromMaterial('icon', icon),
      color: valueFromMaterial('color', color),
      highlightColor: valueFromMaterial('highlightColor', highlightColor),
      splashColor: valueFromMaterial('splashColor', splashColor),
      disabledColor: valueFromMaterial('disabledColor', disabledColor),
      onPressed: valueFromMaterial('onPressed', onPressed),
      tooltip: valueFromMaterial('tooltip', tooltip),
    );
  }
}
