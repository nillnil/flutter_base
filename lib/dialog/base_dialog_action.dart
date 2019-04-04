
import 'package:base/base_stateless_widget.dart';
import 'package:flutter/cupertino.dart' show CupertinoDialogAction;
import 'package:flutter/material.dart' show Brightness, BuildContext, ButtonTextTheme, Clip, Color, EdgeInsetsGeometry, FlatButton, Key, MaterialTapTargetSize, ShapeBorder, TextStyle, ValueChanged, VoidCallback, Widget;

/// 基础弹框按钮
/// cupertino，使用CupertinoDialogAction
/// *** 可使用 cupertino = { forceUseMaterial: true } 参数强制使用FlatButton
/// material，使用FlatButton
/// *** 可使用 material = { forceUseCupertino: true } 参数强制使用CupertinoDialogAction
class BaseDialogAction extends BaseStatelessWidget {

	// general
	final VoidCallback onPressed;
	final Widget child;

	// cupertino
	final bool isDefaultAction;
	final bool isDestructiveAction;
	final TextStyle textStyle;

	// material
	final ValueChanged<bool> onHighlightChanged;
	final	ButtonTextTheme textTheme;
	final Color textColor;
	final	Color disabledTextColor;
	final Color color;
	final	Color disabledColor;
	final Color highlightColor;
	final	Color splashColor;
	final Brightness colorBrightness;
	final	EdgeInsetsGeometry padding;
	final ShapeBorder shape;
	final	Clip clipBehavior;
	final MaterialTapTargetSize materialTapTargetSize;

	// 个性化cupertino配置
	final Map<String, Object> cupertino;
	// 个性化material配置
	final Map<String, Object> material;

  BaseDialogAction({
		this.onPressed,
		this.isDefaultAction = false,
		this.isDestructiveAction = false,
		this.textStyle,
		this.child,

		Key key,
		this.onHighlightChanged,
		this.textTheme,
		this.textColor,
		this.disabledTextColor,
		this.color,
		this.disabledColor,
		this.highlightColor,
		this.splashColor,
		this.colorBrightness,
		this.padding,
		this.shape,
		this.clipBehavior = Clip.none,
		this.materialTapTargetSize,

		this.cupertino,
		this.material
  }) : super(key: key);

	@override
  Widget buildByCupertino(BuildContext context) {
    return CupertinoDialogAction(
			onPressed: valueFromCupertino('onPressed', onPressed),
			isDefaultAction: isDefaultAction,
			isDestructiveAction: isDestructiveAction,
			textStyle: textStyle,
			child: valueFromCupertino('child', child)
		);
  }

  @override
  Widget buildByMaterial(BuildContext context) {
    return FlatButton(
			key: key,
			onPressed: valueFromMaterial('onPressed', onPressed),
			onHighlightChanged: onHighlightChanged,
			textTheme: textTheme,
			textColor: textColor,
			disabledTextColor: disabledTextColor,
			color: color,
			disabledColor: disabledColor,
			highlightColor: highlightColor,
			splashColor: splashColor,
			colorBrightness: colorBrightness,
			padding: padding,
			shape: shape,
			clipBehavior: clipBehavior,
			materialTapTargetSize: materialTapTargetSize,
			child: valueFromMaterial('child', child)
		);
  }

}