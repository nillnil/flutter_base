import 'package:flutter/material.dart';

/// 自定义SplashFactory的Material组件
class BaseMaterialWidget extends StatelessWidget {
  BaseMaterialWidget({
    Key? key,
    required Widget child,
    this.theme,
    InteractiveInkFeatureFactory? splashFactory,
  })  : assert(child != null, 'child can not be null.'),
        assert(
            (theme == null && splashFactory == null) ||
                (theme != null && splashFactory != null),
            'theme and factory must be the same value.'),
        child = (theme != null && splashFactory != null)
            ? Theme(
                data: theme.copyWith(
                  splashFactory: splashFactory,
                ),
                child: child,
              )
            : child,
        super(key: key);

  /// 没有水波纹的自定义material组件
  /// 适用于cupertino模式中使用material组件
  /// 会有200延迟高亮
  BaseMaterialWidget.withoutSplash({
    Key? key,
    required Widget child,
    this.theme,
  })  : assert(child != null, 'child can not be null.'),
        assert(theme != null, 'theme can not be null.'),
        child = Theme(
          data: theme!.copyWith(
            splashFactory: WithoutSplashFactory(),
          ),
          child: child,
        ),
        super(key: key);

  final Widget child;
  final ThemeData? theme;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      color: Colors.transparent,
      child: child,
    );
  }
}

/// 去除水波纹效果，但还是有200毫秒的延迟高亮
class WithoutSplashFactory extends InteractiveInkFeatureFactory {
  WithoutSplashFactory();

  @override
  InteractiveInkFeature create({
    required MaterialInkController controller,
    required RenderBox referenceBox,
    required TextDirection textDirection,
    Offset? position,
    required Color color,
    bool containedInkWell = false,
    RectCallback? rectCallback,
    BorderRadius? borderRadius,
    ShapeBorder? customBorder,
    double? radius,
    VoidCallback? onRemoved,
  }) {
    return InkSplash(
      controller: controller,
      referenceBox: referenceBox,
      position: position,
      color: color,
      containedInkWell: false,
      rectCallback: rectCallback,
      borderRadius: BorderRadius.zero,
      customBorder: const Border(),
      radius: 0.0,
      onRemoved: onRemoved,
      textDirection: textDirection,
    );
  }
}
