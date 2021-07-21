import 'dart:math' as math;
import 'dart:ui' show lerpDouble;

import 'package:flutter/cupertino.dart' show CupertinoButton, ShapeBorder, CupertinoColors;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../base_param.dart';
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
    this.filledButton = false,
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
    BaseParam? baseParam,
  }) : super(key: key, baseParam: baseParam);

  /// [CupertinoButton], child is Row(children:[icon, label])
  /// or
  /// [MaterialButton], child is Row(children:[icon, label])
  /// or
  /// [TextButton.icon]
  /// or
  /// [outlinedButtonButton.icon]
  /// or
  /// [ElevatedButton.icon]
  const factory BaseButton.icon({
    Key? key,
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool autofocus,
    Clip clipBehavior,
    EdgeInsetsGeometry? padding,
    Color? color,
    Color? disabledColor,
    double minSize,
    double? pressedOpacity,
    BorderRadius? borderRadius,
    AlignmentGeometry alignment,
    Widget icon,
    Widget label,
    bool filledButton,
    bool textButton,
    bool outlinedButton,
    bool elevatedButton,
    BaseParam? baseParam,
  }) = _BaseButtonWithIcon;

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
  final bool filledButton;

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
    final Widget _child = valueOf('child', child);
    return buildByCupertinoWithChild(_child);
  }

  /// 最终的构建方法，为了兼容BaseButton.icon
  Widget buildByCupertinoWithChild(Widget child) {
    assert(child != null, 'child can\'t be null.');
    final Color _disabledColor = valueOf('disabledColor', disabledColor) ?? CupertinoColors.quaternarySystemFill;
    final EdgeInsetsGeometry? _padding = valueOf('padding', padding);
    final VoidCallback? _onPressed = valueOf('onPressed', onPressed);
    final double _minSize = valueOf('minSize', minSize);
    final double _pressedOpacity = valueOf('minSize', pressedOpacity);
    final BorderRadius? _borderRadius = valueOf('borderRadius', borderRadius);
    final AlignmentGeometry _alignment = valueOf('alignment', alignment);
    if (filledButton) {
      return CupertinoButton.filled(
        child: child,
        padding: _padding,
        disabledColor: _disabledColor,
        minSize: _minSize,
        pressedOpacity: _pressedOpacity,
        borderRadius: _borderRadius,
        alignment: _alignment,
        onPressed: _onPressed,
      );
    }
    return CupertinoButton(
      child: child,
      padding: _padding,
      color: valueOf('color', color),
      disabledColor: _disabledColor,
      minSize: _minSize,
      pressedOpacity: _pressedOpacity,
      borderRadius: _borderRadius,
      alignment: _alignment,
      onPressed: _onPressed,
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    final Widget _child = valueOf('child', child);
    return buildByMaterialWithChild(_child);
  }

  /// 最终的构建方法，为了兼容BaseButton.icon
  Widget buildByMaterialWithChild(Widget child) {
    assert(
      (!textButton && !outlinedButton && !elevatedButton) ||
          (textButton && !outlinedButton && !elevatedButton) ||
          (!textButton && outlinedButton && !elevatedButton) ||
          (!textButton && !outlinedButton && elevatedButton),
      'textButton and outline can not be true at the same time.',
    );
    assert(child != null, 'child can\'t be null.');
    final VoidCallback? _onPressed = valueOf('onPressed', onPressed);
    final VoidCallback? _onLongPress = valueOf('onLongPress', onLongPress);
    final ButtonStyle? _style = valueOf('style', style);
    final FocusNode? _focusNode = valueOf('focusNode', focusNode);
    final bool _autofocus = valueOf('autofocus', autofocus);
    final Clip _clipBehavior = valueOf('clipBehavior', clipBehavior);
    if (textButton) {
      return TextButton(
        onPressed: _onPressed,
        onLongPress: _onLongPress,
        style: _style,
        focusNode: _focusNode,
        autofocus: _autofocus,
        clipBehavior: _clipBehavior,
        child: child,
      );
    } else if (outlinedButton) {
      return OutlinedButton(
        onPressed: _onPressed,
        onLongPress: _onLongPress,
        style: _style,
        focusNode: _focusNode,
        autofocus: _autofocus,
        clipBehavior: _clipBehavior,
        child: child,
      );
    } else if (elevatedButton) {
      return ElevatedButton(
        onPressed: _onPressed,
        onLongPress: _onLongPress,
        style: _style,
        focusNode: _focusNode,
        autofocus: _autofocus,
        clipBehavior: _clipBehavior,
        child: child,
      );
    }
    return MaterialButton(
      onPressed: _onPressed,
      onLongPress: _onLongPress,
      onHighlightChanged: valueOf('onHighlightChanged', onHighlightChanged),
      mouseCursor: valueOf('mouseCursor', mouseCursor),
      textTheme: valueOf('textTheme', textTheme),
      textColor: valueOf('textColor', textColor),
      disabledTextColor: valueOf('disabledTextColor', disabledTextColor),
      color: valueOf('color', color),
      disabledColor: valueOf('disabledColor', disabledColor),
      focusColor: valueOf('focusColor', focusColor),
      hoverColor: valueOf('hoverColor', hoverColor),
      highlightColor: valueOf('highlightColor', highlightColor),
      splashColor: valueOf('splashColor', splashColor),
      colorBrightness: valueOf('colorBrightness', colorBrightness),
      elevation: valueOf('elevation', elevation),
      focusElevation: valueOf('focusElevation', focusElevation),
      hoverElevation: valueOf('hoverElevation', hoverElevation),
      highlightElevation: valueOf('highlightElevation', highlightElevation),
      disabledElevation: valueOf('disabledElevation', disabledElevation),
      padding: valueOf('padding', padding),
      visualDensity: valueOf('visualDensity', visualDensity),
      shape: valueOf('shape', shape),
      clipBehavior: _clipBehavior,
      focusNode: _focusNode,
      autofocus: _autofocus,
      materialTapTargetSize: valueOf('materialTapTargetSize', materialTapTargetSize),
      animationDuration: valueOf('animationDuration', animationDuration),
      minWidth: valueOf('minWidth', minWidth),
      height: valueOf('height', height),
      enableFeedback: valueOf('enableFeedback', enableFeedback),
      child: child,
    );
  }
}

/// 带icon的BaseButton
class _BaseButtonWithIcon extends BaseButton {
  const _BaseButtonWithIcon({
    Key? key,
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool autofocus = false,
    Clip clipBehavior = Clip.none,
    EdgeInsetsGeometry? padding,
    Color? color,
    Color? disabledColor,
    double? minSize = 24.0,
    double? pressedOpacity = .4,
    BorderRadius? borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    AlignmentGeometry alignment = Alignment.center,
    this.icon,
    this.label,
    bool filledButton = false,
    bool textButton = false,
    bool outlinedButton = false,
    bool elevatedButton = false,
    BaseParam? baseParam,
  }) : super(
          key: key,
          onPressed: onPressed,
          onLongPress: onLongPress,
          style: style,
          focusNode: focusNode,
          autofocus: autofocus,
          clipBehavior: clipBehavior,
          padding: padding,
          color: color,
          disabledColor: disabledColor,
          minSize: minSize,
          pressedOpacity: pressedOpacity,
          borderRadius: borderRadius,
          alignment: alignment,
          textButton: textButton,
          filledButton: filledButton,
          outlinedButton: outlinedButton,
          elevatedButton: elevatedButton,
          baseParam: baseParam,
        );

  final Widget? icon;
  final Widget? label;

  @override
  Widget buildByCupertino(BuildContext context) {
    final Widget _icon = valueOf('icon', icon);
    final Widget? _label = valueOf('label', label);
    assert(_icon != null, 'icon can\'t be null.');
    final Widget _child = _ButtonWithIconChild(icon: icon!, label: _label);
    return super.buildByCupertinoWithChild(_child);
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    final Widget _icon = valueOf('icon', icon);
    final Widget _label = valueOf('label', label);
    assert(_icon != null, 'icon can\'t be null.');
    final Widget _child = _ButtonWithIconChild(icon: icon!, label: _label);
    return super.buildByMaterialWithChild(_child);
  }
}

/// BaseButton.Icon.child
class _ButtonWithIconChild extends StatelessWidget {
  const _ButtonWithIconChild({
    Key? key,
    required this.label,
    required this.icon,
  }) : super(key: key);

  final Widget? label;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final double scale = MediaQuery.maybeOf(context)?.textScaleFactor ?? 1;
    final double gap = scale <= 1 ? 8 : lerpDouble(8, 4, math.min(scale - 1, 1))!;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: label != null ? <Widget>[icon, SizedBox(width: gap), label!] : <Widget>[icon],
    );
  }
}
