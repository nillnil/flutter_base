import 'package:flutter/cupertino.dart' show CupertinoDialogAction;
import 'package:flutter/material.dart';

import '../base_param.dart';
import '../base_stateless_widget.dart';

/// BaseDialogAction
/// use CupertinoDialogAction by cupertino
/// *** use cupertino = { forceUseMaterial: true } force use TextButton on cuperitno.
/// use TextButton by material
/// *** use material = { forceUseCupertino: true } force use CupertinoDialogAction on material.
///
/// CupertinoAlertDialog: 2021.03.30
/// TextButton: 2021.04.02
/// modify 2021.06.25 by flutter 2.2.2
class BaseDialogAction extends BaseStatelessWidget {
  const BaseDialogAction({
    Key? key,
    this.onPressed,
    this.isDefaultAction = false,
    this.isDestructiveAction = false,
    this.textStyle,
    this.child,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    this.style,
    this.onLongPress,
    BaseParam? baseParam,
  }) : super(key: key, baseParam: baseParam);

  /// *** general properties start ***

  /// [CupertinoDialogAction.onPressed]
  /// or
  /// [TextButton.onPressed]
  final VoidCallback? onPressed;

  /// [CupertinoDialogAction.onPressed]
  /// or
  /// [TextButton.child]
  final Widget? child;

  /// *** general properties end ***

  /// *** cupertino properties start ***

  /// [CupertinoDialogAction.isDefaultAction]
  final bool isDefaultAction;

  /// [CupertinoDialogAction.isDestructiveAction]
  final bool isDestructiveAction;

  /// [CupertinoDialogAction.textStyle]
  final TextStyle? textStyle;

  /// *** cupertino properties end ***

  /// *** material properties start ***

  /// [ButtonStyleButton.clipBehavior]
  final Clip clipBehavior;

  /// [ButtonStyleButton.focusNode]
  final FocusNode? focusNode;

  /// [ButtonStyleButton.autofocus]
  final bool autofocus;

  /// [ButtonStyleButton.onLongPress]
  final VoidCallback? onLongPress;

  /// [ButtonStyleButton.style]
  final ButtonStyle? style;

  /// *** material properties end ***

  @override
  Widget buildByCupertino(BuildContext context) {
    return CupertinoDialogAction(
      onPressed: valueOf('onPressed', onPressed),
      isDefaultAction: valueOf('isDefaultAction', isDefaultAction),
      isDestructiveAction: valueOf('isDestructiveAction', isDestructiveAction),
      textStyle: valueOf('textStyle', textStyle),
      child: valueOf('child', child),
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    return TextButton(
      onPressed: valueOf('onPressed', onPressed),
      onLongPress: valueOf('onLongPress', onLongPress),
      style: valueOf('style', style),
      focusNode: valueOf('focusNode', focusNode),
      autofocus: valueOf('autofocus', autofocus),
      clipBehavior: valueOf('clipBehavior', clipBehavior),
      child: valueOf('child', child),
    );
  }
}
