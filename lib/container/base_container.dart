import 'package:base/base_stateless_widget.dart';
import 'package:flutter/cupertino.dart';

/// 基础布局，解决ios下状态栏的padding问题
/// cupertino，使用Container
/// *** 可使用 cupertino = { forceUseMaterial: true } 参数强制使用Container
/// material，使用Container
/// *** 可使用 material = { forceUseCupertino: true } 参数强制使用Container
class BaseContainer extends BaseStatelessWidget {
  BaseContainer({
    Key key,
    this.alignment,
    this.padding,
    this.color,
    this.decoration,
    this.foregroundDecoration,
    this.width,
    this.height,
    this.constraints,
    this.margin,
    this.transform,
    this.child,
    this.autoAddTopPadding = true,
    Map<String, Object> cupertino,
    Map<String, Object> material,
  }) : super(key: key, cupertino: cupertino, material: material);

  final Alignment alignment;
  final EdgeInsetsGeometry padding;
  final Color color;
  final Decoration decoration;
  final Decoration foregroundDecoration;
  final double width;
  final double height;
  final BoxConstraints constraints;
  final EdgeInsetsGeometry margin;
  final Matrix4 transform;
  final Widget child;

  final bool autoAddTopPadding;

  @override
  Widget buildByCupertino(BuildContext context) {
    EdgeInsetsGeometry _padding = valueFromCupertino('padding', padding);
    _padding = _padding ?? (autoAddTopPadding ? EdgeInsets.only(
      top: MediaQuery.of(context).padding.top,
    ) : null);
    return Container(
      alignment: valueFromCupertino('alignment', alignment),
      padding: _padding,
      color: valueFromCupertino('color', color),
      decoration: valueFromCupertino('decoration', decoration),
      foregroundDecoration: valueFromCupertino('foregroundDecoration', foregroundDecoration),
      width: valueFromCupertino('width', width),
      height: valueFromCupertino('height', height),
      constraints: valueFromCupertino('constraints', constraints),
      margin: valueFromCupertino('margin', margin),
      transform: valueFromCupertino('transform', transform),
      child: valueFromCupertino('child', child),
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    EdgeInsetsGeometry _padding = valueFromMaterial('padding', padding);
    _padding = _padding ?? (autoAddTopPadding ? EdgeInsets.only(
      top: MediaQuery.of(context).padding.top,
    ) : null);
    return Container(
      alignment: valueFromCupertino('alignment', alignment),
      padding: _padding,
      color: valueFromMaterial('color', color),
      decoration: valueFromMaterial('decoration', decoration),
      foregroundDecoration: valueFromMaterial('foregroundDecoration', foregroundDecoration),
      width: valueFromMaterial('width', width),
      height: valueFromMaterial('height', height),
      constraints: valueFromMaterial('constraints', constraints),
      margin: valueFromMaterial('margin', margin),
      transform: valueFromMaterial('transform', transform),
      child: valueFromMaterial('child', child),
    );
  }
}
