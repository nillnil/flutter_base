import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../base_stateless_widget.dart';

/// BaseActionSheetAction
/// use CupertinoActionSheetAction by cupertino
/// *** use cupertino = { forceUseMaterial: true } force use FlatButton on cuperitno.
/// use TextButton by material, must has a Material Widget ancestor
/// *** use material = { forceUseCupertino: true } force use CupertinoActionSheetAction on material.
///
/// CupertinoActionSheetAction: 2021.04.03
/// TextButton: 2021.04.02
/// modify 2021.06.25 by flutter 2.2.2
class BaseActionSheetAction extends BaseStatelessWidget {
  const BaseActionSheetAction({
    Key? key,
    this.onPressed,
    this.child,
    this.isDefaultAction = false,
    this.isDestructiveAction = false,
    Map<String, dynamic>? cupertino,
    Map<String, dynamic>? material,
  }) : super(key: key, cupertino: cupertino, material: material);

  /// *** general properties start ***

  /// [CupertinoActionSheetAction.onPressed]
  final VoidCallback? onPressed;

  /// [CupertinoActionSheetAction.isDefaultAction]
  final bool isDefaultAction;

  /// [CupertinoActionSheetAction.isDestructiveAction]
  final bool isDestructiveAction;

  /// [CupertinoActionSheetAction.child]
  final Widget? child;

  /// *** general properties end ***

  @override
  Widget buildByCupertino(BuildContext context) {
    return CupertinoActionSheetAction(
      onPressed: valueFromCupertino('onPressed', onPressed),
      isDefaultAction: valueFromCupertino('isDefaultAction', isDefaultAction),
      isDestructiveAction: valueFromCupertino(
        'isDestructiveAction',
        isDestructiveAction,
      ),
      child: valueFromCupertino('child', child),
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    final Widget _child = valueFromMaterial('child', child);
    final TextStyle actionStyle =
        (Theme.of(context).textTheme.button ?? const TextStyle()).copyWith(
      inherit: false,
      fontSize: 20.0,
      fontWeight: isDefaultAction ? FontWeight.bold : FontWeight.w400,
      color: isDestructiveAction ? Colors.red : Colors.black,
      textBaseline: TextBaseline.alphabetic,
    );
    return TextButton(
      child: _child,
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(actionStyle),
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 10.0)),
      ),
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        }
      },
    );
  }
}
