import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show MouseCursor, SystemMouseCursors;

import '../base_param.dart';
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
    BaseParam? baseParam,
  }) : super(key: key, baseParam: baseParam);

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
    final Color _disabledColor = valueOf('disabledColor', disabledColor) ?? CupertinoColors.quaternarySystemFill;
    return CupertinoButton(
      child: Icon(
        valueOf('icon', icon),
        size: valueOf('iconSize', iconSize),
        color: valueOf('color', color),
      ),
      padding: valueOf('padding', padding),
      disabledColor: _disabledColor,
      minSize: valueOf('minSize', minSize),
      pressedOpacity: valueOf('pressedOpacity', pressedOpacity),
      borderRadius: valueOf('borderRadius', borderRadius),
      alignment: valueOf('alignment', alignment),
      onPressed: valueOf('onPressed', onPressed),
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    return IconButton(
      iconSize: valueOf('iconSize', iconSize),
      visualDensity: valueOf('visualDensity', visualDensity),
      padding: valueOf('padding', padding),
      alignment: valueOf('alignment', alignment),
      icon: Icon(valueOf('icon', icon)),
      splashRadius: valueOf('splashRadius', splashRadius),
      color: valueOf('color', color),
      focusColor: valueOf('focusColor', focusColor),
      hoverColor: valueOf('hoverColor', hoverColor),
      highlightColor: valueOf('highlightColor', highlightColor),
      splashColor: valueOf('splashColor', splashColor),
      disabledColor: valueOf('disabledColor', disabledColor),
      onPressed: valueOf('onPressed', onPressed),
      mouseCursor: valueOf('mouseCursor', mouseCursor),
      focusNode: valueOf('focusNode', focusNode),
      autofocus: valueOf('autofocus', autofocus),
      tooltip: valueOf('tooltip', tooltip),
      enableFeedback: valueOf('enableFeedback', enableFeedback),
      constraints: valueOf('constraints', constraints),
    );
  }
}
