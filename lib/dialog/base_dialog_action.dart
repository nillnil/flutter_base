import 'package:flutter/cupertino.dart' show CupertinoDialogAction;
import 'package:flutter/material.dart';

import '../base_stateless_widget.dart';

/// BaseDialogAction
/// use CupertinoDialogAction by cupertino
/// *** use cupertino = { forceUseMaterial: true } force use FlatButton on cuperitno.
/// use FlatButton by material
/// *** use material = { forceUseCupertino: true } force use CupertinoDialogAction on material.
class BaseDialogAction extends BaseStatelessWidget {
  BaseDialogAction({
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
    this.highlightColor,
    this.splashColor,
    this.colorBrightness,
    this.padding,
    this.shape,
    this.clipBehavior = Clip.none,
    this.materialTapTargetSize,
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

  /// [FlatButton.highlightColor]
  final Color highlightColor;

  /// [FlatButton.splashColor]
  final Color splashColor;

  /// [FlatButton.colorBrightness]
  final Brightness colorBrightness;

  /// [FlatButton.padding]
  final EdgeInsetsGeometry padding;

  /// [FlatButton.shape]
  final ShapeBorder shape;

  /// [FlatButton.clipBehavior]
  final Clip clipBehavior;

  /// [FlatButton.materialTapTargetSize]
  final MaterialTapTargetSize materialTapTargetSize;

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
      highlightColor: highlightColor,
      splashColor: splashColor,
      colorBrightness: colorBrightness,
      padding: padding,
      shape: shape,
      clipBehavior: clipBehavior,
      materialTapTargetSize: materialTapTargetSize,
      child: valueFromMaterial('child', child),
    );
  }
}
