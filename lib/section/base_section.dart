
import 'package:base/base_stateless_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// 基础tile块，自定义
class BaseSection extends BaseStatelessWidget {

	final Key key;
	final EdgeInsets margin;
	final Divider divider;
	final double dividerIndent;
	final Divider indentDivider;
	final List<Widget> children;

	final Widget header;
	final Widget footer;

	final Map<String, Object> cupertino;
	final Map<String, Object> material;

	BaseSection({
		this.key,
		this.margin,
		this.divider = const Divider(height: 1.0),
		Divider indentDivider,
		this.dividerIndent = 60.0,
		this.children,
		this.header,
		this.footer,

		this.cupertino,
		this.material
	}) : indentDivider = indentDivider ?? divider != null ? Divider(
		height: 1.0,
		indent: dividerIndent,
		color: divider.color
	) : Divider(indent: dividerIndent, height: 1.0),
	super(key: key, cupertino: cupertino, material: material);

	@override
	Widget buildByCupertino(BuildContext context) {
		Key key = valueFromCupertino('key', this.key);
		EdgeInsets margin = valueFromCupertino('margin', this.margin);
		Divider divider = valueFromCupertino('divider', this.divider);
		List<Widget> children = valueFromCupertino('children', this.children);
		Widget header = valueFromCupertino('header', this.header);
		Widget footer = valueFromCupertino('footer', this.footer);
		return _build(key, margin, divider, children, header, footer);
	}

	@override
	Widget buildByMaterial(BuildContext context) {
		Key key = valueFromMaterial('key', this.key);
		EdgeInsets margin = valueFromMaterial('margin', this.margin);
		Divider divider = valueFromMaterial('divider', this.divider);
		List<Widget> children = valueFromMaterial('children', this.children);
		Widget header = valueFromMaterial('header', this.header);
		Widget footer = valueFromMaterial('footer', this.footer);
		return _build(key, margin, divider, children, header, footer);
	}

  Widget _build(Key key, EdgeInsets margin, Divider divider, List<Widget> children, Widget header, Widget footer) {
  	Widget container;
  	int length = children.length;
  	if (length == 1 && header == null && footer == null) {
			container = divider != null ? Container(
				margin: margin,
				child: Column(
					children: <Widget>[
						divider,
						children[0],
						divider
					]
				)
			): Container(
				margin: margin,
				child: children[0]
			);
		} else if (length > 1) {
  		List<Widget> widgets = List<Widget>();
  		if (header != null) {
  			widgets.add(header);
			}
  		for (var i = 0; i < length; i++) {
  			if (i == 0) {
  				if (divider != null) {
  					widgets.add(divider);
					}
					widgets.add(
						Container(
							child: children[i]
						)
					);
				} else if (i == length - 1) {
					if (divider != null) {
						widgets.add(indentDivider);
					}
					widgets.add(
						Container(
							child: children[i]
						)
					);
					if (divider != null) {
						widgets.add(divider);
					}
				} else {
					if (divider != null) {
						widgets.add(indentDivider);
					}
					widgets.add(
						Container(
							child: children[i]
						)
					);
				}
			}
			if (footer != null) {
  			widgets.add(footer);
			}
			container = Container(
				margin: margin,
				child: Column(
					children: widgets
				)
			);
		}
    return container;
  }

}
