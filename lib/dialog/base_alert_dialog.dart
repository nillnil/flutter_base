
import 'package:base/base_stateless_widget.dart';
import 'package:flutter/cupertino.dart' show CupertinoAlertDialog, ScrollController;
import 'package:flutter/material.dart' show AlertDialog, Animation, BuildContext, Builder, Color, Colors, CurvedAnimation, Curves, EdgeInsets, EdgeInsetsGeometry, FadeTransition, Key, RouteTransitionsBuilder, SafeArea, ShapeBorder, Theme, ThemeData, Widget, showDialog, showGeneralDialog;

/// 基础弹出框
/// cupertino，使用CupertinoAlertDialog
/// *** 可使用 cupertino = { forceUseMaterial: true } 参数强制使用AlertDialog
/// material，使用AlertDialog
/// *** 可使用 material = { forceUseCupertino: true } CupertinoAlertDialog
class BaseAlertDialog extends BaseStatelessWidget {

	// general
	final Widget title;
	final Widget content;
	final List<Widget> actions;

	// cupertino
	final ScrollController scrollController;
	final ScrollController actionScrollController;

	// material
	final EdgeInsetsGeometry titlePadding;
	final EdgeInsetsGeometry contentPadding;
	final String semanticLabel;
	final ShapeBorder shape;

	// 个性化cupertino配置
	final Map<String, Object> cupertino;
	// 个性化material配置
	final Map<String, Object> material;

	BaseAlertDialog({
		// general
		Key key,
		this.title,
		this.content,
		this.actions = const <Widget>[],

		// cupertino
		this.scrollController,
		this.actionScrollController,

		// material
		this.titlePadding,
		this.contentPadding = const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
		this.semanticLabel,
		this.shape,

		this.cupertino,
		this.material
	}) : super(key: key, cupertino: cupertino, material: material);

	@override
	Widget buildByCupertino(BuildContext context) {
		return CupertinoAlertDialog(
			key: valueFromCupertino('key', key),
			title: valueFromCupertino('title', title),
			content: valueFromCupertino('content', content),
			actions: valueFromCupertino('actions', actions),
			scrollController: scrollController,
			actionScrollController: actionScrollController
		);
	}

	@override
	Widget buildByMaterial(BuildContext context) {
		return AlertDialog(
			key: valueFromMaterial('key', key),
			title: valueFromMaterial('title', title),
			titlePadding: titlePadding,
			content: valueFromMaterial('content', content),
			contentPadding: contentPadding,
			actions: valueFromMaterial('actions', actions),
			semanticLabel: semanticLabel
		);
	}

	Future<T> show<T>(BuildContext context, { bool barrierDismissible = true }) {
		return showDialog<T>(
			context: context,
			barrierDismissible: barrierDismissible,
			builder: (_) => build(context)
		);
	}

}