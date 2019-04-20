import 'package:base/base_stateless_widget.dart' show BaseStatelessWidget;
import 'package:flutter/cupertino.dart' show CupertinoButton, ShapeBorder;
import 'package:flutter/material.dart';

/// 基础按钮
/// cupertino，使用CupertinoButton
/// *** 可使用 cupertino = { forceUseMaterial: true } 参数强制使用MaterialButton
/// material，使用MaterialButton
/// *** 可使用 material = { forceUseCupertino: true } 参数强制使用CupertinoButton
class BaseButton extends BaseStatelessWidget {
  BaseButton({
    Key key,
    @required this.child,
    this.padding,
    this.color,
    this.disabledColor,
    @required this.onPressed,
    this.minSize = 44.0,
    this.pressedOpacity = 0.1,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.onHighlightChanged,
    this.textTheme,
    this.textColor,
    this.disabledTextColor,
    this.highlightColor,
    this.splashColor,
    this.colorBrightness,
    this.elevation,
    this.highlightElevation,
    this.disabledElevation,
    this.shape,
    this.clipBehavior = Clip.none,
    this.materialTapTargetSize,
    this.animationDuration,
    this.minWidth,
    this.height,
    Map<String, Object> cupertino,
    Map<String, Object> material,
  }) : super(key: key, cupertino: cupertino, material: material);

  // general
  final Color color;
  final VoidCallback onPressed;
  final Color disabledColor;
  final EdgeInsetsGeometry padding;
  final Widget child;

  // cupertino
  final double minSize;
  final double pressedOpacity;
  final BorderRadius borderRadius;

  // material
  final ValueChanged<bool> onHighlightChanged;
  final ButtonTextTheme textTheme;
  final Color textColor;
  final Color disabledTextColor;
  final Color highlightColor;
  final Color splashColor;
  final Brightness colorBrightness;
  final double elevation;
  final double highlightElevation;
  final double disabledElevation;
  final ShapeBorder shape;
  final Clip clipBehavior;
  final MaterialTapTargetSize materialTapTargetSize;
  final Duration animationDuration;
  final double minWidth;
  final double height;

  @override
  Widget buildByCupertino(BuildContext context) {
    return CupertinoButton(
      child: valueFromCupertino('child', child),
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
    return MaterialButton(
      onPressed: valueFromMaterial('onPressed', onPressed),
      onHighlightChanged: onHighlightChanged,
      textTheme: textTheme,
      textColor: textColor,
      disabledTextColor: disabledTextColor,
      color: valueFromMaterial('color', color),
      disabledColor: valueFromMaterial('disabledColor', disabledColor),
      highlightColor: highlightColor,
      splashColor: splashColor,
      colorBrightness: colorBrightness,
      elevation: elevation,
      highlightElevation: highlightElevation,
      disabledElevation: disabledElevation,
      padding: valueFromMaterial('padding', padding),
      shape: shape,
      clipBehavior: clipBehavior,
      materialTapTargetSize: materialTapTargetSize,
      animationDuration: animationDuration,
      minWidth: minWidth,
      height: height,
      child: valueFromMaterial('child', child),
    );
  }
}
