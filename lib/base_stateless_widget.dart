import 'package:flutter/material.dart';

import './base_constants.dart';
import './base_mixin.dart';
import './platform/platform.dart';
import './utils/custom_material_widget.dart';

/// 基础无状态组件
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
abstract class BaseStatelessWidget extends StatelessWidget with BaseMixin {
  BaseStatelessWidget({
    Key key,
    this.cupertino = const <String, dynamic>{},
    this.material = const <String, dynamic>{},
  }) : super(key: key);

  final Map<String, dynamic> cupertino;
  final Map<String, dynamic> material;

  @override
  Widget build(BuildContext context) {
    buildBefore(context);
    if (useCupertino) {
      if (cupertino != null) {
        // 禁止构建
        if (cupertino[disabled] != null && cupertino[disabled]) {
          return Container();
        }
        // cupertino模式，ios下使用
        // forceUseMaterial = true 强制使用material模式
        if (cupertino[forceUseMaterial] != null &&
            cupertino[forceUseMaterial]) {
          // *** 请注意，此时BaseApp上的theme参数是不生效的 ***
          // 默认套多一层 Material
          buildByMaterialBefore(context);
          if (withoutSplashOnCupertino) {
            return CustomSplashFactoryWidget.withoutSplash(
              child: buildByMaterial(context),
              theme: Theme.of(context),
            );
          }
          return CustomMaterialWidget(child: buildByMaterial(context));
        }
      }
      buildByCupertinoBefore(context);
      return buildByCupertino(context);
    } else if (useMaterial) {
      if (material != null) {
        // 禁止构建
        if (material[disabled] != null && material[disabled]) {
          return Container();
        }
        // material模式，android跟fuchsia下使用
        // forceUseCupertino = true 强制使用cupertino模式
        if (material[forceUseCupertino] != null &&
            material[forceUseCupertino]) {
          // *** 请注意，此时BaseApp上的cupertinoTheme参数是不生效的 ***
          buildByCupertinoBefore(context);
          return buildByCupertino(context);
        }
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

  // 使用Cupertino组件构建
  Widget buildByCupertino(BuildContext context);

  // 使用Material组件构建
  Widget buildByMaterial(BuildContext context);
}
