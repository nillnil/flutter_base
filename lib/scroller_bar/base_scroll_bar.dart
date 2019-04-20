import 'package:base/base_stateless_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseScrollBar extends BaseStatelessWidget {
  BaseScrollBar({
    Key key,
    this.child,
    Map<String, Object> cupertino,
    Map<String, Object> material,
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
