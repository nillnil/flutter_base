import 'package:flutter/material.dart';

import '../base_param.dart';
import '../base_stateless_widget.dart';
import '../mode/base_mode.dart';

@Deprecated('')
class BaseGeneralDialog extends BaseStatelessWidget {
  const BaseGeneralDialog({
    Key? key,
    this.barrierDismissible = true,
    this.barrierLabel,
    this.barrierColor = const Color(0x80000000),
    this.transitionDuration = const Duration(milliseconds: 200),
    this.pageBuilder,
    this.child,
    this.transitionBuilder,
    this.useSafeArea = false,
    this.useRootNavigator = true,
    this.routeSettings,
    BaseParam? baseParam,
  }) : super(key: key, baseParam: baseParam);

  final bool barrierDismissible;
  final String? barrierLabel;
  final Color barrierColor;
  final Duration transitionDuration;
  final RoutePageBuilder? pageBuilder;
  final Widget? child;
  final RouteTransitionsBuilder? transitionBuilder;
  final bool useSafeArea;
  final bool useRootNavigator;
  final RouteSettings? routeSettings;

  @override
  Widget buildByCupertino(BuildContext context) {
    return valueOf('child', child);
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    return valueOf('child', child);
  }

  Future<T?> show<T>(BuildContext context) {
    final WidgetBuildMode _widgetBuildMode = getBuildMode(baseParam);
    final bool _barrierDismissible = valueOf('barrierDismissible', barrierDismissible);
    final String _barrierLabel = _widgetBuildMode == WidgetBuildMode.cupertino
        ? valueOf('barrierLabel', barrierLabel) ?? ''
        : valueOf('barrierLabel', barrierLabel) ?? MaterialLocalizations.of(context).modalBarrierDismissLabel;
    final Color _barrierColor = valueOf('barrierColor', barrierColor);
    final Duration _transitionDuration = valueOf('transitionDuration', transitionDuration);
    final RoutePageBuilder? _pageBuilder = valueOf('pageBuilder', pageBuilder);
    final RouteTransitionsBuilder? _transitionBuilder = valueOf('transitionBuilder', transitionBuilder);

    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: _barrierDismissible,
      barrierLabel: _barrierLabel,
      barrierColor: _barrierColor,
      transitionDuration: _transitionDuration,
      pageBuilder: _pageBuilder ?? _defaultPageBuilder,
      transitionBuilder: _transitionBuilder ?? _defaultTransitions,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
    );
  }

  Widget _defaultPageBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    final ThemeData theme = Theme.of(context);
    final Widget _pageChild = build(context);
    assert(_pageChild != null, 'child can\'t be null');
    Widget child;
    if (useSafeArea) {
      child = SafeArea(
        child: theme != null
            ? Theme(
                data: theme,
                child: _pageChild,
              )
            : _pageChild,
      );
    } else {
      child = theme != null
          ? Theme(
              data: theme,
              child: _pageChild,
            )
          : _pageChild;
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

// Future<T> showBaseGeneralDialog<T>(
//   BaseGeneralDialog baseGeneralDialog,
//   BuildContext context,
// ) {
//   return baseGeneralDialog.show(context);
// }
