import 'package:flutter/cupertino.dart' show CupertinoButton, ShapeBorder, CupertinoColors;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../base_stateless_widget.dart';

/// BaseButton
/// use CupertinoButton or CupertinoButton.filled by cupertino
/// *** use cupertino = { forceUseMaterial: true } force use MaterialButton or textButtonButton or OutlineButton or elevatedButtonButton on cuperitno.
/// use MaterialButton or TextButton or outlinedButtonButton or ElevatedButton by material
/// *** use material = { forceUseCupertino: true } force use CupertinoButton or CupertinoButton.filled on material.
///
/// CupertinoButton: 2021.01.14
/// MaterialButton: 2020.11.03
/// modify 2021.06.25 by flutter 2.2.2
class BaseButton extends BaseStatelessWidget {
  const BaseButton({
    Key? key,
    this.color,
    this.onPressed,
    this.disabledColor,
    this.padding,
    this.child,
    this.minSize = 44.0,
    this.pressedOpacity = 0.4,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.alignment = Alignment.center,
    this.filled = false,
    this.onLongPress,
    this.style,
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
    this.mouseCursor,
    this.hoverElevation,
    this.enableFeedback = true,

    /// 使按钮跟CupertinoButton的一样高，只有MaterialButton有效
    /// 其他的需修改Theme.of(context).buttonTheme.height才有效
    this.height = 48.0,
    this.textButton = false,
    this.outlinedButton = false,
    this.elevatedButton = false,
    Map<String, dynamic>? cupertino,
    Map<String, dynamic>? material,
  }) : super(key: key, cupertino: cupertino, material: material);

  /// [CupertinoButton], child is Row(children:[icon, label])
  /// or
  /// [MaterialButton], child is Row(children:[icon, label])
  /// or
  /// [TextButton.icon]
  /// or
  /// [outlinedButtonButton.icon]
  /// or
  /// [ElevatedButton.icon]
  BaseButton.icon({
    Key? key,
    this.color,
    this.onPressed,
    this.disabledColor,
    this.padding,
    this.minSize = 44.0,
    this.pressedOpacity = 0.4,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.filled = false,
    this.onLongPress,
    this.style,
    this.alignment = Alignment.center,
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
    this.mouseCursor,
    this.hoverElevation,
    this.enableFeedback = true,

    // 使按钮跟CupertinoButton的一样高
    this.height = 48.0,
    this.textButton = false,
    this.outlinedButton = false,
    this.elevatedButton = false,

    /// use textButtonButton.icon or OutlineButton.icon or elevatedButtonButton.icon.
    /// if do not want to have label, use BaseIconButton.
    @required Widget? icon,
    Widget? label,
    double interval = 8.0,
    Map<String, dynamic>? cupertino,
    Map<String, dynamic>? material,
  })  : child = label != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  icon!,
                  SizedBox(width: interval),
                  label,
                ],
              )
            : icon,
        super(key: key, cupertino: cupertino, material: material);

  /// *** general properties start ***

  /// [CupertinoButton.color]
  /// or
  /// [MaterialButton.color]
  final Color? color;

  /// [CupertinoButton.onPressed]
  /// or
  /// [MaterialButton.onPressed]
  final VoidCallback? onPressed;

  /// [CupertinoButton.disabledColor]
  /// or
  /// [MaterialButton.disabledColor]
  final Color? disabledColor;

  /// [CupertinoButton.padding]
  /// or
  /// [MaterialButton.padding]
  final EdgeInsetsGeometry? padding;

  /// [CupertinoButton.child]
  /// or
  /// [MaterialButton.child]
  final Widget? child;

  /// *** general properties end ***

  /// *** cupertino properties start ***

  /// [CupertinoButton.minSize]
  final double? minSize;

  /// [CupertinoButton.pressedOpacity]
  final double? pressedOpacity;

  /// [CupertinoButton.borderRadius]
  final BorderRadius? borderRadius;

  /// [CupertinoButton.alignment]
  final AlignmentGeometry alignment;

  /// [CupertinoButton.filled]
  /// use CupertinoButton.filled, will ignore the color, use primary color.
  final bool filled;

  /// *** cupertino properties ened ***

  /// *** material properties start ***

  /// [MaterialButton.onLongPress]
  final VoidCallback? onLongPress;

  /// [ButtonStyleButton.style]
  final ButtonStyle? style;

  /// [MaterialButton.onHighlightChanged]
  final ValueChanged<bool>? onHighlightChanged;

  /// [MaterialButton.textTheme]
  final ButtonTextTheme? textTheme;

  /// [MaterialButton.textColor]
  final Color? textColor;

  /// [MaterialButton.disabledTextColor]
  final Color? disabledTextColor;

  /// [MaterialButton.focusColor]
  final Color? focusColor;

  /// [MaterialButton.hoverColor]
  final Color? hoverColor;

  /// [MaterialButton.highlightColor]
  final Color? highlightColor;

  /// [MaterialButton.splashColor]
  final Color? splashColor;

  /// [MaterialButton.colorBrightness]
  final Brightness? colorBrightness;

  /// [MaterialButton.elevation]
  final double? elevation;

  /// [MaterialButton.hoverElevation]
  final double? hoverElevation;

  /// [MaterialButton.focusElevation]
  final double? focusElevation;

  /// [MaterialButton.highlightElevation]
  final double? highlightElevation;

  /// [MaterialButton.disabledElevation]
  final double? disabledElevation;

  /// [MaterialButton.visualDensity]
  final VisualDensity? visualDensity;

  /// [MaterialButton.shape]
  final ShapeBorder? shape;

  /// [MaterialButton.clipBehavior]
  final Clip clipBehavior;

  /// [MaterialButton.focusNode]
  final FocusNode? focusNode;

  /// [MaterialButton.autofocus]
  final bool autofocus;

  /// [MaterialButton.materialTapTargetSize]
  final MaterialTapTargetSize? materialTapTargetSize;

  /// [MaterialButton.animationDuration]
  final Duration? animationDuration;

  /// [MaterialButton.minWidth]
  final double? minWidth;

  /// [MaterialButton.height]
  final double? height;

  /// [MaterialButton.mouseCursor]
  final MouseCursor? mouseCursor;

  /// [MaterialButton.enableFeedback]
  final bool enableFeedback;

  /// [TextButton]
  /// use TextButton
  final bool textButton;

  /// [OutlinedButton]
  /// use OutlinedButton
  final bool outlinedButton;

  /// [ElevatedButton]
  /// use ElevatedButton
  final bool elevatedButton;

  /// *** material properties end ***

  @override
  Widget buildByCupertino(BuildContext context) {
    final Widget _child = valueFromCupertino('child', child);
    assert(_child != null, 'child can\'t be null.');
    final Color _disabledColor = valueFromCupertino('disabledColor', disabledColor) ?? CupertinoColors.quaternarySystemFill;
    final EdgeInsetsGeometry? _padding = valueFromCupertino('padding', padding);
    final VoidCallback? _onPressed = valueFromCupertino('onPressed', onPressed);
    if (filled) {
      return CupertinoButton.filled(
        child: _child,
        padding: _padding,
        disabledColor: _disabledColor,
        minSize: minSize,
        pressedOpacity: pressedOpacity,
        borderRadius: borderRadius,
        alignment: alignment,
        onPressed: _onPressed,
      );
    }
    return CupertinoButton(
      child: _child,
      padding: _padding,
      color: valueFromCupertino('color', color),
      disabledColor: _disabledColor,
      minSize: minSize,
      pressedOpacity: pressedOpacity,
      borderRadius: borderRadius,
      alignment: alignment,
      onPressed: _onPressed,
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    assert(
      (!textButton && !outlinedButton && !elevatedButton) ||
          (textButton && !outlinedButton && !elevatedButton) ||
          (!textButton && outlinedButton && !elevatedButton) ||
          (!textButton && !outlinedButton && elevatedButton),
      'textButton and outline can not be true at the same time.',
    );
    final Widget _child = valueFromMaterial('child', child);
    assert(_child != null, 'child can\'t be null.');
    final VoidCallback? _onPressed = valueFromMaterial('onPressed', onPressed);
    if (textButton) {
      return TextButton(
        onPressed: _onPressed,
        onLongPress: onLongPress,
        style: style,
        focusNode: focusNode,
        autofocus: autofocus,
        clipBehavior: clipBehavior,
        child: _child,
      );
    } else if (outlinedButton) {
      return OutlinedButton(
        onPressed: _onPressed,
        onLongPress: onLongPress,
        style: style,
        focusNode: focusNode,
        autofocus: autofocus,
        clipBehavior: clipBehavior,
        child: _child,
      );
    } else if (elevatedButton) {
      return ElevatedButton(
        onPressed: _onPressed,
        onLongPress: onLongPress,
        style: style,
        focusNode: focusNode,
        autofocus: autofocus,
        clipBehavior: clipBehavior,
        child: _child,
      );
    }
    return MaterialButton(
      onPressed: _onPressed,
      onLongPress: onLongPress,
      onHighlightChanged: onHighlightChanged,
      mouseCursor: mouseCursor,
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
      hoverElevation: hoverElevation,
      highlightElevation: highlightElevation,
      disabledElevation: disabledElevation,
      padding: valueFromMaterial('padding', padding),
      visualDensity: visualDensity,
      shape: shape,
      clipBehavior: clipBehavior,
      focusNode: focusNode,
      autofocus: autofocus,
      materialTapTargetSize: materialTapTargetSize,
      animationDuration: animationDuration,
      minWidth: minWidth,
      height: height,
      enableFeedback: enableFeedback,
      child: _child,
    );
  }
}
