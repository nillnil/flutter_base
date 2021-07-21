import 'package:flutter/cupertino.dart' show CupertinoScrollbar;
import 'package:flutter/material.dart';

import '../base_param.dart';
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
    BaseParam? baseParam,
  }) : super(key: key, baseParam: baseParam);

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
    final Widget _child = valueOf('child', child);
    assert(_child != null, 'child can\'t be null');
    final Widget _scrollbar = CupertinoScrollbar(
      controller: valueOf('controller', controller),
      child: _child,
      isAlwaysShown: valueOf('isAlwaysShown', isAlwaysShown),
      thickness: valueOf('thickness', thickness) ?? 3.0,
      thicknessWhileDragging: valueOf('thicknessWhileDragging', thicknessWhileDragging),
      radius: valueOf('radius', radius),
      radiusWhileDragging: valueOf('radiusWhileDragging', radiusWhileDragging),
      notificationPredicate: valueOf('notificationPredicate', notificationPredicate),
    );
    return _buildWidget(context, _scrollbar);
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    final Widget? _child = valueOf('child', child);
    final Widget _scrollbar = Scrollbar(
      child: _child!,
      controller: valueOf('controller', controller),
      isAlwaysShown: valueOf('isAlwaysShown', isAlwaysShown),
      showTrackOnHover: valueOf('showTrackOnHover', showTrackOnHover),
      hoverThickness: valueOf('hoverThickness', hoverThickness),
      thickness: valueOf('thickness', thickness),
      radius: valueOf('radius', radius),
      notificationPredicate: valueOf('notificationPredicate', notificationPredicate),
      interactive: valueOf('interactive', interactive),
    );
    return _buildWidget(context, _scrollbar);
  }

  Widget _buildWidget(BuildContext context, Widget scrollbar) {
    final EdgeInsets? _padding = valueOf('padding', padding);
    if (_padding != null) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(
          padding: _padding,
        ),
        child: scrollbar,
      );
    }
    return scrollbar;
  }
}
