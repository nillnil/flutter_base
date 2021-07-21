import 'package:flutter/cupertino.dart' show CupertinoAlertDialog, ScrollController;
import 'package:flutter/material.dart';

import '../base_param.dart';
import '../base_stateless_widget.dart';

/// BaseAlertDialog
/// use CupertinoAlertDialog by cupertino
/// *** use cupertino = { forceUseMaterial: true } force use AlertDialog on cuperitno.
/// use AlertDialog by material
/// *** use material = { forceUseCupertino: true } force use CupertinoAlertDialog on material.
///
/// CupertinoAlertDialog: 2021.03.30
/// AlertDialog: 2021.03.31
/// modify 2021.06.25 by flutter 2.2.2
class BaseAlertDialog extends BaseStatelessWidget {
  const BaseAlertDialog({
    Key? key,
    this.title,
    this.content,
    this.actions = const <Widget>[],

    // cupertino
    this.scrollController,
    this.actionScrollController,
    this.insetAnimationDuration = const Duration(milliseconds: 100),
    this.insetAnimationCurve = Curves.decelerate,

    // material
    this.titlePadding,
    this.titleTextStyle,
    this.contentPadding = const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
    this.contentTextStyle,
    this.backgroundColor,
    this.actionsPadding = EdgeInsets.zero,
    this.actionsOverflowDirection,
    this.actionsOverflowButtonSpacing,
    this.buttonPadding,
    this.elevation,
    this.semanticLabel,
    this.insetPadding = const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
    this.clipBehavior = Clip.none,
    this.shape,
    this.scrollable = false,
    BaseParam? baseParam,
  }) : super(key: key, baseParam: baseParam);

  /// *** general properties start ***

  /// [CupertinoAlertDialog.title]
  /// or
  /// [AlertDialog.title]
  final Widget? title;

  /// [CupertinoAlertDialog.content]
  /// or
  /// [AlertDialog.content]
  final Widget? content;

  /// [CupertinoAlertDialog.actions]
  /// or
  /// [AlertDialog.actions]
  final List<Widget> actions;

  /// *** general properties end ***

  /// *** cupertino properties start ***

  /// [CupertinoAlertDialog.scrollController]
  final ScrollController? scrollController;

  /// [CupertinoAlertDialog.actionScrollController]
  final ScrollController? actionScrollController;

  /// [CupertinoAlertDialog.insetAnimationDuration]
  final Duration insetAnimationDuration;

  /// [CupertinoAlertDialog.insetAnimationCurve]
  final Curve insetAnimationCurve;

  /// *** cupertino properties end ***

  /// *** material properties start ***

  /// [AlertDialog.titlePadding]
  final EdgeInsetsGeometry? titlePadding;

  /// [AlertDialog.titleTextStyle]
  final TextStyle? titleTextStyle;

  /// [AlertDialog.contentPadding]
  final EdgeInsetsGeometry contentPadding;

  /// [AlertDialog.contentTextStyle]
  final TextStyle? contentTextStyle;

  /// [AlertDialog.backgroundColor]
  final Color? backgroundColor;

  /// [AlertDialog.actionsPadding]
  final EdgeInsetsGeometry actionsPadding;

  /// [AlertDialog.actionsOverflowDirection]
  final VerticalDirection? actionsOverflowDirection;

  /// [AlertDialog.actionsOverflowButtonSpacing]
  final double? actionsOverflowButtonSpacing;

  /// [AlertDialog.buttonPadding]
  final EdgeInsetsGeometry? buttonPadding;

  /// [AlertDialog.elevation]
  final double? elevation;

  /// [AlertDialog.semanticLabel]
  final String? semanticLabel;

  /// [AlertDialog.insetPadding]
  final EdgeInsets insetPadding;

  /// [AlertDialog.clipBehavior]
  final Clip clipBehavior;

  /// [AlertDialog.shape]
  final ShapeBorder? shape;

  /// [AlertDialog.scrollable]
  final bool scrollable;

  /// *** material properties end ***

  @override
  Widget buildByCupertino(BuildContext context) {
    return CupertinoAlertDialog(
      title: valueOf('title', title),
      content: valueOf('content', content),
      actions: valueOf('actions', actions),
      scrollController: valueOf('scrollController', scrollController),
      actionScrollController: valueOf('actionScrollController', actionScrollController),
      insetAnimationDuration: valueOf('insetAnimationDuration', insetAnimationDuration),
      insetAnimationCurve: valueOf('insetAnimationCurve', insetAnimationCurve),
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    return AlertDialog(
      title: valueOf('title', title),
      titlePadding: valueOf('titlePadding', titlePadding),
      titleTextStyle: valueOf('titleTextStyle', titleTextStyle),
      content: valueOf('content', content),
      contentPadding: valueOf('contentPadding', contentPadding),
      contentTextStyle: valueOf('contentTextStyle', contentTextStyle),
      actions: valueOf('actions', actions),
      actionsPadding: valueOf('actionsPadding', actionsPadding),
      actionsOverflowDirection: valueOf('actionsOverflowDirection', actionsOverflowDirection),
      actionsOverflowButtonSpacing: valueOf('actionsOverflowButtonSpacing', actionsOverflowButtonSpacing),
      buttonPadding: valueOf('buttonPadding', buttonPadding),
      backgroundColor: valueOf('backgroundColor', backgroundColor),
      elevation: valueOf('elevation', elevation),
      semanticLabel: valueOf('semanticLabel', semanticLabel),
      insetPadding: valueOf('insetPadding', insetPadding),
      clipBehavior: valueOf('clipBehavior', clipBehavior),
      shape: valueOf('shape', shape),
      scrollable: valueOf('scrollable', scrollable),
    );
  }

  /// [showDialog]
  Future<T?> show<T>(
    BuildContext context, {
    bool barrierDismissible = true,
    Color? barrierColor = Colors.black54,
    String? barrierLabel,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
  }) {
    return showDialog<T>(
      context: context,
      builder: (_) => this,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      barrierLabel: barrierLabel,
      useSafeArea: useSafeArea,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
    );
  }
}

/// [showDialog]
Future<T?> showBaseAlertDialog<T>(
  BaseAlertDialog alertDialog,
  BuildContext context, {
  bool barrierDismissible = true,
  Color? barrierColor = Colors.black54,
  String? barrierLabel,
  bool useSafeArea = true,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
}) {
  return showDialog<T>(
    context: context,
    builder: (BuildContext context) => alertDialog,
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor,
    barrierLabel: barrierLabel,
    useSafeArea: useSafeArea,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
  );
}
