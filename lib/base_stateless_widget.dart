
import 'package:base/base_constants.dart';
import 'package:base/platform/platform.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart' show BuildContext, Key, StatelessWidget, Widget;

/// 基础无状态组件
/// cupertino使用buildByCupertino方法构建，material使用buildByMaterial方法构建
/// *** 参数
/// 1、cupertino模式：从cupertino里取对应的值，取不到则取公共参数，还取不到则取material里的值
/// 2、material模式：从material里取对应的值，取不到则取公共参数，还取不到则取cupertino里的值
/// 3、cupertino下可以使用cupertino = { forceUseMaterial: true } 参数强制使用material构建
/// 4、material下可以使用cupertino = { forceUseCupertino: true } 参数强制使用cupertino构建
/// ***
/// *** dart里的反射还处于不稳定状态，所以取值由子组件各自获取，
/// *** cupertino使用valueFromCupertino获取，
/// *** material使用valueFromMaterial获取
/// ***
abstract class BaseStatelessWidget extends StatelessWidget {

	final Map<String, Object> cupertino;
	final Map<String, Object> material;

	BaseStatelessWidget({
		Key key,
		this.cupertino,
		this.material
	});

	@override
	Widget build(BuildContext context) {
		buildBefore(context);
		if (isCupertino) {
			// cupertino模式，ios下使用
			// forceUseMaterial = true 强制使用material样式
			if (this.cupertino != null && this.cupertino[BaseConstants.FORCE_USE_MATERIAL] != null && this.cupertino[BaseConstants.FORCE_USE_MATERIAL]) {
				return buildByMaterial(context);
			}
			buildByCupertinoBefore(context);
			return buildByCupertino(context);
		} else if (isMaterial) {
			// material模式，android跟fuchsia下使用
			// forceUseCupertino = true 强制使用cupertino样式
			if (this.material != null && this.material[BaseConstants.FORCE_USE_CUPERTINO] != null && this.material[BaseConstants.FORCE_USE_CUPERTINO]) {
				return buildByCupertino(context);
			}
			buildByMaterialBefore(context);
			return buildByMaterial(context);
		} else {
			print('The platform not support yet.');
			return null;
		}
	}

	// build之前调用
	void buildBefore(BuildContext context) {}

	// buildByMaterial之前调用
	void buildByMaterialBefore(BuildContext context) {}

	// buildByCupertino之前调用
	void buildByCupertinoBefore(BuildContext context) {}

	/// 从cupertino获取key对应的值，
	/// 如果为null取value的值，
	/// 如果还是null则取material里的值
	Object valueFromCupertino(String key, Object value) {
		Object newValue;
		if (this.cupertino != null) {
			newValue = this.cupertino[key] ?? value;
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
		if (this.material != null) {
			newValue = this.material[key] ?? value;
		} else {
			newValue = value;
		}
		// cupertino, material2种的默认值可能会不一样，所以这里就不查找另一种风格的值了
//		if (newValue == null && this.cupertino != null) {
//			newValue = this.cupertino[key];
//		}
		return newValue;
	}

	Widget buildByCupertino(BuildContext context);

	Widget buildByMaterial(BuildContext context);

}