

import 'package:flutter/material.dart' show InteractiveInkFeatureFactory, InteractiveInkFeature,
  MaterialInkController, RenderBox, Offset, Color, TextDirection, RectCallback, BorderRadius, ShapeBorder,
  VoidCallback, InkSplash, Border;

/// cupertino模式下去除水波纹效果，但还是有200毫秒的延迟高亮
/// 当cupertino模式需要用到material组件时使用
/// Theme(
///   splashFactory: CupertinoSplashFactory()
/// )
class CupertinoSplashFactory extends InteractiveInkFeatureFactory {

  @override
  InteractiveInkFeature create({
    MaterialInkController controller,
    RenderBox referenceBox,
    Offset position,
    Color color,
    TextDirection textDirection,
    bool containedInkWell = false,
    RectCallback rectCallback,
    BorderRadius borderRadius,
    ShapeBorder customBorder,
    double radius,
    VoidCallback onRemoved
  }) {
    return InkSplash(
      controller: controller,
      referenceBox: referenceBox,
      position: position,
      color: color,
      containedInkWell: false,
      rectCallback: rectCallback,
      borderRadius: BorderRadius.zero,
      customBorder: Border(),
      radius: 0.0,
      onRemoved: onRemoved,
      textDirection: textDirection,
    );
  }

}
