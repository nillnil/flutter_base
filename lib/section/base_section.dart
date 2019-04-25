import 'package:base/base_stateless_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// BaseSection
/// use custom Container by cupertino or material
class BaseSection extends BaseStatelessWidget {
  BaseSection({
    Key key,
    this.margin,
    this.divider = const Divider(height: 1.0),
    Divider indentDivider,
    this.backgroundColor,
    this.dividerIndent = 0.0,
    this.children,
    this.header,
    this.footer,
    Map<String, dynamic> cupertino,
    Map<String, dynamic> material,
  })  : indentDivider = indentDivider ?? divider != null
            ? Divider(
                height: 1.0,
                indent: dividerIndent,
                color: divider.color,
              )
            : Divider(
                indent: dividerIndent,
                height: 1.0,
              ),
        super(key: key, cupertino: cupertino, material: material);

  final EdgeInsets margin;
  final Divider divider;
  final double dividerIndent;

  /// 背景色，当设置了indent不生效时，建议设置跟tile一样的背景色
  /// 因为可能是section所在的页面背景色影响到了视觉效果，使其看起来没有indent一样。
  final Color backgroundColor;
  final Divider indentDivider;
  final List<Widget> children;

  final Widget header;
  final Widget footer;

  @override
  Widget buildByCupertino(BuildContext context) {
    final EdgeInsets margin = valueFromCupertino('margin', this.margin);
    final Divider divider = valueFromCupertino('divider', this.divider);
    final List<Widget> children = valueFromCupertino('children', this.children);
    final Widget header = valueFromCupertino('header', this.header);
    final Widget footer = valueFromCupertino('footer', this.footer);
    return _build(context, margin, divider, children, header, footer);
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    final EdgeInsets margin = valueFromMaterial('margin', this.margin);
    final Divider divider = valueFromMaterial('divider', this.divider);
    final List<Widget> children = valueFromMaterial('children', this.children);
    final Widget header = valueFromMaterial('header', this.header);
    final Widget footer = valueFromMaterial('footer', this.footer);
    return _build(context, margin, divider, children, header, footer);
  }

  Widget _build(
    BuildContext context,
    EdgeInsets margin,
    Divider divider,
    List<Widget> children,
    Widget header,
    Widget footer,
  ) {
    Widget container;
    final int length = children.length;
    if (length == 1 && header == null && footer == null) {
      if (divider != null) {
        container = Container(
          margin: margin,
          child: Column(
            children: <Widget>[
              divider,
              children[0],
              divider,
            ],
          ),
        );
      } else {
        container = Container(
          margin: margin,
          child: children[0],
        );
      }
    } else {
      final List<Widget> widgets = <Widget>[];
      if (header != null) {
        widgets.add(header);
      }
      for (int i = 0; i < length; i++) {
        if (i == 0) {
          if (divider != null) {
            widgets.add(divider);
          }
          widgets.add(
            Container(
              child: children[i],
            ),
          );
          if (length == 1 && divider != null) {
            widgets.add(divider);
          }
        } else if (i == length - 1) {
          if (indentDivider != null) {
            if (backgroundColor != null) {
              widgets.add(
                Container(
                  color: backgroundColor,
                  child: indentDivider,
                ),
              );
            } else {
              widgets.add(indentDivider);
            }
          }
          widgets.add(
            Container(
              child: children[i],
            ),
          );
          if (divider != null) {
            widgets.add(divider);
          }
        } else {
          if (indentDivider != null) {
            if (backgroundColor != null) {
              widgets.add(
                Container(
                  color: backgroundColor,
                  child: indentDivider,
                ),
              );
            } else {
              widgets.add(indentDivider);
            }
          }
          widgets.add(
            Container(
              child: children[i],
            ),
          );
        }
      }
      if (footer != null) {
        widgets.add(footer);
      }
      container = Container(
        margin: margin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widgets,
        ),
      );
    }
    return container;
  }
}
