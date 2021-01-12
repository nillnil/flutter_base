import 'package:flutter/cupertino.dart' show CupertinoScrollbar;
import 'package:flutter/material.dart';

import '../base_stateless_widget.dart';

/// BaseScrollBar
/// use CupertinoScrollbar by cupertino
/// *** use cupertino = { forceUseMaterial: true } force use Scrollbar on cuperitno.
/// use Scrollbar by material
/// *** use material = { forceUseCupertino: true } force use CupertinoScrollbar on material.
/// 
/// CupertinoScrollbar: 2020.07.17
/// Scrollbar: 2020.07.17
/// modify 2021.01.12 by flutter 1.22.5
class BaseScrollBar extends BaseStatelessWidget {
  const BaseScrollBar({
    Key baseKey,
    this.key,
    this.controller,
    this.child,
    this.isAlwaysShown = false,
    this.thickness,
    this.thicknessWhileDragging,
    this.radius = const Radius.circular(1.5),
    this.radiusWhileDragging = const Radius.circular(4.0),
    this.padding,
    Map<String, dynamic> cupertino,
    Map<String, dynamic> material,
  }) : super(key: baseKey, cupertino: cupertino, material: material);

  @override
  final Key key;

  /// *** cupertino properties start ***
  
  /// [CupertinoScrollbar.defaultThicknessWhileDragging]
  final double thicknessWhileDragging;

  /// [CupertinoScrollbar.defaultRadiusWhileDragging]
  final Radius radiusWhileDragging;

  /// *** cupertino properties end ***

  /// [CupertinoScrollbar.controller]
  /// or
  /// [Scrollbar.controller]
  final ScrollController controller;

  /// [CupertinoScrollbar.child]
  /// or
  /// [Scrollbar.child]
  final Widget child;

  /// [CupertinoScrollbar.isAlwaysShown]
  /// or
  /// [Scrollbar.isAlwaysShown]
  final bool isAlwaysShown;

  /// [CupertinoScrollbar.thickness]
  /// or
  /// [Scrollbar.thickness]
  final double thickness;

  /// [CupertinoScrollbar.radius]
  /// or
  /// [Scrollbar.radius]
  final Radius radius;

  /// [MediaQuery.of(context).padding]
  final EdgeInsets padding;

  @override
  Widget buildByCupertino(BuildContext context) {
    final Widget _child = CupertinoScrollbar(
      key: valueFromCupertino('key', key),
      controller: valueFromCupertino('controller', controller),
      child: child,
      isAlwaysShown: valueFromCupertino('isAlwaysShown', isAlwaysShown),
      thickness: valueFromCupertino('thickness', thickness) ?? 3.0,
      thicknessWhileDragging: thicknessWhileDragging ?? 8.0,
      radius: valueFromCupertino('radius', radius),
      radiusWhileDragging: radiusWhileDragging,
    );
    if (padding != null) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(
          padding: padding,
        ),
        child: _child,
      );
    }
    return _child;
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    if (padding != null) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(
          padding: padding,
        ),
        child: Scrollbar(
          key: valueFromMaterial('key', key),
          child: child,
          controller: valueFromMaterial('controller', controller),
        ),
      );
    }
    return Scrollbar(
      key: valueFromMaterial('key', key),
      child: child,
      controller: valueFromMaterial('controller', controller),
      isAlwaysShown: valueFromMaterial('isAlwaysShown', isAlwaysShown),
      thickness: valueFromMaterial('thickness', thickness),
      radius: valueFromMaterial('radius', radius),
    );
  }
}
