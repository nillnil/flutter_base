
import 'package:base/base_stateless_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseScrollBar extends BaseStatelessWidget {

	final Widget child;

	final Map<String, Object> cupertino;
	final Map<String, Object> material;

	BaseScrollBar({
		Key key,

		this.child,

		this.cupertino,
		this.material
	}): super(key: key, cupertino: cupertino, material: material);

  @override
  Widget buildByCupertino(BuildContext context) {
    return CupertinoScrollbar(
			child: child
		);
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    return Scrollbar(
			child: child
		);
  }


}