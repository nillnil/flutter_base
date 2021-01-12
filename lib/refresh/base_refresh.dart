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
/// CustomScrollView + CupertinoSliverRefreshControl: 2020.09.10 + 2020.06.24
/// RefreshIndicator: 2020.06.11
/// modify 2021.01.12 by flutter 1.22.5
class BaseRefresh extends BaseStatelessWidget {
  const BaseRefresh({
    Key baseKey,
    this.key,
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
    Map<String, dynamic> cupertino,
    Map<String, dynamic> material,
  }) : super(key: baseKey, cupertino: cupertino, material: material);

  /// *** general properties start ***

  /// [CupertinoSliverRefreshControl.key]
  /// or
  /// [RefreshIndicator.key]
  @override
  final Key key;

  /// [CupertinoSliverRefreshControl.onRefresh]
  /// or
  /// [RefreshIndicator.onRefresh]
  final RefreshCallback onRefresh;

  /// It's SliverList on Cupertino，ListView or CustomScrollView on Material
  /// All three can be converted automatically.
  ///
  /// [CupertinoSliverRefreshControl.child]
  /// or
  /// [RefreshIndicator.child]
  final Widget child;

  /// *** general properties end ***

  /// *** cupertino properties start ***

  /// [CupertinoSliverRefreshControl.refreshTriggerPullDistance]
  final double refreshTriggerPullDistance;

  /// [CupertinoSliverRefreshControl.refreshIndicatorExtent]
  final double refreshIndicatorExtent;

  /// [CupertinoSliverRefreshControl.builder]
  final RefreshControlIndicatorBuilder builder;

  /// [SliverPadding.padding]
  final EdgeInsetsGeometry padding;

  /// *** cupetino properties end ***

  /// *** material properties start ***

  /// [RefreshIndicator.displacement]
  final double displacement;

  /// [RefreshIndicator.color]
  final Color color;

  /// [RefreshIndicator.backgroundColor]
  final Color backgroundColor;

  /// [RefreshIndicator.notificationPredicate]
  final ScrollNotificationPredicate notificationPredicate;

  /// [RefreshIndicator.semanticsLabel]
  final String semanticsLabel;

  /// [RefreshIndicator.semanticsValue]
  final String semanticsValue;

  /// [RefreshIndicator.strokeWidth]
  final double strokeWidth;

  /// *** material properties end ***

  /// [CupertinoSliverRefreshControl]'s _defaultRefreshTriggerPullDistance
  static const double _defaultRefreshTriggerPullDistance = 100.0;

  /// [CupertinoSliverRefreshControl]'s _defaultRefreshIndicatorExtent
  static const double _defaultRefreshIndicatorExtent = 60.0;

  @override
  Widget buildByCupertino(BuildContext context) {
    Widget _child = child;
    if (child is ListView) {
      // ListView => SliverList
      final ListView listView = child;
      _child = SliverList(
        delegate: listView.childrenDelegate,
      );
    } else if (child is CustomScrollView) {
      // CustomScrollView => SliverList
      final CustomScrollView customScrollView = child;
      _child = SliverList(
        delegate: SliverChildListDelegate(
          customScrollView.slivers,
        ),
      );
    } else if (child is BoxScrollView) {
      final BoxScrollView boxScrollView = child;
      _child = SliverToBoxAdapter(
        child: boxScrollView,
      );
    }
    _child = buildSlivers(context, _child);
    return CustomScrollView(
      key: valueFromCupertino('key', key),
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
    Widget _child = child;
    if (child is SliverList) {
      // SliverList => ListView
      final SliverList sliverList = child;
      _child = ListView.custom(
        childrenDelegate: sliverList.delegate,
      );
    }
    return RefreshIndicator(
      key: valueFromMaterial('key', key),
      child: _child,
      displacement: displacement,
      color: color,
      backgroundColor: backgroundColor,
      notificationPredicate: notificationPredicate,
      semanticsLabel: semanticsLabel,
      semanticsValue: semanticsValue,
      strokeWidth: strokeWidth,
      onRefresh: valueFromMaterial('onRefresh', onRefresh),
    );
  }

  Widget buildSlivers(BuildContext context, Widget child) {
    EdgeInsetsGeometry effectivePadding = padding;
    if (padding == null) {
      final MediaQueryData mediaQuery = MediaQuery.of(context, nullOk: true);
      if (mediaQuery != null) {
        effectivePadding = mediaQuery.padding.copyWith(left: 0.0, right: 0.0);
        child = MediaQuery(
          data: mediaQuery.copyWith(
            padding: effectivePadding,
          ),
          child: child,
        );
      }
    }

    if (effectivePadding != null) {
      child = SliverPadding(padding: effectivePadding, sliver: child);
    }
    return child;
  }
}
