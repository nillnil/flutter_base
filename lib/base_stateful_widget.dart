import 'package:flutter/material.dart';

import './components/base_material_widget.dart';
import './platform/platform.dart';
import 'base_constants.dart';
import 'base_mixin.dart';

/// 基础状态组件
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
abstract class BaseStatefulWidget extends StatefulWidget {
  const BaseStatefulWidget({
    Key key,
    this.cupertino = const <String, dynamic>{},
    this.material = const <String, dynamic>{},
  }) : super(key: key);

  final Map<String, Object> cupertino;
  final Map<String, Object> material;
}

abstract class BaseState<T extends BaseStatefulWidget> extends State<T>
    with BaseMixin {
  @override
  T get widget => super.widget;

  @override
  BuildContext get context => super.context;

  @override
  bool get mounted => super.mounted;

  @override
  Widget build(BuildContext context) {
    buildBefore(context);
    if (useCupertino) {
      // cupertino模式，ios下使用
      // forceUseMaterial = true 强制使用material模式
      if (widget.cupertino != null &&
          widget.cupertino[forceUseMaterial] != null &&
          widget.cupertino[forceUseMaterial]) {
        // *** 请注意，此时BaseApp上的theme参数是不生效的 ***
        // 默认套多一层 Material
        buildByMaterialBefore(context);
        // 去除水波纹效果
        if (withoutSplashOnCupertino) {
          return BaseMaterialWidget.withoutSplash(
            child: buildByMaterial(context),
            theme: Theme.of(context),
          );
        }
        return BaseMaterialWidget(child: buildByMaterial(context));
      }
      buildByCupertinoBefore(context);
      return buildByCupertino(context);
    } else if (useMaterial) {
      // material模式，android跟fuchsia下使用
      // forceUseCupertino = true 强制使用cupertino模式
      if (widget.material != null &&
          widget.material[forceUseCupertino] != null &&
          widget.material[forceUseCupertino]) {
        // *** 请注意，此时BaseApp上的cupertinoTheme参数是不生效的 ***
        buildByCupertinoBefore(context);
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
  dynamic valueFromCupertino(String key, dynamic value) {
    dynamic newValue;
    if (widget.cupertino != null) {
      newValue = widget.cupertino[key] ?? value;
    } else {
      newValue = value;
    }
    return newValue;
  }

  /// 从material获取key对应的值，
  /// 如果为null取value的值，
  /// 如果还是null则取cupertino里的值
  dynamic valueFromMaterial(String key, dynamic value) {
    dynamic newValue;
    if (widget.material != null) {
      newValue = widget.material[key] ?? value;
    } else {
      newValue = value;
    }
    return newValue;
  }

  /// build on cupertino mode
  Widget buildByCupertino(BuildContext context);

  /// build on material mode
  Widget buildByMaterial(BuildContext context);
}
