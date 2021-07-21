import 'package:flutter/cupertino.dart' show CupertinoTheme;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../base_param.dart';
import '../base_stateless_widget.dart';
import '../theme/base_theme.dart';
import '../theme/base_theme_data.dart';

/// BaseTile
/// use custom InkWell by cupertino
/// *** use cupertino = { forceUseMaterial: true } force use ListTile on cuperitno.
/// use ListTile by material
/// *** use material = { forceUseCupertino: true } force use custom InkWell on material.
class BaseTile extends BaseStatelessWidget {
  const BaseTile({
    Key? key,
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
    this.child,
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
    BaseParam? baseParam,
  }) : super(key: key, baseParam: baseParam);

  /// *** general properties start ***

  /// [ListTile.leading]
  final Widget? leading;

  /// [ListTile.title]
  final Widget? title;

  /// When [title != null] will use [title]，else use Text(titleText)
  final String? titleText;

  /// [ListTile.subtitle]
  final Widget? subtitle;

  /// When [subtitleText != null] will use [title]，else use Text(titleText)
  final String? subtitleText;

  /// [ListTile.trailing]
  /// 多个时使用row包装，material下请指定宽度
  final Widget? trailing;

  /// [ListTile.contentPadding]
  final EdgeInsetsGeometry? contentPadding;

  /// [ListTile.onTap]
  final GestureTapCallback? onTap;

  /// [ListTile.onLongPress]
  final GestureLongPressCallback? onLongPress;

  /// default is [BaseTheme.baseTileBackgroundColor]
  final Color? backgroundColor;

  /// child != null, title, subTitle, leading, trailing will not be use.
  /// child 不为null时，直接使用child，title、subtitle、leading、trailing将失效。
  final Widget? child;

  /// *** general properties end ***

  /// *** cupertino properties start ***

  final Border? border;
  final double? height;
  final BorderRadius? borderRadius;
  final Color splashColor;
  final Color highlightColor;
  final MainAxisAlignment? mainAxisAlignment;

  /// *** cupertino properties end ***

  /// *** material properties start ***

  /// [ListTile.isThreeLine]
  final bool isThreeLine;

  /// [ListTile.dense]
  final bool dense;

  /// [ListTile.enabled]
  final bool enabled;

  /// [ListTile.onLongselectedPress]
  final bool selected;

  /// *** material properties end ***

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

  @override
  Widget buildByCupertino(BuildContext context) {
    final Widget _child = _buildContent();
    final CupertinoThemeData cupertinoTheme = CupertinoTheme.of(context);
    final Widget content = Container(
      key: key,
      decoration: BoxDecoration(
        border: valueOf('border', border),
      ),
      padding: valueOf('contentPadding', contentPadding) ?? const EdgeInsets.symmetric(horizontal: 10.0),
      child: DefaultTextStyle(
        style: cupertinoTheme.textTheme.textStyle.copyWith(fontSize: 16.0),
        child: _child,
      ),
    );
    final BaseThemeData _baaseTheme = BaseTheme.of(context);
    Color? _backgroundColor = valueOf('backgroundColor', backgroundColor) ?? _baaseTheme.tileBackgroundColor;
    if (_backgroundColor != null) {
      if (_backgroundColor is CupertinoDynamicColor) {
        _backgroundColor = _backgroundColor.resolveFrom(context);
      }
    } else {
      _backgroundColor = CupertinoColors.secondarySystemGroupedBackground.resolveFrom(context);
    }
    return Material(
      animationDuration: const Duration(milliseconds: 10),
      color: _backgroundColor,
      borderOnForeground: false,
      child: Ink(
        child: InkWell(
          radius: 0.0,
          borderRadius: valueOf(
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
          splashColor: valueOf('splashColor', splashColor),
          highlightColor: valueOf('highlightColor', highlightColor),
          onTap: valueOf('onTap', onTap),
          onLongPress: valueOf('onLongPress', onLongPress),
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
      ),
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    final BaseThemeData _baseTheme = BaseTheme.of(context);
    final Color _backgroundColor = valueOf('backgroundColor', backgroundColor) ?? _baseTheme.tileBackgroundColor ?? Theme.of(context).cardColor;
    Widget? _text = valueOf('title', title);
    _text ??= titleText != null
        ? Text(
            valueOf('titleText', titleText),
          )
        : null;
    Widget? _subtitle = valueOf('subtitle', subtitle);
    _subtitle ??= subtitleText != null
        ? Text(
            valueOf('subtitleText', subtitleText),
          )
        : null;
    final Widget listTile = ListTile(
      leading: valueOf('leading', leading),
      title: _text,
      subtitle: _subtitle,
      trailing: valueOf('trailing', trailing),
      isThreeLine: valueOf('isThreeLine', isThreeLine),
      dense: valueOf('dense', dense),
      contentPadding: valueOf('contentPadding', contentPadding),
      enabled: valueOf('enabled', enabled),
      onTap: valueOf('onTap', onTap),
      onLongPress: valueOf('onLongPress', onLongPress),
      selected: valueOf('selected', selected),
    );
    return _backgroundColor != null
        ? Material(
            color: _backgroundColor,
            child: listTile,
          )
        : listTile;
  }

  Widget _buildContent() {
    final Widget? _child = valueOf('child', child);
    if (_child != null) {
      return _child;
    }
    final List<Widget> rows = <Widget>[];
    final Widget? _leading = valueOf('leading', leading);
    final Widget? _trailing = valueOf('trailing', trailing);
    Widget? _title = valueOf('title', title);
    final String? _titleText = valueOf('titleText', titleText);
    _title ??= _titleText != null ? Text(_titleText) : null;
    Widget? _subtitle = valueOf('subtitle', subtitle);
    final String? _subtitleText = valueOf('subtitleText', subtitleText);
    _subtitle ??= subtitleText != null ? Text(_subtitleText!) : null;
    if (_leading != null) {
      rows.add(_leading);
    }
    if (_subtitle != null) {
      rows.add(
        Expanded(
          child: Padding(
            padding: valueOf('contentPadding', contentPadding) ?? EdgeInsets.zero,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                _title!,
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
    return SizedBox(
      height: height ?? _defaultTileHeight,
      child: Row(
        mainAxisAlignment: valueOf('mainAxisAlignment', mainAxisAlignment) ?? MainAxisAlignment.spaceBetween,
        children: rows,
      ),
    );
  }
}
