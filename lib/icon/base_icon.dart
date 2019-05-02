import 'package:flutter/widgets.dart'
    show BuildContext, Color, Icon, IconData, Key, TextDirection, Widget;

import '../base_stateless_widget.dart';

// BaseIcon
/// use Icon by cupertino
/// *** use cupertino = { forceUseMaterial: true } force use Icon on cuperitno.
/// use Icon by material
/// *** use material = { forceUseCupertino: true } force use Icon on material.
class BaseIcon extends BaseStatelessWidget {
  BaseIcon({
    Key baseKey,
    this.key,
    this.icon,
    this.size,
    this.color,
    this.semanticLabel,
    this.textDirection,
    Map<String, dynamic> cupertino,
    Map<String, dynamic> material,
  }) : super(key: baseKey, cupertino: cupertino, material: material);

  @override
  final Key key;
  final IconData icon;
  final double size;
  final Color color;
  final String semanticLabel;
  final TextDirection textDirection;

  @override
  Widget buildByCupertino(BuildContext context) {
    return Icon(
      valueFromCupertino('icon', icon),
      key: valueFromCupertino('key', key),
      size: valueFromCupertino('size', size),
      color: valueFromCupertino('color', color),
      semanticLabel: valueFromCupertino('semanticLabel', semanticLabel),
      textDirection: valueFromCupertino('textDirection', textDirection),
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    return Icon(
      valueFromMaterial('icon', icon),
      key: valueFromMaterial('key', key),
      size: valueFromMaterial('size', size),
      color: valueFromMaterial('color', color),
      semanticLabel: valueFromMaterial('semanticLabel', semanticLabel),
      textDirection: valueFromMaterial('textDirection', textDirection),
    );
  }
}
