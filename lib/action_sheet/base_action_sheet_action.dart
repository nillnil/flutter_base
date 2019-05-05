import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../base_stateless_widget.dart';

/// BaseAppBar
/// use CupertinoActionSheetAction by cupertino
/// *** use cupertino = { forceUseMaterial: true } force use FlatButton on cuperitno.
/// use InkWell by material, must has a Material Widget ancestor
/// *** use material = { forceUseCupertino: true } force use CupertinoActionSheetAction on material.
class BaseActionSheetAction extends BaseStatelessWidget {
  BaseActionSheetAction({
    Key baseKey,
    this.key,
    this.onPressed,
    this.child,
    this.isDefaultAction = false,
    this.isDestructiveAction = false,
    Map<String, dynamic> cupertino,
    Map<String, dynamic> material,
  }) : super(key: baseKey, cupertino: cupertino, material: material);

  /// *** general properties start ***
  @override
  final Key key;

  /// [CupertinoActionSheetAction.onPressed]
  final VoidCallback onPressed;

  /// [CupertinoActionSheetAction.isDefaultAction]
  final bool isDefaultAction;

  /// [CupertinoActionSheetAction.isDestructiveAction]
  final bool isDestructiveAction;

  /// [CupertinoActionSheetAction.child]
  final Widget child;

  /// *** general properties end ***

  @override
  Widget buildByCupertino(BuildContext context) {
    return CupertinoActionSheetAction(
      child: valueFromCupertino('child', child),
      onPressed: valueFromCupertino('onPressed', onPressed),
      isDefaultAction: valueFromCupertino('isDefaultAction', isDefaultAction),
      isDestructiveAction: valueFromCupertino(
        'isDestructiveAction',
        isDestructiveAction,
      ),
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    Widget child = valueFromMaterial('child', this.child);
    final TextStyle actionStyle = Theme.of(context).textTheme.button.copyWith(
          inherit: false,
          fontSize: 20.0,
          fontWeight: FontWeight.w400,
          color: Colors.black,
          textBaseline: TextBaseline.alphabetic,
        );
    child = DefaultTextStyle(
      style: actionStyle.copyWith(
        fontWeight: isDefaultAction ? FontWeight.bold : actionStyle.fontWeight,
        color: isDestructiveAction ? Colors.red : actionStyle.color,
      ),
      child: child,
    );
    return FlatButton(
      child: child,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      onPressed: () {
        if (onPressed != null) {
          onPressed();
        }
      },
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
