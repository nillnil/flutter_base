import 'package:base/base_stateless_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// BaseScrollBar
/// use CupertinoScrollbar by cupertino
/// *** use cupertino = { forceUseMaterial: true } force use Scrollbar on cuperitno.
/// use Scrollbar by material
/// *** use material = { forceUseCupertino: true } force use CupertinoScrollbar on material.
class BaseScrollBar extends BaseStatelessWidget {
  BaseScrollBar({
    Key key,
    this.child,
    Map<String, dynamic> cupertino,
    Map<String, dynamic> material,
  }) : super(key: key, cupertino: cupertino, material: material);

  final Widget child;

  @override
  Widget buildByCupertino(BuildContext context) {
    return CupertinoScrollbar(
      child: child,
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    return Scrollbar(
      child: child,
    );
  }
}
