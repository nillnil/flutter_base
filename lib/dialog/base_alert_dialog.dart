import 'package:flutter/cupertino.dart'
    show CupertinoAlertDialog, ScrollController;
import 'package:flutter/material.dart';

import '../base_stateless_widget.dart';

/// BaseAlertDialog
/// use CupertinoAlertDialog by cupertino
/// *** use cupertino = { forceUseMaterial: true } force use AlertDialog on cuperitno.
/// use AlertDialog by material
/// *** use material = { forceUseCupertino: true } force use CupertinoAlertDialog on material.
class BaseAlertDialog extends BaseStatelessWidget {
  const BaseAlertDialog({
    Key baseKey,
    this.key,
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
    Map<String, dynamic> cupertino,
    Map<String, dynamic> material,
  }) : super(key: baseKey, cupertino: cupertino, material: material);

  /// *** general properties start ***

  @override
  final Key key;

  /// [CupertinoAlertDialog.title]
  /// or
  /// [AlertDialog.title]
  final Widget title;

  /// [CupertinoAlertDialog.content]
  /// or
  /// [AlertDialog.content]
  final Widget content;

  /// [CupertinoAlertDialog.actions]
  /// or
  /// [AlertDialog.actions]
  final List<Widget> actions;

  /// *** general properties end ***

  /// *** cupertino properties start ***

  /// [CupertinoAlertDialog.scrollController]
  final ScrollController scrollController;

  /// [CupertinoAlertDialog.actionScrollController]
  final ScrollController actionScrollController;

  /// *** cupertino properties end ***

  /// *** material properties start ***

  /// [AlertDialog.titlePadding]
  final EdgeInsetsGeometry titlePadding;

  /// [AlertDialog.titleTextStyle]
  final TextStyle titleTextStyle;

  /// [AlertDialog.contentPadding]
  final EdgeInsetsGeometry contentPadding;

  /// [AlertDialog.contentTextStyle]
  final TextStyle contentTextStyle;

  /// [AlertDialog.backgroundColor]
  final Color backgroundColor;

  /// [AlertDialog.elevation]
  final double elevation;

  /// [AlertDialog.semanticLabel]
  final String semanticLabel;

  /// [AlertDialog.shape]
  final ShapeBorder shape;

  /// *** material properties end ***

  @override
  Widget buildByCupertino(BuildContext context) {
    return CupertinoAlertDialog(
      key: valueFromCupertino('key', key),
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
      key: valueFromMaterial('key', key),
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

  /// [showDialog]
  Future<T> show<T>(
    BuildContext context, {
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) => build(context),
    );
  }
}

/// [showDialog]
Future<T> showBaseAlertDialog<T>(
  BaseAlertDialog alertDialog,
  BuildContext context, {
  bool barrierDismissible = true,
}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) => alertDialog,
  );
}
