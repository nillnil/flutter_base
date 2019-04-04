
import 'package:base/base_stateless_widget.dart';
import 'package:flutter/material.dart';

class BaseGeneralDialog extends BaseStatelessWidget {

	final bool barrierDismissible;
	final String barrierLabel;
	final Color barrierColor;
	final Duration transitionDuration;
	final RoutePageBuilder pageBuilder;
	final Widget child;
	final RouteTransitionsBuilder transitionBuilder;
	final bool useSafeArea;

	// 个性化cupertino配置
	final Map<String, Object> cupertino;
	// 个性化material配置
	final Map<String, Object> material;

  BaseGeneralDialog({
		this.barrierDismissible = true,
		this.barrierLabel = '',
		this.barrierColor = Colors.black54,
		this.transitionDuration,
		this.pageBuilder,
		this.child,
		this.transitionBuilder,
		this.useSafeArea = false,

		this.cupertino,
		this.material
  });

  bool _barrierDismissible;
  String _barrierLabel;
  Color _barrierColor;
  Duration _transitionDuration;
	RoutePageBuilder _pageBuilder;
	RouteTransitionsBuilder _transitionBuilder;
	Widget _pageChild;

	@override
  Widget buildByCupertino(BuildContext context) {
		_barrierDismissible = valueFromCupertino('barrierDismissible', barrierDismissible);
		_barrierLabel = valueFromCupertino('barrierLabel', barrierLabel);
		_barrierColor = valueFromCupertino('barrierColor', barrierColor);
		_pageBuilder = valueFromCupertino('pageBuilder', pageBuilder);
		_transitionDuration = valueFromCupertino('transitionDuration', transitionDuration);
		_transitionBuilder = valueFromCupertino('transitionBuilder', transitionBuilder);
    return valueFromCupertino('child', child);
  }

  @override
  Widget buildByMaterial(BuildContext context) {
		_barrierDismissible = valueFromMaterial('barrierDismissible', barrierDismissible);
		_barrierLabel = valueFromMaterial('barrierLabel', barrierLabel);
		_barrierColor = valueFromMaterial('barrierColor', barrierColor);
		_pageBuilder = valueFromMaterial('pageBuilder', pageBuilder);
		_transitionDuration = valueFromMaterial('transitionDuration', transitionDuration);
		_transitionBuilder = valueFromMaterial('transitionBuilder', transitionBuilder);
    return valueFromMaterial('child', child);
  }

	Future<T> show<T>(BuildContext context) {
		_pageChild = build(context);
		return showGeneralDialog<T>(
			context: context,
			barrierDismissible: _barrierDismissible,
			barrierLabel: _barrierLabel,
			barrierColor: _barrierColor,
			transitionDuration: _transitionDuration,
			pageBuilder: _pageBuilder ?? _defaultPageBuilder,
			transitionBuilder: _transitionBuilder ?? _defaultTransitions
		);
	}

	Widget _defaultPageBuilder(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
		final ThemeData theme = Theme.of(context, shadowThemeOnly: true);
		assert(_pageChild != null, 'child can\'t be null');
		return useSafeArea ? SafeArea(
			child: theme != null ? Theme(data: theme, child: _pageChild) : _pageChild
		): theme != null ? Theme(data: theme, child: _pageChild) : _pageChild;
	}

	Widget _defaultTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
		return FadeTransition(
			opacity: CurvedAnimation(
				parent: animation,
				curve: Curves.easeOut,
			),
			child: child,
		);
	}

}

