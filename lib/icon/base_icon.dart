import 'package:flutter/widgets.dart'
    show BuildContext, Color, Icon, IconData, Key, TextDirection, Widget;
import 'package:base/base_stateless_widget.dart';

/// 基础图标
/// cupertino，使用Icon
/// material，使用Icon
class BaseIcon extends BaseStatelessWidget {
  BaseIcon({
    Key key,
    this.icon,
    this.size,
    this.color,
    this.semanticLabel,
    this.textDirection,
    Map<String, dynamic> cupertino,
    Map<String, dynamic> material,
  }) : super(key: key, cupertino: cupertino, material: material);

  final IconData icon;
  final double size;
  final Color color;
  final String semanticLabel;
  final TextDirection textDirection;

  @override
  Widget buildByCupertino(BuildContext context) {
    return Icon(
      valueFromCupertino('icon', icon),
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
      size: valueFromMaterial('size', size),
      color: valueFromMaterial('color', color),
      semanticLabel: valueFromMaterial('semanticLabel', semanticLabel),
      textDirection: valueFromMaterial('textDirection', textDirection),
    );
  }
}
