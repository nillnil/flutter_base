import 'package:base/base.dart';
import 'package:flutter/material.dart' show BuildContext, Container, Theme, Widget;

import 'base_constants.dart';
import 'components/base_material_widget.dart';
import 'config/base_config.dart';
import 'mode/base_mode.dart';
import 'theme/base_theme.dart';

/// 通用方法
mixin BaseMixin {
  /// build之前调用
  void beforeBuild(BuildContext context) {}

  /// buildByMaterial之前调用
  void beforeBuildByMaterial(BuildContext context) {}

  /// buildByCupertino之前调用
  void beforeBuildByCupertino(BuildContext context) {}

  /// build on cupertino mode
  Widget buildByCupertino(BuildContext context);

  /// build on material mode
  Widget buildByMaterial(BuildContext context);

  /// 先取平台里的值，再从模式中取值，最后取value的值
  dynamic valueOf(BaseParam? baseParam, String key, dynamic value) {
    return baseParam != null ? baseParam.valueOf(key, value) ?? value : value;
  }

  /// 从cupertino获取key对应的值，
  /// 如果为null取value的值，
  /// 如果还是null则取material里的值
  dynamic valueFromMap(Map<String, dynamic>? map, String key, dynamic value) {
    return map != null ? map[key] ?? value : value;
  }

  // Widget commonBuild(BuildContext context, BaseParam? baseParam) {

  // }

  Widget commonBuild(BuildContext context, Map<String, dynamic>? cupertino, Map<String, dynamic>? material) {
    beforeBuild(context);
    WidgetBuildMode _widgetBuildMode = WidgetBuildMode.disabled;
    bool _withoutSplashOnCupertino = withoutSplashOnCupertino;
    if (isCupertinoMode) {
      _widgetBuildMode = WidgetBuildMode.cupertino;
      if (cupertino != null) {
        if (cupertino[disabled] != null && cupertino[disabled] as bool) {
          // 禁止构建
          _widgetBuildMode = WidgetBuildMode.disabled;
        } else if (cupertino[forceUseMaterial] != null && cupertino[forceUseMaterial] as bool) {
          // cupertino模式
          // forceUseMaterial = true 强制使用material模式
          // *** 请注意，此时BaseApp上的theme参数是不生效的 ***
          _widgetBuildMode = WidgetBuildMode.forceUseMaterial;
          _withoutSplashOnCupertino = cupertino[customWithoutSplashOnCupertino] ?? _withoutSplashOnCupertino;
        }
      }
    } else if (isMaterialMode) {
      _widgetBuildMode = WidgetBuildMode.material;
      if (material != null) {
        if (material[disabled] != null && material[disabled] as bool) {
          // 禁止构建
          _widgetBuildMode = WidgetBuildMode.disabled;
        } else if (material[forceUseCupertino] != null && material[forceUseCupertino] as bool) {
          // material模式下使用
          // forceUseCupertino = true 强制使用cupertino模式
          // *** 请注意，此时BaseApp上的cupertinoTheme参数是不生效的 ***
          _widgetBuildMode = WidgetBuildMode.forceUseCupertino;
        }
      }
    }
    Widget _widget;
    switch (_widgetBuildMode) {
      case WidgetBuildMode.cupertino:
      case WidgetBuildMode.forceUseCupertino:
        beforeBuildByCupertino(context);
        _widget = buildByCupertino(context);
        break;
      case WidgetBuildMode.material:
        beforeBuildByMaterial(context);
        _widget = buildByMaterial(context);
        break;
      case WidgetBuildMode.forceUseMaterial:
        // 默认套多一层 Material
        beforeBuildByMaterial(context);
        // 是否禁用水波纹
        if (_withoutSplashOnCupertino) {
          _widget = BaseMaterialWidget.withoutSplash(
            theme: BaseTheme.of(context).materialTheme ?? Theme.of(context),
            child: buildByMaterial(context),
          );
        } else {
          _widget = BaseMaterialWidget(child: buildByMaterial(context));
        }
        break;
      case WidgetBuildMode.disabled:
        _widget = Container();
        break;
      default:
        _widget = Container();
        print('The currentBaseMode is = $currentBaseMode, it not support yet.');
        break;
    }
    return _widget;
  }
}
