import 'package:flutter/cupertino.dart' show CupertinoTheme;
import 'package:flutter/material.dart';

import '../base_stateless_widget.dart';

/// BaseTile
/// use custom InkWell by cupertino
/// *** use cupertino = { forceUseMaterial: true } force use ListTile on cuperitno.
/// use ListTile by material
/// *** use material = { forceUseCupertino: true } force use custom InkWell on material.
class BaseTile extends BaseStatelessWidget {
  BaseTile({
    Key baseKey,
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
    this.backgroundColor = Colors.white,
    this.splashColor = Colors.transparent,
    this.highlightColor = const Color.fromRGBO(153, 153, 153, .4),
    this.border,
    this.height,
    this.borderRadius,
    this.mainAxisAlignment,
    this.isThreeLine = false,
    this.dense = true,
    this.enabled = true,
    this.selected = false,
    Map<String, dynamic> cupertino,
    Map<String, dynamic> material,
  }) : super(key: baseKey, cupertino: cupertino, material: material);

  // general
  @override
  final Key key;

  /// 最左边控件，一般用图标
  final Widget leading;

  /// 标题
  final Widget title;

  /// title != null 时使用title，否则使用Text(titleText)
  final String titleText;

  /// 副标题
  final Widget subtitle;

  /// subtitle != null 时使用title，否则使用Text(subtitleText)
  final String subtitleText;

  /// 最右边控件，多个时使用row包装，material下请指定宽度
  final Widget trailing;
  final EdgeInsetsGeometry contentPadding;
  final GestureTapCallback onTap;
  final GestureLongPressCallback onLongPress;

  /// 背景色默认白色
  final Color backgroundColor;

  // cupertino
  final Border border;
  final double height;
  final BorderRadius borderRadius;
  final Color splashColor;
  final Color highlightColor;
  final MainAxisAlignment mainAxisAlignment;

  // material
  final bool isThreeLine;
  final bool dense;
  final bool enabled;
  final bool selected;

  double get _defaultTileHeight {
    final bool hasSubtitle = subtitle != null;
    final bool isTwoLine = !isThreeLine && hasSubtitle;
    final bool isOneLine = !isThreeLine && !hasSubtitle;

    if (isOneLine) {
      return dense ? 48.0 : 56.0;
    }
    if (isTwoLine) {
      return dense ? 64.0 : 72.0;
    }
    return dense ? 76.0 : 88.0;
  }

  // final TextStyle _defaultTextStyle = TextStyle(
  //   fontFamily: '.SF UI Text',
  //   fontSize: 16.0,
  //   color: CupertinoColors.black
  // );

  @override
  Widget buildByCupertino(BuildContext context) {
    final List<Widget> rows = <Widget>[];
    final Widget _leading = valueFromCupertino('leading', leading);
    final Widget _trailing = valueFromCupertino('trailing', trailing);
    Widget _title = valueFromCupertino('title', title);
    _title ??= titleText != null
        ? Text(
            valueFromCupertino('titleText', titleText),
          )
        : null;
    Widget _subtitle = valueFromCupertino('subtitle', subtitle);
    _subtitle ??= subtitleText != null
        ? Text(
            valueFromCupertino('subtitleText', subtitleText),
          )
        : null;
    if (_leading != null) {
      rows.add(_leading);
    }
    if (_subtitle != null) {
      rows.add(
        Expanded(
          child: Padding(
            padding: contentPadding ?? EdgeInsets.zero,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                _title,
                _subtitle,
              ],
            ),
          ),
        ),
      );
    } else {
      rows.add(
        Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            child: _title,
          ),
        ),
      );
    }
    if (_trailing != null) {
      rows.add(
        Container(
          alignment: Alignment.centerRight,
          child: _trailing,
        ),
      );
    }
    final Widget content = Container(
      key: key,
      decoration: BoxDecoration(
        border: valueFromCupertino('border', border),
      ),
      padding: valueFromCupertino('contentPadding', contentPadding) ??
          const EdgeInsets.symmetric(horizontal: 10.0),
      child: SizedBox(
        height: height ?? _defaultTileHeight,
        child: Row(
          mainAxisAlignment:
              mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
          children: rows,
        ),
      ),
    );
    return Material(
      key: valueFromCupertino('key', key),
      animationDuration: Duration(milliseconds: 10),
      color: valueFromCupertino('backgroundColor', backgroundColor),
      borderOnForeground: false,
      child: Ink(
        child: InkWell(
          radius: 0.0,
          borderRadius: valueFromCupertino(
                'borderRadius',
                borderRadius,
              ) ??
              BorderRadius.zero,
          child: Semantics(
            child: SafeArea(
              top: false,
              bottom: false,
              child: content,
            ),
          ),
          splashColor:
              splashColor ?? CupertinoTheme.of(context).primaryContrastingColor,
          highlightColor: highlightColor ?? Theme.of(context).highlightColor,
          onTap: onTap,
          onLongPress: onLongPress,
        ),
      ),
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    final Color _backgroundColor = valueFromMaterial(
      'backgroundColor',
      backgroundColor,
    );
    Widget _text = valueFromMaterial('title', title);
    _text ??= titleText != null
        ? Text(
            valueFromMaterial('titleText', titleText),
          )
        : null;
    Widget _subtitle = valueFromMaterial('subtitle', subtitle);
    _subtitle ??= subtitleText != null
        ? Text(
            valueFromMaterial('subtitleText', subtitleText),
          )
        : null;
    final Widget listTile = ListTile(
      key: key,
      leading: valueFromMaterial('leading', leading),
      title: _text,
      subtitle: _subtitle,
      trailing: valueFromMaterial('trailing', trailing),
      isThreeLine: valueFromMaterial('isThreeLine', isThreeLine),
      dense: valueFromMaterial('dense', dense),
      contentPadding: valueFromMaterial('contentPadding', contentPadding),
      enabled: valueFromMaterial('enabled', enabled),
      onTap: valueFromMaterial('onTap', onTap),
      onLongPress: valueFromMaterial('onLongPress', onLongPress),
      selected: valueFromMaterial('selected', selected),
    );
    return _backgroundColor != null
        ? Material(
            color: _backgroundColor,
            child: listTile,
          )
        : listTile;
  }
}
