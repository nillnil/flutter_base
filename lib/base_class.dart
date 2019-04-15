
import 'package:base/base_constants.dart';
import 'package:base/base_mixin.dart';
import 'package:base/platform/platform.dart';
import 'package:flutter/widgets.dart' show BuildContext;

/// 基础类
/// cupertino使用buildByCupertino方法构建，material使用buildByMaterial方法构建
/// *** 参数
/// 1、cupertino模式：从cupertino里取对应的值，取不到则取公共参数
/// 2、material模式：从material里取对应的值，取不到则取公共参数
/// 3、cupertino模式下可以使用 cupertino = { forceUseMaterial: true } 强制使用material模式构建
///   使用 cupertino = { disabled: true } 禁止构建
/// 4、material模式下可以使用 material = { forceUseCupertino: true } 强制使用cupertino模式构建
///   使用 material = { disabled: true } 禁止构建
/// ***
/// *** Flutter禁用运行时反射，所以取值由子组件各自获取，
/// *** cupertino模式使用 valueFromCupertino(key, value) 获取，
/// *** material模式使用 valueFromMaterial(key, value) 获取
/// ***
abstract class BaseClass with BaseMixin {

  final Map<String, Object> cupertino;
  final Map<String, Object> material;

	BaseClass({
		this.cupertino,
    this.material
	});

	Object build(BuildContext context) {
		buildBefore(context);
		if (useCupertino) {
			// cupertino样式，ios下使用
			// forceUseMaterial = true 强制使用material样式
			if (this.cupertino != null && this.cupertino[forceUseMaterial] != null && this.cupertino[forceUseMaterial]) {
				return buildByMaterial(context);
			}
			buildByCupertinoBefore(context);
			return buildByCupertino(context);
		} else if (useMaterial) {
			// material样式，android跟fuchsia下使用
			// forceUseCupertino = true 强制使用cupertino样式
			if (this.material != null && this.material[forceUseCupertino] != null && this.material[forceUseCupertino]) {
				return buildByCupertino(context);
			}
			buildByMaterialBefore(context);
			return buildByMaterial(context);
		} else {
			print('The platform is = $basePlatform, it not support yet.');
			return null;
		}
	}

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
		return newValue;
	}

	Object buildByCupertino(BuildContext context);

	Object buildByMaterial(BuildContext context);

}