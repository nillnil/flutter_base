import 'package:base/base_stateless_widget.dart';
import 'package:flutter/cupertino.dart' hide RefreshCallback;
import 'package:flutter/material.dart';

class BaseRefresh extends BaseStatelessWidget {
  // general
  final RefreshCallback onRefresh;
  // cupertino接收的是SliverList，material接收的是ListView / CustomScrollView
  // 这3种都可以，会自动转换
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
    Map<String, Object> cupertino,
    Map<String, Object> material,
  }) : super(cupertino: cupertino, material: material);

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
        delegate: SliverChildListDelegate((child as CustomScrollView).slivers),
      );
    }
    return CustomScrollView(slivers: <Widget>[
      CupertinoSliverRefreshControl(
        key: valueFromCupertino('key', key),
        refreshTriggerPullDistance: refreshTriggerPullDistance,
        refreshIndicatorExtent: refreshIndicatorExtent,
        builder: builder,
        onRefresh: valueFromCupertino('onRefresh', onRefresh),
      ),
      _child
    ]);
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
      key: valueFromMaterial('key', key),
      child: _child,
      displacement: displacement,
      color: color,
      backgroundColor: backgroundColor,
      notificationPredicate: notificationPredicate,
      onRefresh: valueFromMaterial('onRefresh', onRefresh),
    );
  }
}
