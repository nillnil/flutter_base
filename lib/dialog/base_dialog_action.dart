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

  // general
  @override
  final Key key;
  final VoidCallback onPressed;
  final Widget child;

  // cupertino
  final bool isDefaultAction;
  final bool isDestructiveAction;
  final TextStyle textStyle;

  // material
  final ValueChanged<bool> onHighlightChanged;
  final ButtonTextTheme textTheme;
  final Color textColor;
  final Color disabledTextColor;
  final Color color;
  final Color disabledColor;
  final Color highlightColor;
  final Color splashColor;
  final Brightness colorBrightness;
  final EdgeInsetsGeometry padding;
  final ShapeBorder shape;
  final Clip clipBehavior;
  final MaterialTapTargetSize materialTapTargetSize;

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
