import 'package:flutter/cupertino.dart' show CupertinoSwitch;
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';

import '../base_stateless_widget.dart';

/// 基础切换按钮
class BaseSwitch extends BaseStatelessWidget {
  BaseSwitch({
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

  // gerenal
  @override
  final Key key;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final DragStartBehavior dragStartBehavior;

  // material
  final Color activeTrackColor;
  final Color inactiveThumbColor;
  final Color inactiveTrackColor;
  final ImageProvider activeThumbImage;
  final ImageProvider inactiveThumbImage;
  final MaterialTapTargetSize materialTapTargetSize;

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
