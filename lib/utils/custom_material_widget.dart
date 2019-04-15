import 'package:flutter/material.dart' show Border, BorderRadius, BuildContext, Color, Colors, InkSplash, InteractiveInkFeature, InteractiveInkFeatureFactory, Key, Material, MaterialInkController, MaterialType, Offset, RectCallback, RenderBox, ShapeBorder, StatelessWidget, TextDirection, Theme, ThemeData, VoidCallback, Widget, required;

/// 当cupertino模式需要用到material组件时使用
class CustomMaterialWidget extends StatelessWidget {

  final Widget child;

  CustomMaterialWidget({
    Key key, 
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      color: Colors.transparent,
      child: child,
    );
  }

}

/// 自定义SplashFactory的Material组件
class CustomSplashFactoryWidget extends CustomMaterialWidget {

  final Widget child;
  final ThemeData theme;

  CustomSplashFactoryWidget({
    Key key,
    @required Widget child, 
    @required this.theme, 
    @required InteractiveInkFeatureFactory factory
  }): assert(child != null, 'child can not be null.'),
    assert(theme != null, 'theme can not be null.'),
    assert(factory != null, 'factory can not be null.'),
    child = Theme(
      data: theme.copyWith(
        splashFactory: factory
      ), 
      child: child,
    ),
    super(key: key, child: child);

  /// 没有水波纹的自定义material组件
  /// 适用于cupertino模式中使用material组件
  /// 会有200延迟高亮
  CustomSplashFactoryWidget.withoutSplash({
    Key key,
    @required Widget child, 
    @required this.theme, 
  }): assert(child != null, 'child can not be null.'),
    assert(theme != null, 'theme can not be null.'),
    child = Theme(
      data: theme.copyWith(
        splashFactory: WithoutSplashFactory()
      ), 
      child: child,
    ),
    super(key: key, child: child);

}

/// 去除水波纹效果，但还是有200毫秒的延迟高亮
class WithoutSplashFactory extends InteractiveInkFeatureFactory {

  WithoutSplashFactory();

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