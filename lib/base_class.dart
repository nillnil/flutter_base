import 'package:flutter/widgets.dart' show BuildContext;

import './platform/platform.dart';
import 'base_constants.dart';
import 'base_mixin.dart';

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
  BaseClass({
    this.cupertino = const <String, dynamic>{},
    this.material = const <String, dynamic>{},
  });

  final Map<String, dynamic> cupertino;
  final Map<String, dynamic> material;

  Object build(BuildContext context) {
    buildBefore(context);
    if (useCupertino) {
      // cupertino样式，ios下使用
      // forceUseMaterial = true 强制使用material样式
      if (cupertino != null &&
          cupertino[forceUseMaterial] != null &&
          cupertino[forceUseMaterial]) {
        return buildByMaterial(context);
      }
      buildByCupertinoBefore(context);
      return buildByCupertino(context);
    } else if (useMaterial) {
      // material样式，android跟fuchsia下使用
      // forceUseCupertino = true 强制使用cupertino样式
      if (material != null &&
          material[forceUseCupertino] != null &&
          material[forceUseCupertino]) {
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
    if (cupertino != null) {
      newValue = cupertino[key] ?? value;
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
    if (material != null) {
      newValue = material[key] ?? value;
    } else {
      newValue = value;
    }
    return newValue;
  }

  Object buildByCupertino(BuildContext context);

  Object buildByMaterial(BuildContext context);
}
