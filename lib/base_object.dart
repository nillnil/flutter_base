
import 'package:base/base_constants.dart';
import 'package:base/platform/platform.dart';
import 'package:flutter/widgets.dart' show BuildContext;

abstract class BaseObject {

	final Map<String, Object> cupertino;
	final Map<String, Object> material;

	BaseObject({
		this.cupertino,
		this.material
	});

	Object build(BuildContext context) {
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
		if (newValue == null && this.material != null) {
			newValue = this.material[key];
		}
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
		if (newValue == null && this.cupertino != null) {
			newValue = this.cupertino[key];
		}
		return newValue;
	}

	Object buildByCupertino(BuildContext context);

	Object buildByMaterial(BuildContext context);

}