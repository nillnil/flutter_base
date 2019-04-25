import 'package:base/base_stateless_widget.dart';
import 'package:flutter/cupertino.dart' hide RefreshCallback;
import 'package:flutter/material.dart';

/// BaseIndicator
/// use CustomScrollView + CupertinoSliverRefreshControl by cupertino
/// *** use cupertino = { forceUseMaterial: true } force use RefreshIndicator on cuperitno.
/// use RefreshIndicator by material
/// *** use material = { forceUseCupertino: true } force use CupertinoSliverRefreshControl on material.
class BaseRefresh extends BaseStatelessWidget {
  BaseRefresh({
    Key key,
    this.refreshTriggerPullDistance = _defaultRefreshTriggerPullDistance,
    this.refreshIndicatorExtent = _defaultRefreshIndicatorExtent,
    this.builder = CupertinoSliverRefreshControl.buildSimpleRefreshIndicator,
    this.onRefresh,
    this.child,
    this.displacement = 40.0,
    this.color,
    this.backgroundColor,
    this.notificationPredicate = defaultScrollNotificationPredicate,
    Map<String, dynamic> cupertino,
    Map<String, dynamic> material,
  }) : super(key: key, cupertino: cupertino, material: material);

  // general
  final RefreshCallback onRefresh;

  /// It's SliverList on Cupertino，ListView or CustomScrollView on Material
  /// All three can be converted automatically.
  final Widget child;

  // cupertino
  final double refreshTriggerPullDistance;
  final double refreshIndicatorExtent;
  final RefreshControlIndicatorBuilder builder;

  // material
  final double displacement;
  final Color color;
  final Color backgroundColor;
  final ScrollNotificationPredicate notificationPredicate;

  static const double _defaultRefreshTriggerPullDistance = 100.0;
  static const double _defaultRefreshIndicatorExtent = 60.0;

  @override
  Widget buildByCupertino(BuildContext context) {
    Widget _child = child;
    if (child is ListView) {
      // ListView => SliverList
      _child = SliverList(
        delegate: (child as ListView).childrenDelegate,
      );
    } else if (child is CustomScrollView) {
      // CustomScrollView => SliverList
      _child = SliverList(
        delegate: SliverChildListDelegate(
          (child as CustomScrollView).slivers,
        ),
      );
    }
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
    Widget _child = child;
    if (child is SliverList) {
      // SliverList => ListView
      _child = ListView.custom(
        childrenDelegate: (child as SliverList).delegate,
      );
    }
    return RefreshIndicator(
      child: _child,
      displacement: displacement,
      color: color,
      backgroundColor: backgroundColor,
      notificationPredicate: notificationPredicate,
      onRefresh: valueFromMaterial('onRefresh', onRefresh),
    );
  }
}
