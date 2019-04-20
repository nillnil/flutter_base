import 'package:base/base_stateless_widget.dart';
import 'package:flutter/cupertino.dart'
    show CupertinoAlertDialog, ScrollController;
import 'package:flutter/material.dart';

/// 基础弹出框
/// cupertino，使用CupertinoAlertDialog
/// *** 可使用 cupertino = { forceUseMaterial: true } 参数强制使用AlertDialog
/// material，使用AlertDialog
/// *** 可使用 material = { forceUseCupertino: true } CupertinoAlertDialog
class BaseAlertDialog extends BaseStatelessWidget {
  BaseAlertDialog({
    Key key,
    this.title,
    this.content,
    this.actions = const <Widget>[],

    // cupertino
    this.scrollController,
    this.actionScrollController,

    // material
    this.titlePadding,
    this.titleTextStyle,
    this.contentPadding = const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
    this.contentTextStyle,
    this.backgroundColor,
    this.elevation,
    this.semanticLabel,
    this.shape,
    Map<String, Object> cupertino,
    Map<String, Object> material,
  }) : super(key: key, cupertino: cupertino, material: material);

  // general
  final Widget title;
  final Widget content;
  final List<Widget> actions;

  // cupertino
  final ScrollController scrollController;
  final ScrollController actionScrollController;

  // material
  final EdgeInsetsGeometry titlePadding;
  final TextStyle titleTextStyle;
  final EdgeInsetsGeometry contentPadding;
  final TextStyle contentTextStyle;
  final Color backgroundColor;
  final double elevation;
  final String semanticLabel;
  final ShapeBorder shape;

  @override
  Widget buildByCupertino(BuildContext context) {
    return CupertinoAlertDialog(
      title: valueFromCupertino('title', title),
      content: valueFromCupertino('content', content),
      actions: valueFromCupertino('actions', actions),
      scrollController: scrollController,
      actionScrollController: actionScrollController,
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    return AlertDialog(
      title: valueFromMaterial('title', title),
      titleTextStyle: titleTextStyle,
      titlePadding: titlePadding,
      content: valueFromMaterial('content', content),
      contentPadding: contentPadding,
      contentTextStyle: contentTextStyle,
      actions: valueFromMaterial('actions', actions),
      backgroundColor: backgroundColor,
      elevation: elevation,
      semanticLabel: semanticLabel,
      shape: shape,
    );
  }

  Future<T> show<T>(
    BuildContext context, {
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) => build(context),
    );
  }
}
