import 'dart:math';

import 'package:flutter/cupertino.dart' show CupertinoColors, CupertinoDynamicColor, CupertinoTheme;
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
    final CupertinoDynamicColor? _dynamicColor = valueFromCupertino(
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
      finalColor = color ?? Colors.black;
    } else {
      finalColor = darkColor ?? Colors.white;
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
        finalColor = color ?? dynamicColor?.color ?? Colors.black;
        break;
      case Brightness.dark:
        finalColor = darkColor ?? dynamicColor?.darkColor ?? Colors.white;
        break;
    }
    return finalColor;
  }
}


/// 随机颜色，不支持随机范围
class BaseRandomColor extends Color {
  /// 同[Color.fromARGB], 参数有值则锁定该值
  BaseRandomColor({int? a, int? r, int? g, int? b})
      : super(((((a ?? Random().nextInt(256)) & 0xff) << 24) |
                (((r ?? Random().nextInt(256)) & 0xff) << 16) |
                (((g ?? Random().nextInt(256)) & 0xff) << 8) |
                (((b ?? Random().nextInt(256)) & 0xff) << 0)) &
            0xFFFFFFFF);

  /// 同[Color.fromRGBO], 参数有值则锁定该值
  BaseRandomColor.fromRGBO({int? r, int? g, int? b, double? opacity})
      : super((((((opacity ?? Random().nextDouble()) * 0xff ~/ 1) & 0xff) << 24) |
                (((r ?? Random().nextInt(256)) & 0xff) << 16) |
                (((g ?? Random().nextInt(256)) & 0xff) << 8) |
                (((b ?? Random().nextInt(256)) & 0xff) << 0)) &
            0xFFFFFFFF);

  /// 固定red
  BaseRandomColor.withRed(int r)
      : super((((Random().nextInt(256) & 0xff) << 24) | ((r & 0xff) << 16) | ((Random().nextInt(256) & 0xff) << 8) | ((Random().nextInt(256) & 0xff) << 0)) &
            0xFFFFFFFF);

  /// 固定blue
  BaseRandomColor.withBlue(int b)
      : super((((Random().nextInt(256) & 0xff) << 24) | ((Random().nextInt(256) & 0xff) << 16) | ((Random().nextInt(256) & 0xff) << 8) | ((b & 0xff) << 0)) &
            0xFFFFFFFF);

  /// 固定green
  BaseRandomColor.withGreen(int g)
      : super((((Random().nextInt(256) & 0xff) << 24) | ((Random().nextInt(256) & 0xff) << 16) | ((g & 0xff) << 8) | ((Random().nextInt(256) & 0xff) << 0)) &
            0xFFFFFFFF);

  /// 固定alpha
  BaseRandomColor.withAlpha(int a)
      : super((((a & 0xff) << 24) | ((Random().nextInt(256) & 0xff) << 16) | ((Random().nextInt(256) & 0xff) << 8) | ((Random().nextInt(256) & 0xff) << 0)) &
            0xFFFFFFFF);

  /// 固定opacity
  BaseRandomColor.withOpacity(double opacity)
      : super(((((opacity * 0xff ~/ 1) & 0xff) << 24) |
                ((Random().nextInt(256) & 0xff) << 16) |
                ((Random().nextInt(256) & 0xff) << 8) |
                ((Random().nextInt(256) & 0xff) << 0)) &
            0xFFFFFFFF);
}
