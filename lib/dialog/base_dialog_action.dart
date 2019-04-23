import 'package:base/base_stateless_widget.dart';
import 'package:flutter/cupertino.dart' show CupertinoDialogAction;
import 'package:flutter/material.dart'
    show
        Brightness,
        BuildContext,
        ButtonTextTheme,
        Clip,
        Color,
        EdgeInsetsGeometry,
        FlatButton,
        Key,
        MaterialTapTargetSize,
        ShapeBorder,
        TextStyle,
        ValueChanged,
        VoidCallback,
        Widget;

/// BaseDialogAction
/// use CupertinoDialogAction by cupertino
/// *** use cupertino = { forceUseMaterial: true } force use FlatButton on cuperitno.
/// use FlatButton by material
/// *** use material = { forceUseCupertino: true } force use CupertinoDialogAction on material.
class BaseDialogAction extends BaseStatelessWidget {
  BaseDialogAction({
    Key key,
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
    Map<String, Object> cupertino,
    Map<String, Object> material,
  }) : super(key: key, cupertino: cupertino, material: material);

  // general
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
