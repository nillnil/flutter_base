import 'package:flutter/cupertino.dart' show CupertinoSwitch;
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../base_stateless_widget.dart';

/// BaseSwitch
/// use CupertinoSwitch by cupertino
/// *** use cupertino = { forceUseMaterial: true } force use Switch
/// use Switch by material
/// *** use material = { forceUseCupertino: true } force use CupertinoSwitch
///
/// CupertinoSwitch: 2021.03.12
/// Switch: 2021.03.31
/// modify 2021.06.25 by flutter 2.2.2
class BaseSwitch extends BaseStatelessWidget {
  const BaseSwitch({
    Key? key,
    this.value,
    this.onChanged,
    this.activeColor,
    this.cupertinoTrackColor,
    this.materialTrackColor,
    this.dragStartBehavior = DragStartBehavior.start,
    this.activeTrackColor,
    this.inactiveThumbColor,
    this.inactiveTrackColor,
    this.activeThumbImage,
    this.onActiveThumbImageError,
    this.inactiveThumbImage,
    this.onInactiveThumbImageError,
    this.materialTapTargetSize,
    this.mouseCursor,
    this.focusColor,
    this.hoverColor,
    this.focusNode,
    this.overlayColor,
    this.splashRadius,
    this.thumbColor,
    this.autofocus = false,
    Map<String, dynamic>? cupertino,
    Map<String, dynamic>? material,
  }) : super(key: key, cupertino: cupertino, material: material);

  /// *** gerenal properties start ***

  /// [CupertinoSwitch.value]
  /// or
  /// [Switch.value]
  final bool? value;

  /// [CupertinoSwitch.onChanged]
  /// or
  /// [Switch.onChanged]
  final ValueChanged<bool>? onChanged;

  /// [CupertinoSwitch.activeColor]
  /// or
  /// [Switch.activeColor]
  final Color? activeColor;

  /// [CupertinoSwitch.dragStartBehavior]
  /// or
  /// [Switch.dragStartBehavior]
  final DragStartBehavior dragStartBehavior;

  /// *** gerenal properties end ***

  /// *** cupertino properties start ***

  /// [CupertinoSwitch.trackColor]
  final Color? cupertinoTrackColor;

  /// *** cupertino properties end ***

  /// *** material properties start ***

  /// [Switch.activeTrackColor]
  final Color? activeTrackColor;

  /// [Switch.inactiveThumbColor]
  final Color? inactiveThumbColor;

  /// [Switch.inactiveTrackColor]
  final Color? inactiveTrackColor;

  /// [Switch.activeThumbImage]
  final ImageProvider? activeThumbImage;

  /// [Switch.inactiveThumbImage]
  final ImageProvider? inactiveThumbImage;

  /// [Switch.materialTapTargetSize]
  final MaterialTapTargetSize? materialTapTargetSize;

  /// [Switch.focusColor]
  final Color? focusColor;

  /// [Switch.hoverColor]
  final Color? hoverColor;

  /// [Switch.overlayColor]
  final MaterialStateProperty<Color?>? overlayColor;

  /// [Switch.splashRadius]
  final double? splashRadius;

  /// [Switch.focusNode]
  final FocusNode? focusNode;

  /// [Switch.autofocus]
  final bool autofocus;

  /// [Switch.onActiveThumbImageError]
  final ImageErrorListener? onActiveThumbImageError;

  /// [Switch.onInactiveThumbImageError]
  final ImageErrorListener? onInactiveThumbImageError;

  /// [Switch.thumbColor]
  final MaterialStateProperty<Color?>? thumbColor;

  final MaterialStateProperty<Color?>? materialTrackColor;

  /// [Switch.mouseCursor]
  final MouseCursor? mouseCursor;

  /// *** material properties end ***

  @override
  Widget buildByCupertino(BuildContext context) {
    return CupertinoSwitch(
      value: valueFromCupertino('value', value),
      onChanged: valueFromCupertino('onChanged', onChanged),
      activeColor: valueFromCupertino('activeColor', activeColor),
      trackColor: cupertinoTrackColor,
      dragStartBehavior: valueFromCupertino('dragStartBehavior', dragStartBehavior),
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    return Switch(
      value: valueFromMaterial('value', value),
      onChanged: valueFromMaterial('onChanged', onChanged),
      activeColor: valueFromMaterial('activeColor', activeColor),
      activeTrackColor: activeTrackColor,
      inactiveThumbColor: inactiveThumbColor,
      inactiveTrackColor: inactiveTrackColor,
      activeThumbImage: activeThumbImage,
      onActiveThumbImageError: onActiveThumbImageError,
      inactiveThumbImage: inactiveThumbImage,
      onInactiveThumbImageError: onInactiveThumbImageError,
      thumbColor: thumbColor,
      trackColor: materialTrackColor,
      materialTapTargetSize: materialTapTargetSize,
      dragStartBehavior: valueFromMaterial('dragStartBehavior', dragStartBehavior),
      mouseCursor: mouseCursor,
      focusColor: focusColor,
      hoverColor: hoverColor,
      overlayColor: overlayColor,
      splashRadius: splashRadius,
      focusNode: focusNode,
      autofocus: autofocus,
    );
  }
}
