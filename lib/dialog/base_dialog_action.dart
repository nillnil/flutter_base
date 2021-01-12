import 'package:flutter/cupertino.dart' show CupertinoDialogAction;
import 'package:flutter/material.dart';

import '../base_stateless_widget.dart';

/// BaseDialogAction
/// use CupertinoDialogAction by cupertino
/// *** use cupertino = { forceUseMaterial: true } force use FlatButton on cuperitno.
/// use FlatButton by material
/// *** use material = { forceUseCupertino: true } force use CupertinoDialogAction on material.
/// 
/// CupertinoDialogAction: 2020.08.20
/// FlatButton: 2020.07.30
/// modify 2021.01.12 by flutter 1.22.5
class BaseDialogAction extends BaseStatelessWidget {
  const BaseDialogAction({
    Key baseKey,
    this.key,
    this.onPressed,
    this.isDefaultAction = false,
    this.isDestructiveAction = false,
    this.textStyle,
    this.child,
    this.onHighlightChanged,
    this.textTheme,
    this.textColor,
    this.disabledTextColor,
    this.color,
    this.disabledColor,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.colorBrightness,
    this.padding,
    this.visualDensity,
    this.shape,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    this.materialTapTargetSize,
    this.height,
    this.minWidth,
    Map<String, dynamic> cupertino,
    Map<String, dynamic> material,
  }) : super(key: baseKey, cupertino: cupertino, material: material);

  /// *** general properties start ***

  @override
  final Key key;

  /// [CupertinoDialogAction.onPressed]
  /// or
  /// [FlatButton.onPressed]
  final VoidCallback onPressed;

  /// [CupertinoDialogAction.onPressed]
  /// or
  /// [FlatButton.child]
  final Widget child;

  /// *** general properties end ***

  /// *** cupertino properties start ***

  /// [CupertinoDialogAction.isDefaultAction]
  final bool isDefaultAction;

  /// [CupertinoDialogAction.isDestructiveAction]
  final bool isDestructiveAction;

  /// [CupertinoDialogAction.textStyle]
  final TextStyle textStyle;

  /// *** cupertino properties end ***

  /// *** material properties start ***

  /// [FlatButton.onHighlightChanged]
  final ValueChanged<bool> onHighlightChanged;

  /// [FlatButton.textTheme]
  final ButtonTextTheme textTheme;

  /// [FlatButton.textColor]
  final Color textColor;

  /// [FlatButton.disabledTextColor]
  final Color disabledTextColor;

  /// [FlatButton.color]
  final Color color;

  /// [FlatButton.disabledColor]
  final Color disabledColor;

  /// [FlatButton.focusColor]
  final Color focusColor;

  /// [FlatButton.hoverColor]
  final Color hoverColor;

  /// [FlatButton.highlightColor]
  final Color highlightColor;

  /// [FlatButton.splashColor]
  final Color splashColor;

  /// [FlatButton.colorBrightness]
  final Brightness colorBrightness;

  /// [FlatButton.padding]
  final EdgeInsetsGeometry padding;

  /// [FlatButton.visualDensity]
  final VisualDensity visualDensity;

  /// [FlatButton.shape]
  final ShapeBorder shape;

  /// [FlatButton.clipBehavior]
  final Clip clipBehavior;

  /// [FlatButton.focusNode]
  final FocusNode focusNode;

  /// [FlatButton.autofocus]
  final bool autofocus;

  /// [FlatButton.materialTapTargetSize]
  final MaterialTapTargetSize materialTapTargetSize;

  /// [FlatButton.height]
  final double height;

  /// [FlatButton.minWidth]
  final double minWidth;

  /// *** material properties end ***

  @override
  Widget buildByCupertino(BuildContext context) {
    return CupertinoDialogAction(
      onPressed: valueFromCupertino('onPressed', onPressed),
      isDefaultAction: isDefaultAction,
      isDestructiveAction: isDestructiveAction,
      textStyle: textStyle,
      child: valueFromCupertino('child', child),
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    return FlatButton(
      key: valueFromMaterial('key', key),
      onPressed: valueFromMaterial('onPressed', onPressed),
      onHighlightChanged: onHighlightChanged,
      textTheme: textTheme,
      textColor: textColor,
      disabledTextColor: disabledTextColor,
      color: color,
      disabledColor: disabledColor,
      focusColor: focusColor,
      hoverColor: hoverColor,
      highlightColor: highlightColor,
      splashColor: splashColor,
      colorBrightness: colorBrightness,
      padding: padding,
      visualDensity: visualDensity,
      shape: shape,
      clipBehavior: clipBehavior,
      focusNode: focusNode,
      autofocus: autofocus,
      materialTapTargetSize: materialTapTargetSize,
      child: valueFromMaterial('child', child),
      height: height,
      minWidth: minWidth,
    );
  }
}
