import 'package:base/base_stateless_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseScrollBar extends BaseStatelessWidget {
  final Widget child;

  BaseScrollBar({
    Key key,
    this.child,
    Map<String, Object> cupertino,
    Map<String, Object> material,
  }) : super(cupertino: cupertino, material: material);

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
