import 'package:flutter/material.dart';

import '../base_param.dart';
import '../base_stateless_widget.dart';
import '../theme/base_theme.dart';
import '../theme/base_theme_data.dart';

/// BaseSection
/// use custom Container by cupertino or material
class BaseSection extends BaseStatelessWidget {
  const BaseSection({
    Key? key,
    this.margin,
    this.decoration,
    this.divider = const BaseSectionDivider(),
    this.children,
    this.header,
    this.footer,
    BaseParam? baseParam,
  }) : super(key: key, baseParam: baseParam);

  final EdgeInsets? margin;
  final Decoration? decoration;
  final BaseSectionDivider? divider;

  final List<Widget>? children;

  final Widget? header;
  final Widget? footer;

  @override
  Widget buildByCupertino(BuildContext context) {
    final EdgeInsets? margin = valueOf('margin', this.margin);
    final BaseSectionDivider? divider = valueOf(
      'divider',
      this.divider,
    );
    final List<Widget>? children = valueOf('children', this.children);
    final Widget? header = valueOf('header', this.header);
    final Widget? footer = valueOf('footer', this.footer);
    return _build(context, margin, divider, children, header, footer);
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    final EdgeInsets? margin = valueOf('margin', this.margin);
    final BaseSectionDivider? divider = valueOf('divider', this.divider);
    final List<Widget>? children = valueOf('children', this.children);
    final Widget? header = valueOf('header', this.header);
    final Widget? footer = valueOf('footer', this.footer);
    return _build(context, margin, divider, children, header, footer);
  }

  Widget _build(
    BuildContext context,
    EdgeInsets? margin,
    BaseSectionDivider? divider,
    List<Widget>? children,
    Widget? header,
    Widget? footer,
  ) {
    Widget container;
    final int length = children?.length ?? 0;
    final List<Widget> widgets = <Widget>[];
    UnderlineTabIndicator? _divider;
    if (divider != null) {
      final BaseThemeData baseTheme = BaseTheme.of(context);
      final Color? color = divider.color ?? baseTheme.sectionDividerColor;
      _divider = UnderlineTabIndicator(
        borderSide: BorderSide(width: divider.height, color: color!),
        insets: divider.insets,
      );
    }
    if (header != null) {
      widgets.add(header);
    }
    for (int i = 0; i < length; i++) {
      Widget child = Container(
        child: children![i],
      );
      if (_divider != null && i != length - 1) {
        child = Container(
          child: child,
          foregroundDecoration: _divider,
        );
      }
      widgets.add(child);
    }
    container = Container(
      decoration: decoration,
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgets,
      ),
    );
    if (footer != null) {
      widgets.add(footer);
    }
    return container;
  }
}

class BaseSectionDivider {
  const BaseSectionDivider({
    this.color,
    this.height = .5,
    this.insets = const EdgeInsets.only(left: 10.0),
  });

  final Color? color;
  final double height;
  final EdgeInsetsGeometry insets;
}
