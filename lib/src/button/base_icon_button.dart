import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show MouseCursor, SystemMouseCursors;

import '../base_stateless_widget.dart';

/// BaseIconButton
/// use CupertinoButton by cupertino
/// *** use cupertino = { forceUseMaterial: true } force use IconButton on cuperitno.
/// use IconButton by material
/// *** use material = { forceUseCupertino: true } force use CupertinoButton on material.
///
/// CupertinoButton: 2021.01.14
/// IconButton: 2021.03.12
/// modify 2021.06.25 by flutter 2.2.2
class BaseIconButton extends BaseStatelessWidget {
  const BaseIconButton({
    Key? key,
    this.icon,
    this.color,
    this.disabledColor,
    this.padding = const EdgeInsets.all(8.0),
    this.onPressed,
    this.minSize = kMinInteractiveDimensionCupertino,
    this.pressedOpacity = 0.4,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.iconSize = 24.0,
    this.visualDensity,
    this.splashRadius,
    this.alignment = Alignment.center,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.focusNode,
    this.mouseCursor = SystemMouseCursors.click,
    this.autofocus = false,
    this.tooltip,
    this.enableFeedback = true,
    this.constraints,
    Map<String, dynamic>? cupertino,
    Map<String, dynamic>? material,
  }) : super(key: key, cupertino: cupertino, material: material);

  /// *** general properties start ***

  /// [CupertinoButton.padding]
  /// or
  /// [IconButton.padding]
  final EdgeInsetsGeometry? padding;

  /// [IconData]
  final IconData? icon;

  /// [CupertinoButton.color]
  /// or
  /// [IconButton.color]
  final Color? color;

  /// [CupertinoButton.disabledColor]
  /// or
  /// [IconButton.disabledColor]
  final Color? disabledColor;

  /// [CupertinoButton.onPressed]
  /// or
  /// [IconButton.onPressed]
  final VoidCallback? onPressed;

  /// [CupertinoButton.alignment]
  /// or
  /// [IconButton.alignment]
  final AlignmentGeometry alignment;

  /// *** general properties end ***

  /// *** cupertino properties start ***

  /// [CupertinoButton.minSize]
  final double? minSize;

  /// [CupertinoButton.pressedOpacity]
  final double? pressedOpacity;

  /// [CupertinoButton.borderRadius]
  final BorderRadius? borderRadius;

  /// *** cupertino properties end ***

  /// *** material properties start ***

  /// [IconButton.iconSize]
  final double iconSize;

  /// [IconButton.visualDensity]
  final VisualDensity? visualDensity;

  /// [IconButton.splashRadius]
  final double? splashRadius;

  /// [IconButton.focusColor]
  final Color? focusColor;

  /// [IconButton.hoverColor]
  final Color? hoverColor;

  /// [IconButton.highlightColor]
  final Color? highlightColor;

  /// [IconButton.splashColor]
  final Color? splashColor;

  /// [IconButton.focusNode]
  final FocusNode? focusNode;

  /// [IconButton.mouseCursor]
  final MouseCursor mouseCursor;

  /// [IconButton.autofocus]
  final bool autofocus;

  /// [IconButton.tooltip]
  final String? tooltip;

  /// [IconButton.enableFeedback]
  final bool enableFeedback;

  /// [IconButton.constraints]
  final BoxConstraints? constraints;

  /// *** material properties end ***

  @override
  Widget buildByCupertino(BuildContext context) {
    final Color _disabledColor = valueFromCupertino('disabledColor', disabledColor) ?? CupertinoColors.quaternarySystemFill;
    return CupertinoButton(
      child: Icon(
        valueFromCupertino('icon', icon),
        size: valueFromCupertino('iconSize', iconSize),
        color: valueFromCupertino('color', color),
      ),
      padding: valueFromCupertino('padding', padding),
      disabledColor: _disabledColor,
      minSize: minSize,
      pressedOpacity: pressedOpacity,
      borderRadius: borderRadius,
      alignment: alignment,
      onPressed: valueFromCupertino('onPressed', onPressed),
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    return IconButton(
      iconSize: valueFromMaterial('iconSize', iconSize),
      visualDensity: visualDensity,
      padding: valueFromMaterial('padding', padding),
      alignment: valueFromMaterial('alignment', alignment),
      icon: Icon(valueFromMaterial('icon', icon)),
      splashRadius: splashRadius,
      color: valueFromMaterial('color', color),
      focusColor: focusColor,
      hoverColor: hoverColor,
      highlightColor: valueFromMaterial('highlightColor', highlightColor),
      splashColor: valueFromMaterial('splashColor', splashColor),
      disabledColor: valueFromMaterial('disabledColor', disabledColor),
      onPressed: valueFromMaterial('onPressed', onPressed),
      mouseCursor: mouseCursor,
      focusNode: focusNode,
      autofocus: autofocus,
      tooltip: valueFromMaterial('tooltip', tooltip),
      enableFeedback: enableFeedback,
      constraints: constraints,
    );
  }
}
