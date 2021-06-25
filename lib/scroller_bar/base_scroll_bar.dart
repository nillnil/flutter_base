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
    final Widget _child = CupertinoScrollbar(
      controller: valueFromCupertino('controller', controller),
      child: valueFromCupertino('child', child),
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
        child: _child,
      );
    }
    return _child;
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    final ScrollController? _controller = valueFromMaterial('controller', controller);
    final Widget? _child = valueFromMaterial('child', child);
    assert(_child != null, 'child can\'t be null');
    final bool? _isAlwaysShown = valueFromMaterial('isAlwaysShown', isAlwaysShown);
    final bool? _showTrackOnHover = valueFromMaterial('showTrackOnHover', showTrackOnHover);
    final double? _hoverThickness = valueFromMaterial('hoverThickness', hoverThickness);
    final double? _thickness = valueFromMaterial('thickness', thickness);
    final Radius? _radius = valueFromMaterial('radius', radius);
    final ScrollNotificationPredicate? _notificationPredicate = valueFromMaterial('notificationPredicate', notificationPredicate);
    if (padding != null) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(
          padding: padding,
        ),
        child: Scrollbar(
          child: _child!,
          controller: _controller,
          isAlwaysShown: _isAlwaysShown,
          showTrackOnHover: _showTrackOnHover,
          hoverThickness: _hoverThickness,
          thickness: _thickness,
          radius: _radius,
          notificationPredicate: _notificationPredicate,
          interactive: interactive,
        ),
      );
    }
    return Scrollbar(
      child: _child!,
      controller: _controller,
      isAlwaysShown: _isAlwaysShown,
      showTrackOnHover: _showTrackOnHover,
      hoverThickness: _hoverThickness,
      thickness: _thickness,
      radius: _radius,
      notificationPredicate: _notificationPredicate,
      interactive: interactive,
    );
  }
}
