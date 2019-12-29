import 'package:flutter/cupertino.dart' show CupertinoScrollbar;
import 'package:flutter/material.dart';

import '../base_stateless_widget.dart';

/// BaseScrollBar
/// use CupertinoScrollbar by cupertino
/// *** use cupertino = { forceUseMaterial: true } force use Scrollbar on cuperitno.
/// use Scrollbar by material
/// *** use material = { forceUseCupertino: true } force use CupertinoScrollbar on material.
class BaseScrollBar extends BaseStatelessWidget {
  const BaseScrollBar({
    Key baseKey,
    this.key,
    this.controller,
    this.child,
    this.padding,
    Map<String, dynamic> cupertino,
    Map<String, dynamic> material,
  }) : super(key: baseKey, cupertino: cupertino, material: material);

  @override
  final Key key;

  /// [CupertinoScrollbar.controller]
  /// or
  /// [Scrollbar.controller]
  final ScrollController controller;

  /// [CupertinoScrollbar.child]
  /// or
  /// [Scrollbar.child]
  final Widget child;

  /// [MediaQuery.of(context).padding]
  final EdgeInsets padding;

  @override
  Widget buildByCupertino(BuildContext context) {
    if (padding != null) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(
          padding: padding,
        ),
        child: CupertinoScrollbar(
          key: valueFromCupertino('key', key),
          controller: valueFromCupertino('controller', controller),
          child: child,
        ),
      );
    }
    return CupertinoScrollbar(
      key: valueFromCupertino('key', key),
      controller: valueFromCupertino('controller', controller),
      child: child,
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    if (padding != null) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(
          padding: padding,
        ),
        child: Scrollbar(
          key: valueFromMaterial('key', key),
          child: child,
          controller: valueFromMaterial('controller', controller),
        ),
      );
    }
    return Scrollbar(
      key: valueFromMaterial('key', key),
      child: child,
      controller: valueFromMaterial('controller', controller),
    );
  }
}
