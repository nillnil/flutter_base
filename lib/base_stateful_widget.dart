
import 'package:base/base_constants.dart';
import 'package:base/platform/platform.dart';
import 'package:flutter/widgets.dart' show BuildContext, Container, Key, State, StatefulElement, StatefulWidget, Widget;

/// 基础组件
class BaseStatefulWidget extends StatefulWidget {

	final Map<String, Object> cupertino;
	final Map<String, Object> material;

	BaseStatefulWidget({
		Key key,
		this.cupertino,
		this.material
	});

  @override
  State<StatefulWidget> createState() => BaseState();

}

class BaseState<T extends BaseStatefulWidget> extends State<T> {

	@override
	T get widget => super.widget;

	@override
	BuildContext get context => super.context;

	@override
	bool get mounted => super.mounted;

	@override
	Widget build(BuildContext context) {
		buildBefore(context);
		if (isCupertino) {
			// cupertino模式，ios下使用
			// forceUseMaterial = true 强制使用material样式
			if (widget.cupertino != null && widget.cupertino[BaseConstants.FORCE_USE_MATERIAL] != null && widget.cupertino[BaseConstants.FORCE_USE_MATERIAL]) {
				return buildByMaterial(context);
			}
			buildByCupertinoBefore(context);
			return buildByCupertino(context);
		} else if (isMaterial) {
			// material模式，android跟fuchsia下使用
			// forceUseCupertino = true 强制使用cupertino样式
			if (widget.material != null && widget.material[BaseConstants.FORCE_USE_CUPERTINO] != null && widget.material[BaseConstants.FORCE_USE_CUPERTINO]) {
				return buildByCupertino(context);
			}
			buildByMaterialBefore(context);
			return buildByMaterial(context);
		} else {
			print('The platform is = $appPlatform, it not support yet.');
			return null;
		}
	}

	// build之前调用
	void buildBefore(BuildContext context) {}

	// buildByMaterial之前调用
	void buildByMaterialBefore(BuildContext context) {}

	// buildByCupertino之前调用
	void buildByCupertinoBefore(BuildContext context) {}

	Widget buildByCupertino(BuildContext context) {
		return Container();
	}

	Widget buildByMaterial(BuildContext context) {
		return Container();
	}

	/// 从cupertino获取key对应的值，
	/// 如果为null取value的值，
	/// 如果还是null则取material里的值
	Object valueFromCupertino(String key, Object value) {
		Object newValue;
		if (this.widget.cupertino != null) {
			newValue = this.widget.cupertino[key] ?? value;
		} else {
			newValue = value;
		}
		// cupertino, material2种的默认值可能会不一样，所以这里就不查找另一种风格的值了
//		if (newValue == null && this.material != null) {
//			newValue = this.material[key];
//		}
		return newValue;
	}

	/// 从material获取key对应的值，
	/// 如果为null取value的值，
	/// 如果还是null则取cupertino里的值
	Object valueFromMaterial(String key, Object value) {
		Object newValue;
		if (this.widget.material != null) {
			newValue = this.widget.material[key] ?? value;
		} else {
			newValue = value;
		}
		// cupertino, material2种的默认值可能会不一样，所以这里就不查找另一种风格的值了
//		if (newValue == null && this.cupertino != null) {
//			newValue = this.cupertino[key];
//		}
		return newValue;
	}

}