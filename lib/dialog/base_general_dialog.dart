import 'package:base/base_stateless_widget.dart';
import 'package:base/platform/platform.dart';
import 'package:flutter/material.dart';

class BaseGeneralDialog extends BaseStatelessWidget {
  BaseGeneralDialog({
    Key key,
    this.barrierDismissible = true,
    this.barrierLabel = '',
    this.barrierColor = Colors.black54,
    this.transitionDuration,
    this.pageBuilder,
    this.child,
    this.transitionBuilder,
    this.useSafeArea = false,
    Map<String, Object> cupertino,
    Map<String, Object> material,
  }) : super(key: key, cupertino: cupertino, material: material);

  final bool barrierDismissible;
  final String barrierLabel;
  final Color barrierColor;
  final Duration transitionDuration;
  final RoutePageBuilder pageBuilder;
  final Widget child;
  final RouteTransitionsBuilder transitionBuilder;
  final bool useSafeArea;

  @override
  Widget buildByCupertino(BuildContext context) {
    return valueFromCupertino('child', child);
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    return valueFromMaterial('child', child);
  }

  Future<T> show<T>(BuildContext context) {
    final bool _barrierDismissible = useCupertino
        ? valueFromCupertino('barrierDismissible', barrierDismissible)
        : valueFromMaterial('barrierDismissible', barrierDismissible);
    final String _barrierLabel = useCupertino
        ? valueFromCupertino('barrierLabel', barrierLabel)
        : valueFromMaterial('barrierLabel', barrierLabel);
    final Color _barrierColor = useCupertino
        ? valueFromCupertino('barrierColor', barrierColor)
        : valueFromMaterial('barrierColor', barrierColor);
    final Duration _transitionDuration = useCupertino
        ? valueFromCupertino('transitionDuration', transitionDuration)
        : valueFromMaterial('transitionDuration', transitionDuration);
    final RoutePageBuilder _pageBuilder = useCupertino
        ? valueFromCupertino('pageBuilder', pageBuilder)
        : valueFromMaterial('pageBuilder', pageBuilder);
    final RouteTransitionsBuilder _transitionBuilder = useCupertino
        ? valueFromCupertino('transitionBuilder', transitionBuilder)
        : valueFromMaterial('transitionBuilder', transitionBuilder);

    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: _barrierDismissible,
      barrierLabel: _barrierLabel,
      barrierColor: _barrierColor,
      transitionDuration: _transitionDuration,
      pageBuilder: _pageBuilder ?? _defaultPageBuilder,
      transitionBuilder: _transitionBuilder ?? _defaultTransitions,
    );
  }

  Widget _defaultPageBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    final ThemeData theme = Theme.of(context, shadowThemeOnly: true);
    final Widget _pageChild = build(context);
    assert(_pageChild != null, 'child can\'t be null');
    Widget child;
    if (useSafeArea) {
      child = SafeArea(
        child: Theme(
          data: theme,
          child: _pageChild,
        ),
      );
    } else {
      child = Theme(
        data: theme,
        child: _pageChild,
      );
    }
    return child;
  }

  Widget _defaultTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      child: child,
    );
  }
}
