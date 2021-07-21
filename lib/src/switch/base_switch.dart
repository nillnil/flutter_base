import 'package:flutter/cupertino.dart' show CupertinoSwitch;
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../base_param.dart';
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
    BaseParam? baseParam,
  }) : super(key: key, baseParam: baseParam);

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
      value: valueOf('value', value),
      onChanged: valueOf('onChanged', onChanged),
      activeColor: valueOf('activeColor', activeColor),
      trackColor: valueOf('cupertinoTrackColor', cupertinoTrackColor),
      dragStartBehavior: valueOf('dragStartBehavior', dragStartBehavior),
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    return Switch(
      value: valueOf('value', value),
      onChanged: valueOf('onChanged', onChanged),
      activeColor: valueOf('activeColor', activeColor),
      activeTrackColor: valueOf('activeTrackColor', activeTrackColor),
      inactiveThumbColor: valueOf('inactiveThumbColor', inactiveThumbColor),
      inactiveTrackColor: valueOf('inactiveTrackColor', inactiveTrackColor),
      activeThumbImage: valueOf('activeThumbImage', activeThumbImage),
      onActiveThumbImageError: valueOf('onActiveThumbImageError', onActiveThumbImageError),
      inactiveThumbImage: valueOf('inactiveThumbImage', inactiveThumbImage),
      onInactiveThumbImageError: valueOf('onInactiveThumbImageError', onInactiveThumbImageError),
      thumbColor: valueOf('thumbColor', thumbColor),
      trackColor: valueOf('materialTrackColor', materialTrackColor),
      materialTapTargetSize: valueOf('materialTapTargetSize', materialTapTargetSize),
      dragStartBehavior: valueOf('dragStartBehavior', dragStartBehavior),
      mouseCursor: valueOf('mouseCursor', mouseCursor),
      focusColor: valueOf('focusColor', focusColor),
      hoverColor: valueOf('hoverColor', hoverColor),
      overlayColor: valueOf('overlayColor', overlayColor),
      splashRadius: valueOf('splashRadius', splashRadius),
      focusNode: valueOf('focusNode', focusNode),
      autofocus: valueOf('autofocus', autofocus),
    );
  }
}
