import 'package:flutter/cupertino.dart' show CupertinoSwitch;
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';

import '../base_stateless_widget.dart';

/// BaseSwitch
/// use CupertinoSwitch by cupertino
/// *** use cupertino = { forceUseMaterial: true } force use Switch
/// use Switch by material
/// *** use material = { forceUseCupertino: true } force use CupertinoSwitch
class BaseSwitch extends BaseStatelessWidget {
  const BaseSwitch({
    Key baseKey,
    this.key,
    this.value,
    this.onChanged,
    this.activeColor,
    this.dragStartBehavior = DragStartBehavior.start,
    this.activeTrackColor,
    this.inactiveThumbColor,
    this.inactiveTrackColor,
    this.activeThumbImage,
    this.inactiveThumbImage,
    this.materialTapTargetSize,
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

  /// *** material properties end ***

  @override
  Widget buildByCupertino(BuildContext context) {
    return CupertinoSwitch(
      key: valueFromCupertino('key', key),
      value: valueFromCupertino('value', value),
      activeColor: valueFromCupertino('activeColor', activeColor),
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
      inactiveThumbImage: inactiveThumbImage,
      materialTapTargetSize: materialTapTargetSize,
    );
  }
}
