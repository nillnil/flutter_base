import 'package:flutter/cupertino.dart' hide RefreshCallback;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../base_stateless_widget.dart';

/// BaseIndicator
/// use CustomScrollView + CupertinoSliverRefreshControl by cupertino
/// *** use cupertino = { forceUseMaterial: true } force use RefreshIndicator on cuperitno.
/// use RefreshIndicator by material
/// *** use material = { forceUseCupertino: true } force use CupertinoSliverRefreshControl on material.
///
/// CustomScrollView + CupertinoSliverRefreshControl: 2021.04.03 + 2021.04.07
/// RefreshIndicator: 2021.03.31
/// modify 2021.06.25 by flutter 2.2.2
class BaseRefresh extends BaseStatelessWidget {
  const BaseRefresh({
    Key? key,
    this.refreshTriggerPullDistance = _defaultRefreshTriggerPullDistance,
    this.refreshIndicatorExtent = _defaultRefreshIndicatorExtent,
    this.builder = CupertinoSliverRefreshControl.buildRefreshIndicator,
    this.onRefresh,
    this.child,
    this.padding,
    this.displacement = 40.0,
    this.color,
    this.backgroundColor,
    this.notificationPredicate = defaultScrollNotificationPredicate,
    this.semanticsLabel,
    this.semanticsValue,
    this.strokeWidth = 2.0,
    this.triggerMode = RefreshIndicatorTriggerMode.onEdge,
    this.edgeOffset = 0.0,
    Map<String, dynamic>? cupertino,
    Map<String, dynamic>? material,
  }) : super(key: key, cupertino: cupertino, material: material);

  /// *** general properties start ***

  /// [CupertinoSliverRefreshControl.onRefresh]
  /// or
  /// [RefreshIndicator.onRefresh]
  final RefreshCallback? onRefresh;

  /// Typically a [SliverList] or [ListView] or [CustomScrollView] or [BoxScrollView] on cupertino's mode
  /// Typically a [ListView] or [CustomScrollView] on materila's mode
  /// All three can be converted automatically.
  ///
  /// [CupertinoSliverRefreshControl.child]
  /// or
  /// [RefreshIndicator.child]
  final Widget? child;

  /// *** general properties end ***

  /// *** cupertino properties start ***

  /// [CupertinoSliverRefreshControl.refreshTriggerPullDistance]
  final double refreshTriggerPullDistance;

  /// [CupertinoSliverRefreshControl.refreshIndicatorExtent]
  final double refreshIndicatorExtent;

  /// [CupertinoSliverRefreshControl.builder]
  final RefreshControlIndicatorBuilder builder;

  /// [SliverPadding.padding]
  final EdgeInsetsGeometry? padding;

  /// *** cupetino properties end ***

  /// *** material properties start ***

  /// [RefreshIndicator.displacement]
  final double displacement;

  /// [RefreshIndicator.color]
  final Color? color;

  /// [RefreshIndicator.backgroundColor]
  final Color? backgroundColor;

  /// [RefreshIndicator.notificationPredicate]
  final ScrollNotificationPredicate notificationPredicate;

  /// [RefreshIndicator.semanticsLabel]
  final String? semanticsLabel;

  /// [RefreshIndicator.semanticsValue]
  final String? semanticsValue;

  /// [RefreshIndicator.strokeWidth]
  final double strokeWidth;

  /// [RefreshIndicator.triggerMode]
  final RefreshIndicatorTriggerMode triggerMode;

  /// [RefreshIndicator.edgeOffset]
  final double edgeOffset;

  /// *** material properties end ***

  /// [CupertinoSliverRefreshControl]'s _defaultRefreshTriggerPullDistance
  static const double _defaultRefreshTriggerPullDistance = 100.0;

  /// [CupertinoSliverRefreshControl]'s _defaultRefreshIndicatorExtent
  static const double _defaultRefreshIndicatorExtent = 60.0;

  @override
  Widget buildByCupertino(BuildContext context) {
    Widget? _child = valueFromCupertino('child', child);
    assert(_child != null, 'child can\'t be null.');
    if (_child is ListView) {
      // ListView => SliverList
      _child = SliverList(
        delegate: _child.childrenDelegate,
      );
    } else if (_child is CustomScrollView) {
      // CustomScrollView => SliverList
      _child = SliverList(
        delegate: SliverChildListDelegate(
          _child.slivers,
        ),
      );
    } else if (_child is BoxScrollView) {
      _child = SliverToBoxAdapter(
        child: _child,
      );
    }
    _child = buildSlivers(context, _child!);
    return CustomScrollView(
      slivers: <Widget>[
        CupertinoSliverRefreshControl(
          refreshTriggerPullDistance: refreshTriggerPullDistance,
          refreshIndicatorExtent: refreshIndicatorExtent,
          builder: builder,
          onRefresh: valueFromCupertino('onRefresh', onRefresh),
        ),
        _child,
      ],
    );
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    Widget _child = valueFromMaterial('child', child);
    assert(_child != null, 'child can\'t be null.');
    if (_child is SliverList) {
      // SliverList => ListView
      _child = ListView.custom(
        childrenDelegate: _child.delegate,
      );
    }
    return RefreshIndicator(
      child: _child,
      displacement: displacement,
      edgeOffset: edgeOffset,
      onRefresh: valueFromMaterial('onRefresh', onRefresh),
      color: color,
      backgroundColor: backgroundColor,
      notificationPredicate: notificationPredicate,
      semanticsLabel: semanticsLabel,
      semanticsValue: semanticsValue,
      strokeWidth: strokeWidth,
      triggerMode: triggerMode,
    );
  }

  Widget buildSlivers(BuildContext context, Widget child) {
    if (padding == null) {
      final MediaQueryData? mediaQuery = MediaQuery.maybeOf(context);
      final EdgeInsets? effectivePadding = mediaQuery?.padding.copyWith(left: 0.0, right: 0.0);
      if (mediaQuery != null) {
        child = MediaQuery(
          data: mediaQuery.copyWith(
            padding: effectivePadding,
          ),
          child: child,
        );
      }
    } else {
      child = SliverPadding(padding: padding!, sliver: child);
    }
    return child;
  }
}
