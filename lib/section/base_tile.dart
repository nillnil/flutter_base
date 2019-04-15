
import 'package:base/base_stateless_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 基于ListTile
/// cupertino，使用InkWell
/// *** 可使用 cupertino = { forceUseMaterial: true } 参数强制使用ListTile
/// material，使用ListTile
/// *** 可使用 material = { forceUseCupertino: true } 参数强制使用自定义
class BaseTile extends BaseStatelessWidget {

  // general
  
  // 最左边控件，一般用图标
  final Widget leading;
  // 标题
  final Widget title;
  // title != null 时使用title，否则使用Text(titleText)
  final String titleText;
  // 副标题
  final Widget subtitle;
  // subtitle != null 时使用title，否则使用Text(subtitleText)
  final String subtitleText;
  // 最右边控件，多个时使用row包装
  final Widget trailing;
  final EdgeInsetsGeometry contentPadding;
  final GestureTapCallback onTap;
  final GestureLongPressCallback onLongPress;
  // 背景色默认白色
  final Color backgroundColor;

  // cupertino
  final Border border;
  final double height;
  final double width;
  final BorderRadius borderRadius;
  final Color splashColor;
  final Color highlightColor;
  final EdgeInsets margin;
  final MainAxisAlignment mainAxisAlignment;

  // material
  final bool isThreeLine;
  final bool dense;
  final bool enabled;
  final bool selected;

  BaseTile({
    Key key,
    this.leading,

    this.title,
    this.titleText,
    this.subtitle,
    this.subtitleText,

    this.trailing,
    this.contentPadding,
    this.onTap,
    this.onLongPress,

    this.backgroundColor = Colors.white,
    this.splashColor = Colors.transparent,
    this.highlightColor = const Color.fromRGBO(153, 153, 153, .4),
    this.margin,
    this.border,
    this.height,
    this.width,
    this.borderRadius,

    this.mainAxisAlignment,

    this.isThreeLine = false,
    this.dense = true,
    this.enabled = true,
    this.selected = false,

    Map<String, Object> cupertino,
    Map<String, Object> material
  }): super(key: key, cupertino: cupertino, material: material);

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
        border: border
      ),
      margin: margin,
      padding: contentPadding ?? EdgeInsets.zero,
      height: height,
      width: width,
      child: Row(
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
        children: rows
      )
    );
    return Material(
      animationDuration: Duration(milliseconds: 10),
      color: backgroundColor,
      borderOnForeground: false,
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
          splashColor: splashColor ?? CupertinoTheme.of(context).primaryContrastingColor,
          highlightColor: highlightColor ?? Theme.of(context).highlightColor,
          onTap: onTap ?? null,
          onLongPress: onLongPress ?? null
        )
      )
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
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
        color: backgroundColor
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
