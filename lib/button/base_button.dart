import 'package:flutter/cupertino.dart' show CupertinoButton, ShapeBorder;
import 'package:flutter/material.dart';

import '../base_stateless_widget.dart';

/// BaseButton
/// use CupertinoButton or CupertinoButton.filled by cupertino
/// *** use cupertino = { forceUseMaterial: true } force use MaterialButton or FlatButton or OutlineButton or RaisedButton on cuperitno.
/// use MaterialButton or FlatButton or OutlineButton or RaisedButton by material
/// *** use material = { forceUseCupertino: true } force use CupertinoButton or CupertinoButton.filled on material.
class BaseButton extends BaseStatelessWidget {
  BaseButton({
    Key baseKey,
    this.key,
    this.color,
    this.onPressed,
    this.disabledColor,
    this.padding,
    this.child,
    this.minSize = 44.0,
    this.pressedOpacity = 0.1,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.filled = false,
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

    /// 使按钮跟CupertinoButton的一样高，只有MaterialButton有效
    /// 其他的需修改Theme.of(context).buttonTheme.height才有效
    this.height = 48.0,
    this.flat = false,
    this.outline = false,
    this.borderSide,
    this.disabledBorderColor,
    this.highlightedBorderColor,
    this.raised = false,
    Map<String, Object> cupertino,
    Map<String, Object> material,
  }) : super(key: baseKey, cupertino: cupertino, material: material);

  BaseButton.icon({
    Key baseKey,
    this.key,
    this.color,
    this.onPressed,
    this.disabledColor,
    this.padding,
    this.minSize = 44.0,
    this.pressedOpacity = 0.1,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.filled = false,
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
    // 使按钮跟CupertinoButton的一样高
    this.height = 48.0,
    this.flat = false,
    this.outline = false,
    this.borderSide,
    this.disabledBorderColor,
    this.highlightedBorderColor,
    this.raised = false,

    /// use FlatButton.icon or OutlineButton.icon or RaisedButton.icon.
    /// if do not want to have label, use BaseIconButton.
    @required Widget icon,
    Widget label,
    double interval = 8.0,
    Map<String, dynamic> cupertino,
    Map<String, dynamic> material,
  })  : child = label != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  icon,
                  SizedBox(width: interval),
                  label,
                ],
              )
            : icon,
        super(key: baseKey, cupertino: cupertino, material: material);

  // general
  @override
  final Key key;
  final Color color;
  final VoidCallback onPressed;
  final Color disabledColor;
  final EdgeInsetsGeometry padding;
  final Widget child;

  // cupertino
  final double minSize;
  final double pressedOpacity;
  final BorderRadius borderRadius;

  /// use CupertinoButton.filled, will ignore the color, use primary color.
  final bool filled;

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

  /// use FlatButton
  final bool flat;

  /// use OutlineButton
  final bool outline;
  final BorderSide borderSide;
  final Color disabledBorderColor;
  final Color highlightedBorderColor;

  /// use RaisedButton
  final bool raised;

  @override
  Widget buildByCupertino(BuildContext context) {
    if (filled) {
      return CupertinoButton.filled(
        key: valueFromCupertino('key', key),
        child: valueFromCupertino('child', child),
        padding: valueFromCupertino('padding', padding),
        disabledColor: valueFromCupertino('disabledColor', disabledColor),
        minSize: minSize,
        pressedOpacity: pressedOpacity,
        borderRadius: borderRadius,
        onPressed: valueFromCupertino('onPressed', onPressed),
      );
    }
    return CupertinoButton(
      key: valueFromCupertino('key', key),
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
    assert(
      (!flat && !outline && !raised) ||
          (flat && !outline && !raised) ||
          (!flat && outline && !raised) ||
          (!flat && !outline && raised),
      'flat and outline can not be true at the same time.',
    );
    if (flat == true) {
      return FlatButton(
        key: valueFromMaterial('key', key),
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
        padding: valueFromMaterial('padding', padding),
        shape: shape,
        clipBehavior: clipBehavior,
        materialTapTargetSize: materialTapTargetSize,
        child: valueFromMaterial('child', child),
      );
    } else if (outline) {
      return OutlineButton(
        key: valueFromMaterial('key', key),
        onPressed: valueFromMaterial('onPressed', onPressed),
        textTheme: textTheme,
        textColor: textColor,
        disabledTextColor: disabledTextColor,
        color: valueFromMaterial('color', color),
        highlightColor: highlightColor,
        splashColor: splashColor,
        highlightElevation: highlightElevation,
        borderSide: borderSide,
        disabledBorderColor: disabledBorderColor,
        highlightedBorderColor: highlightedBorderColor,
        padding: valueFromMaterial('padding', padding),
        shape: shape,
        clipBehavior: clipBehavior,
        child: valueFromMaterial('child', child),
      );
    } else if (raised) {
      return RaisedButton(
        key: valueFromMaterial('key', key),
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
        child: valueFromMaterial('child', child),
      );
    }
    return MaterialButton(
      key: valueFromMaterial('key', key),
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
