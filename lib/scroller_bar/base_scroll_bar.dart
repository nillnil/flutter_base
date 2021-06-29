import 'package:flutter/cupertino.dart' show CupertinoScrollbar;
import 'package:flutter/material.dart';

import '../base_stateless_widget.dart';

/// BaseScrollBar
/// use CupertinoScrollbar by cupertino
/// *** use cupertino = { forceUseMaterial: true } force use Scrollbar on cuperitno.
/// use Scrollbar by material
/// *** use material = { forceUseCupertino: true } force use CupertinoScrollbar on material.
///
/// CupertinoScrollbar: 2021.01.20
/// Scrollbar: 2021.03.18
/// modify 2021.06.25 by flutter 2.2.2
class BaseScrollBar extends BaseStatelessWidget {
  const BaseScrollBar({
    Key? key,
    this.controller,
    this.child,
    this.isAlwaysShown = false,
    this.thickness,
    this.thicknessWhileDragging = 8.0,
    this.radius = const Radius.circular(1.5),
    this.radiusWhileDragging = const Radius.circular(4.0),
    this.padding,
    this.notificationPredicate,
    this.showTrackOnHover,
    this.hoverThickness,
    this.interactive,
    Map<String, dynamic>? cupertino,
    Map<String, dynamic>? material,
  }) : super(key: key, cupertino: cupertino, material: material);

  /// *** general properties start ***

  /// [CupertinoScrollbar.controller]
  /// or
  /// [Scrollbar.controller]
  final ScrollController? controller;

  /// [CupertinoScrollbar.child]
  /// or
  /// [Scrollbar.child]
  final Widget? child;

  /// [CupertinoScrollbar.isAlwaysShown]
  /// or
  /// [Scrollbar.isAlwaysShown]
  final bool isAlwaysShown;

  /// [CupertinoScrollbar.thickness]
  /// or
  /// [Scrollbar.thickness]
  final double? thickness;

  /// [CupertinoScrollbar.radius]
  /// or
  /// [Scrollbar.radius]
  final Radius radius;

  /// [MediaQuery.of(context).padding]
  final EdgeInsets? padding;

  /// [CupertinoScrollbar.notificationPredicate]
  /// or
  /// [Scrollbar.notificationPredicate]
  final ScrollNotificationPredicate? notificationPredicate;

  /// *** general properties end ***

  /// *** cupertino properties start ***

  /// [CupertinoScrollbar.defaultThicknessWhileDragging]
  final double thicknessWhileDragging;

  /// [CupertinoScrollbar.defaultRadiusWhileDragging]
  final Radius radiusWhileDragging;

  /// *** cupertino properties end ***

  /// *** material properties start ***

  /// [Scrollbar.showTrackOnHover]
  final bool? showTrackOnHover;

  /// [Scrollbar.hoverThickness]
  final double? hoverThickness;

  /// [Scrollbar.interactive]
  final bool? interactive;

  /// *** material properties end ***

  @override
  Widget buildByCupertino(BuildContext context) {
    final Widget _child = valueFromCupertino('child', child);
    assert(_child != null, 'child can\'t be null');
    final Widget _scrollbar = CupertinoScrollbar(
      controller: valueFromCupertino('controller', controller),
      child: _child,
      isAlwaysShown: valueFromCupertino('isAlwaysShown', isAlwaysShown),
      thickness: valueFromCupertino('thickness', thickness) ?? 3.0,
      thicknessWhileDragging: thicknessWhileDragging,
      radius: valueFromCupertino('radius', radius),
      radiusWhileDragging: radiusWhileDragging,
      notificationPredicate: valueFromCupertino('notificationPredicate', notificationPredicate),
    );
    if (padding != null) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(
          padding: padding,
        ),
        child: _scrollbar,
      );
    }
    return _scrollbar;
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    final Widget? _child = valueFromMaterial('child', child);
    final Widget _scrollbar = Scrollbar(
      child: _child!,
      controller: valueFromMaterial('controller', controller),
      isAlwaysShown: valueFromMaterial('isAlwaysShown', isAlwaysShown),
      showTrackOnHover: valueFromMaterial('showTrackOnHover', showTrackOnHover),
      hoverThickness: valueFromMaterial('hoverThickness', hoverThickness),
      thickness: valueFromMaterial('thickness', thickness),
      radius: valueFromMaterial('radius', radius),
      notificationPredicate: valueFromMaterial('notificationPredicate', notificationPredicate),
      interactive: interactive,
    );
    if (padding != null) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(
          padding: padding,
        ),
        child: _scrollbar,
      );
    }
    return _scrollbar;
  }
}
