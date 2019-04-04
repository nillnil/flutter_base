
import 'dart:async';
import 'package:base/base_stateless_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseTile extends BaseStatelessWidget {

  final Key key;
  final Widget leading;

  final Widget title;
  final String titleText;
  final Widget subtitle;
  final String subtitleText;

  final Widget trailing;
  final EdgeInsetsGeometry contentPadding;
  final GestureTapCallback onTap;
  final GestureLongPressCallback onLongPress;

  final Color backgroundColor;
  final Color splashColor;
  final Color highlightColor;
  final EdgeInsets margin;
  final Border border;
  final double height;
  final double width;
  final bool useInkWell;
  final BorderRadius borderRadius;

  final MainAxisAlignment mainAxisAlignment;

  // material
  final bool isThreeLine;
  final bool dense;
  final bool enabled;
  final bool selected;
  // cupertino使用的是自定义，可能与material自带的ListTile效果不一样，所以使用useCustom全都使用自定义，保持效果一致
  final bool useCustom;

  BaseTile({
    this.key,
    this.leading,

    this.title,
    this.titleText,
    this.subtitle,
    this.subtitleText,

    this.trailing,
    this.contentPadding,
    this.onTap,
    this.onLongPress,

    this.backgroundColor,
    this.splashColor,
    this.highlightColor,
    this.margin,
    this.border,
    this.height,
    this.width,
    this.useInkWell = true,
    this.borderRadius,

    this.mainAxisAlignment,

    this.isThreeLine = false,
    this.dense = true,
    this.enabled = true,
    this.selected = false,
    this.useCustom = true
  });

  final Color _splashColor = Colors.transparent;
  final Color _highlightColor = Color.fromRGBO(153, 153, 153, .6);

  @override
  Widget buildByCupertino(BuildContext context) {
    TextStyle _defaultTextStyle = TextStyle(
      fontFamily: '.SF UI Text',
      fontSize: 16.0,
      color: CupertinoColors.black
    );
    List<Widget> leftRow = List<Widget>();
    List<Widget> rows = List<Widget>();
    if (leading != null) {
      rows.add(leading);
    }
    if (subtitle != null || subtitleText != null) {
      rows.add(
        Expanded(
          child: Padding(
            padding: contentPadding ?? EdgeInsets.zero,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                title ?? Text(titleText ?? ''),
                subtitle ?? Text(subtitleText ?? '')
              ]
            )
          )
        )
      );
    } else {
      rows.add(
        Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            child: title ?? Text(titleText ?? '')
          )
        )
      );
    }
    rows.add(
      Padding(
        padding: contentPadding ?? EdgeInsets.all(0.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: leftRow
        )
      )
    );
    if (trailing != null) {
      rows.add(
        Container(
          alignment: Alignment.centerRight,
          child: trailing
        )
      );
    }
    Widget content = Container(
      key: key,
      decoration: BoxDecoration(
        border: border ?? null
      ),
      margin: margin ?? null,
      padding: contentPadding ?? EdgeInsets.zero,
      height: height ?? null,
      width: width ?? null,
      child: Row(
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
        children: rows
      )
    );
    if (useInkWell) {
      return Material(
        animationDuration: Duration(milliseconds: 10),
        type: (backgroundColor != null && backgroundColor.alpha != 0xFF) ? MaterialType.transparency : MaterialType.canvas,
        color: backgroundColor ?? Colors.white,
        child: Ink(
          child: InkWell(
            radius: 0.0,
            borderRadius: borderRadius ?? BorderRadius.zero,
            child: Semantics(
              child: SafeArea(
                top: false,
                bottom: false,
                child: DefaultTextStyle(style: _defaultTextStyle, child: content),
              )
            ),
            splashColor: splashColor ?? Theme.of(context).splashColor ?? _splashColor,
            highlightColor: highlightColor ?? Theme.of(context).highlightColor ?? _highlightColor,
            onTap: onTap ?? null,
            onLongPress: onLongPress ?? null
          )
        )
      );
    } else {
      return GestureDetector(
        child: content,
        onTap: () {
          // 延时修改选中状态，不然看不出背景变化
          Timer(
            Duration(milliseconds: 20),
              () {
              if (onTap != null) {
                onTap();
              }
            }
          );
        },
        onLongPress: () {
          if (onLongPress != null) {
            onLongPress();
          }
        },
        onLongPressUp: () {
          if (onLongPress == null && onTap != null) {
            onTap();
          }
        },
        behavior: HitTestBehavior.opaque
      );
    }
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    if (useCustom) {
      return buildByCupertino(context);
    } else {
      // 让trailing支持多个widget
      // trailing是Row的话取最后一个放在trailing里，其余的于title，subtitle组成另一个Row放在title里
      Widget trailingWidget;
      Widget titleWidget;
      if (trailing is Row) {
        List<Widget> children = (trailing as Row).children;
        int length = children.length;
        if (length > 0) {
          trailingWidget = children[length - 1];
          if (length > 1) {
            List<Widget> rowChildren = [];
            if (subtitle != null) {
              rowChildren.add(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    title,
                    subtitle
                  ]
                )
              );
            } else {
              rowChildren.add(title);
            }
            rowChildren.addAll(children.getRange(0, length - 1));
            titleWidget = Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: rowChildren
            );
          }
        }
      }
      return Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white
        ),
        child: ListTile(
          key: key,
          leading: leading,
          title: titleWidget ?? title,
          subtitle: titleWidget == null ? subtitle : null,
          trailing: trailingWidget ?? trailing,
          isThreeLine: isThreeLine,
          dense: dense,
          contentPadding: contentPadding,
          enabled: enabled,
          onTap: onTap,
          onLongPress: onLongPress,
          selected: selected,
        )
      );
    }
  }

}
