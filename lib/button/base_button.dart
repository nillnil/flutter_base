import 'package:flutter/cupertino.dart' show CupertinoButton, ShapeBorder, CupertinoColors;
import 'package:flutter/material.dart';

import '../base_stateless_widget.dart';

/// BaseButton
/// use CupertinoButton or CupertinoButton.filled by cupertino
/// *** use cupertino = { forceUseMaterial: true } force use MaterialButton or FlatButton or OutlineButton or RaisedButton on cuperitno.
/// use MaterialButton or FlatButton or OutlineButton or RaisedButton by material
/// *** use material = { forceUseCupertino: true } force use CupertinoButton or CupertinoButton.filled on material.
class BaseButton extends BaseStatelessWidget {
  const BaseButton({
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
    this.onLongPress,
    this.onHighlightChanged,
    this.textTheme,
    this.textColor,
    this.disabledTextColor,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.colorBrightness,
    this.elevation,
    this.focusElevation,
    this.highlightElevation,
    this.disabledElevation,
    this.visualDensity,
    this.shape,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
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

  /// [CupertinoButton], child is Row(children:[icon, label])
  /// or
  /// [MaterialButton], child is Row(children:[icon, label])
  /// or
  /// [FlatButton.icon]
  /// or
  /// [OutlineButton.icon]
  /// or
  /// [RaisedButton.icon]
  BaseButton.icon({
    Key baseKey,
    this.key,
    this.color,
    this.onPressed,
    this.disabledColor,
    this.padding,
    this.minSize = 44.0,
    this.pressedOpacity = 0.4,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.filled = false,
    this.onLongPress,
    this.onHighlightChanged,
    this.textTheme,
    this.textColor,
    this.disabledTextColor,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.colorBrightness,
    this.elevation,
    this.focusElevation,
    this.highlightElevation,
    this.disabledElevation,
    this.visualDensity,
    this.shape,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
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

  /// *** general properties start ***

  @override
  final Key key;

  /// [CupertinoButton.color]
  /// or
  /// [MaterialButton.color]
  final Color color;

  /// [CupertinoButton.onPressed]
  /// or
  /// [MaterialButton.onPressed]
  final VoidCallback onPressed;

  /// [CupertinoButton.disabledColor]
  /// or
  /// [MaterialButton.disabledColor]
  final Color disabledColor;

  /// [CupertinoButton.padding]
  /// or
  /// [MaterialButton.padding]
  final EdgeInsetsGeometry padding;

  /// [CupertinoButton.child]
  /// or
  /// [MaterialButton.child]
  final Widget child;

  /// *** general properties end ***

  /// *** cupertino properties start ***

  /// [CupertinoButton.minSize]
  final double minSize;

  /// [CupertinoButton.pressedOpacity]
  final double pressedOpacity;

  /// [CupertinoButton.borderRadius]
  final BorderRadius borderRadius;

  /// [CupertinoButton.filled]
  /// use CupertinoButton.filled, will ignore the color, use primary color.
  final bool filled;

  /// *** cupertino properties ened ***

  /// *** material properties start ***
  
  /// [MaterialButton.onLongPress]
  final VoidCallback onLongPress;

  /// [MaterialButton.onHighlightChanged]
  final ValueChanged<bool> onHighlightChanged;

  /// [MaterialButton.textTheme]
  final ButtonTextTheme textTheme;

  /// [MaterialButton.textColor]
  final Color textColor;

  /// [MaterialButton.disabledTextColor]
  final Color disabledTextColor;

  /// [MaterialButton.focusColor]
  final Color focusColor;

  /// [MaterialButton.hoverColor]
  final Color hoverColor;

  /// [MaterialButton.highlightColor]
  final Color highlightColor;

  /// [MaterialButton.splashColor]
  final Color splashColor;

  /// [MaterialButton.colorBrightness]
  final Brightness colorBrightness;

  /// [MaterialButton.elevation]
  final double elevation;

  /// [MaterialButton.focusElevation]
  final double focusElevation;

  /// [MaterialButton.highlightElevation]
  final double highlightElevation;

  /// [MaterialButton.disabledElevation]
  final double disabledElevation;

  /// [MaterialButton.visualDensity]
  final VisualDensity visualDensity;

  /// [MaterialButton.shape]
  final ShapeBorder shape;

  /// [MaterialButton.clipBehavior]
  final Clip clipBehavior;

  /// [MaterialButton.focusNode]
  final FocusNode focusNode;

  /// [MaterialButton.autofocus]
  final bool autofocus;

  /// [MaterialButton.materialTapTargetSize]
  final MaterialTapTargetSize materialTapTargetSize;

  /// [MaterialButton.animationDuration]
  final Duration animationDuration;

  /// [MaterialButton.minWidth]
  final double minWidth;

  /// [MaterialButton.height]
  final double height;

  /// [FlatButton]
  /// use FlatButton
  final bool flat;

  /// [OutlineButton]
  /// use OutlineButton
  final bool outline;

  /// [OutlineButton.borderSide]
  final BorderSide borderSide;

  /// [OutlineButton.disabledBorderColor]
  final Color disabledBorderColor;

  /// [OutlineButton.highlightedBorderColor]
  final Color highlightedBorderColor;

  /// [RaisedButton]
  /// use RaisedButton
  final bool raised;

  /// *** material properties end ***

  @override
  Widget buildByCupertino(BuildContext context) {
    final Color _disabledColor = valueFromCupertino('disabledColor', disabledColor) ?? CupertinoColors.quaternarySystemFill;
    if (filled) {
      return CupertinoButton.filled(
        key: valueFromCupertino('key', key),
        child: valueFromCupertino('child', child),
        padding: valueFromCupertino('padding', padding),
        disabledColor: _disabledColor,
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
      disabledColor: _disabledColor,
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
        onLongPress: onLongPress,
        onHighlightChanged: onHighlightChanged,
        textTheme: textTheme,
        textColor: textColor,
        disabledTextColor: disabledTextColor,
        color: valueFromMaterial('color', color),
        disabledColor: valueFromMaterial('disabledColor', disabledColor),
        focusColor: focusColor,
        hoverColor: hoverColor,
        highlightColor: highlightColor,
        splashColor: splashColor,
        colorBrightness: colorBrightness,
        padding: valueFromMaterial('padding', padding),
        visualDensity: visualDensity,
        shape: shape,
        clipBehavior: clipBehavior,
        focusNode: focusNode,
        autofocus: autofocus,
        materialTapTargetSize: materialTapTargetSize,
        child: valueFromMaterial('child', child),
      );
    } else if (outline) {
      return OutlineButton(
        key: valueFromMaterial('key', key),
        onPressed: valueFromMaterial('onPressed', onPressed),
        onLongPress: onLongPress,
        textTheme: textTheme,
        textColor: textColor,
        disabledTextColor: disabledTextColor,
        color: valueFromMaterial('color', color),
        focusColor: focusColor,
        hoverColor: hoverColor,
        highlightColor: highlightColor,
        splashColor: splashColor,
        highlightElevation: highlightElevation,
        borderSide: borderSide,
        disabledBorderColor: disabledBorderColor,
        highlightedBorderColor: highlightedBorderColor,
        padding: valueFromMaterial('padding', padding),
        visualDensity: visualDensity,
        shape: shape,
        clipBehavior: clipBehavior,
        focusNode: focusNode,
        autofocus: autofocus,
        child: valueFromMaterial('child', child),
      );
    } else if (raised) {
      return RaisedButton(
        key: valueFromMaterial('key', key),
        onPressed: valueFromMaterial('onPressed', onPressed),
        onLongPress: onLongPress,
        onHighlightChanged: onHighlightChanged,
        textTheme: textTheme,
        textColor: textColor,
        disabledTextColor: disabledTextColor,
        color: valueFromMaterial('color', color),
        disabledColor: valueFromMaterial('disabledColor', disabledColor),
        highlightColor: highlightColor,
        focusColor: focusColor,
        hoverColor: hoverColor,
        splashColor: splashColor,
        colorBrightness: colorBrightness,
        elevation: elevation,
        highlightElevation: highlightElevation,
        disabledElevation: disabledElevation,
        padding: valueFromMaterial('padding', padding),
        shape: shape,
        clipBehavior: clipBehavior,
        focusNode: focusNode,
        autofocus: autofocus,
        materialTapTargetSize: materialTapTargetSize,
        animationDuration: animationDuration,
        child: valueFromMaterial('child', child),
      );
    }
    return MaterialButton(
      key: valueFromMaterial('key', key),
      onPressed: valueFromMaterial('onPressed', onPressed),
      onLongPress: onLongPress,
      onHighlightChanged: onHighlightChanged,
      textTheme: textTheme,
      textColor: textColor,
      disabledTextColor: disabledTextColor,
      color: valueFromMaterial('color', color),
      disabledColor: valueFromMaterial('disabledColor', disabledColor),
      focusColor: focusColor,
      hoverColor: hoverColor,
      highlightColor: highlightColor,
      splashColor: splashColor,
      colorBrightness: colorBrightness,
      elevation: elevation,
      focusElevation: focusElevation,
      highlightElevation: highlightElevation,
      disabledElevation: disabledElevation,
      padding: valueFromMaterial('padding', padding),
      visualDensity: visualDensity,
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
