import 'package:flutter/cupertino.dart'
    show CupertinoColors, CupertinoDynamicColor, CupertinoTheme;
import 'package:flutter/material.dart';

import '../base_class.dart';

/// Brightness.light, Brightness.dark 分别使用2种颜色
///
/// * 使用时必须调用build(context)方法
/// * cupertino模式下优先取dynamicColor的值
/// * material模式下优先取color和darkColor的值
///
class BaseColor extends BaseClass {
  const BaseColor({
    this.color,
    this.darkColor,
    this.dynamicColor = CupertinoColors.secondarySystemBackground,
    Map<String, dynamic>? cupertino,
    Map<String, dynamic>? material,
  })  : assert(color != null || darkColor != null || dynamicColor != null),
        super(cupertino: cupertino, material: material);

  /// 高对比，一般用于背景色
  /// 默认Brightness.light取黑色，Brightness.dark取白色
  const BaseColor.highContrast({
    this.color,
    this.darkColor,
    this.dynamicColor = const CupertinoDynamicColor.withBrightness(
      color: Colors.black,
      darkColor: Colors.white,
    ),
    Map<String, dynamic>? cupertino,
    Map<String, dynamic>? material,
  })  : assert(color != null || darkColor != null || dynamicColor != null),
        super(cupertino: cupertino, material: material);

  /// When brightness = Brightness.light
  ///
  /// material 模式下先取该值
  final Color? color;

  /// When brightness = Brightness.dark
  ///
  /// material 模式下先取该值
  final Color? darkColor;

  /// [CupertinoDynamicColor]
  ///
  /// cupertino 模式下先取该值
  final CupertinoDynamicColor? dynamicColor;

  @override
  Color buildByCupertino(BuildContext context) {
    final CupertinoDynamicColor _dynamicColor = valueFromCupertino(
      'dynamicColor',
      dynamicColor,
    );
    if (_dynamicColor != null) {
      return _dynamicColor.resolveFrom(context);
    }
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    brightness = CupertinoTheme.of(context).brightness ?? Brightness.light;
    final Color? color = valueFromCupertino('color', this.color);
    final Color? darkColor = valueFromCupertino('color', this.darkColor);
    Color finalColor;
    if (brightness == Brightness.light) {
      finalColor = color ?? darkColor ?? Colors.black;
    } else {
      finalColor = darkColor ?? color ?? Colors.white;
    }
    return finalColor;
  }

  @override
  Color buildByMaterial(BuildContext context) {
    final Color? color = valueFromMaterial('color', this.color);
    final Color? darkColor = valueFromMaterial('color', this.darkColor);
    final CupertinoDynamicColor? dynamicColor = valueFromMaterial(
      'dynamicColor',
      this.dynamicColor,
    );
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    Color finalColor = Colors.white;
    switch (brightness) {
      case Brightness.light:
        if (color != null || darkColor != null) {
          finalColor = color ?? darkColor ?? Colors.black;
        } else if (dynamicColor != null) {
          finalColor = dynamicColor.color;
        }
        break;
      case Brightness.dark:
        if (color != null || darkColor != null) {
          finalColor = darkColor ?? color ?? Colors.white;
        } else if (dynamicColor != null) {
          finalColor = dynamicColor.darkColor;
        }
        break;
    }
    return finalColor;
  }
}
