import 'package:flutter/widgets.dart' show BuildContext;

import 'base_mixin.dart';
import 'base_param.dart';

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
/// *** material模式使用 valueOf(key, value) 获取
/// ***
abstract class BaseClass with BaseMixin {
  const BaseClass({
    this.baseParam,
  });

  /// 个性化参数，先取平台的参数，再取模式的参数
  final BaseParam? baseParam;

  @override
  dynamic valueOf(String key, dynamic value) {
    return valueOfBaseParam(baseParam, key, value);
  }

  dynamic build(BuildContext context) {
    return commonBuild(context, baseParam);
  }
}
