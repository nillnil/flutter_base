import 'package:flutter/cupertino.dart'
    show CupertinoAlertDialog, ScrollController;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../base_stateless_widget.dart';

/// BaseAlertDialog
/// use CupertinoAlertDialog by cupertino
/// *** use cupertino = { forceUseMaterial: true } force use AlertDialog on cuperitno.
/// use AlertDialog by material
/// *** use material = { forceUseCupertino: true } force use CupertinoAlertDialog on material.
class BaseAlertDialog extends BaseStatelessWidget {
  BaseAlertDialog({
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

  // general
  @override
  final Key key;
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
