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
/// CupertinoSwitch: 2020.06.11
/// Switch: 2020.07.30
/// modify 2021.01.12 by flutter 1.22.5
class BaseSwitch extends BaseStatelessWidget {
  const BaseSwitch({
    Key baseKey,
    this.key,
    this.value,
    this.onChanged,
    this.activeColor,
    this.trackColor,
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
    this.autofocus = false,
    Map<String, dynamic> cupertino,
    Map<String, dynamic> material,
  }) : super(key: baseKey, cupertino: cupertino, material: material);

  /// *** gerenal properties start ***
  @override
  final Key key;

  /// [CupertinoSwitch.value]
  /// or
  /// [Switch.value]
  final bool value;

  /// [CupertinoSwitch.onChanged]
  /// or
  /// [Switch.onChanged]
  final ValueChanged<bool> onChanged;

  /// [CupertinoSwitch.activeColor]
  /// or
  /// [Switch.activeColor]
  final Color activeColor;

  /// [CupertinoSwitch.dragStartBehavior]
  /// or
  /// [Switch.dragStartBehavior]
  final DragStartBehavior dragStartBehavior;

  /// *** gerenal properties end ***

  /// *** cupertino properties start ***

  /// [CupertinoSwitch.trackColor]
  final Color trackColor;

  /// *** cupertino properties end ***

  /// *** material properties start ***

  /// [Switch.activeTrackColor]
  final Color activeTrackColor;

  /// [Switch.inactiveThumbColor]
  final Color inactiveThumbColor;

  /// [Switch.inactiveTrackColor]
  final Color inactiveTrackColor;

  /// [Switch.activeThumbImage]
  final ImageProvider activeThumbImage;

  /// [Switch.inactiveThumbImage]
  final ImageProvider inactiveThumbImage;

  /// [Switch.materialTapTargetSize]
  final MaterialTapTargetSize materialTapTargetSize;

  /// [Switch.focusColor]
  final Color focusColor;

  /// [Switch.hoverColor]
  final Color hoverColor;

  /// [Switch.focusNode]
  final FocusNode focusNode;

  /// [Switch.autofocus]
  final bool autofocus;

  /// [Switch.onActiveThumbImageError]
  final ImageErrorListener onActiveThumbImageError;

  /// [Switch.onInactiveThumbImageError]
  final ImageErrorListener onInactiveThumbImageError;

  /// [Switch.mouseCursor]
  final MouseCursor mouseCursor;

  /// *** material properties end ***

  @override
  Widget buildByCupertino(BuildContext context) {
    return CupertinoSwitch(
      key: valueFromCupertino('key', key),
      value: valueFromCupertino('value', value),
      activeColor: valueFromCupertino('activeColor', activeColor),
      trackColor: valueFromCupertino('trackColor', trackColor),
      dragStartBehavior: valueFromCupertino(
        'dragStartBehavior',
        dragStartBehavior,
      ),
      onChanged: valueFromCupertino('onChanged', onChanged),
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    return Switch(
      key: valueFromMaterial('key', key),
      value: valueFromMaterial('value', value),
      activeColor: valueFromMaterial('activeColor', activeColor),
      dragStartBehavior: valueFromMaterial(
        'dragStartBehavior',
        dragStartBehavior,
      ),
      onChanged: valueFromMaterial('onChanged', onChanged),
      activeTrackColor: activeTrackColor,
      inactiveThumbColor: inactiveThumbColor,
      inactiveTrackColor: inactiveTrackColor,
      activeThumbImage: activeThumbImage,
      onActiveThumbImageError: onActiveThumbImageError,
      inactiveThumbImage: inactiveThumbImage,
      onInactiveThumbImageError: onInactiveThumbImageError,
      materialTapTargetSize: materialTapTargetSize,
      mouseCursor: mouseCursor,
      focusColor: focusColor,
      hoverColor: hoverColor,
      focusNode: focusNode,
      autofocus: autofocus,
    );
  }
}
