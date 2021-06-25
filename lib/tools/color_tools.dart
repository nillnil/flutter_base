import 'dart:math';
import 'dart:ui';

/// 是否亮颜色
bool isLight(Color color) {
  return !isDark(color);
}

/// 是否暗颜色
bool isDark(Color color) {
  return color.computeLuminance() < 0.179;
}

/// 颜色转成argb格式
String colorToArgb(Color color) {
  return color.value.toRadixString(16).padLeft(8, '0');
}

/// Color转成rgb格式
String colorToRgb(Color color) {
  String string = colorToArgb(color);
  return string = string.substring(2, string.length);
}

/// 颜色转成rgba格式
String colorToRgba(Color color) {
  String string = colorToArgb(color);
  string = string.substring(2, string.length) + string.substring(0, 2);
  return string;
}

/// argb转成Color
Color argbToColor(String argb) {
  if (argb.startsWith('#')) {
    argb = argb.replaceAll('#', '');
  }
  return Color(int.parse(argb, radix: 16));
}

/// rgb转成Color
Color rgbToColor(String rgb) {
  if (rgb.startsWith('#')) {
    rgb = rgb.replaceAll('#', '');
  }
  rgb = 'ff' + rgb;
  return Color(int.parse(rgb, radix: 16));
}

/// rgba转成Color
Color rgbaToColor(String rgba) {
  if (rgba.startsWith('#')) {
    rgba = rgba.replaceAll('#', '');
  }
  rgba = rgba.substring(rgba.length - 2, rgba.length) + rgba.substring(0, rgba.length - 2);
  return Color(int.parse(rgba, radix: 16));
}

/// 随机颜色，不支持随机范围
class RandomColor extends Color {
  /// 同[Color.fromARGB], 参数有值则锁定该值
  RandomColor({int? a, int? r, int? g, int? b})
      : super(((((a ?? Random().nextInt(256)) & 0xff) << 24) |
                (((r ?? Random().nextInt(256)) & 0xff) << 16) |
                (((g ?? Random().nextInt(256)) & 0xff) << 8) |
                (((b ?? Random().nextInt(256)) & 0xff) << 0)) &
            0xFFFFFFFF);

  /// 同[Color.fromRGBO], 参数有值则锁定该值
  RandomColor.fromRGBO({int? r, int? g, int? b, double? opacity})
      : super((((((opacity ?? Random().nextDouble()) * 0xff ~/ 1) & 0xff) << 24) |
                (((r ?? Random().nextInt(256)) & 0xff) << 16) |
                (((g ?? Random().nextInt(256)) & 0xff) << 8) |
                (((b ?? Random().nextInt(256)) & 0xff) << 0)) &
            0xFFFFFFFF);

  /// 固定red
  RandomColor.withRed(int r)
      : super((((Random().nextInt(256) & 0xff) << 24) | ((r & 0xff) << 16) | ((Random().nextInt(256) & 0xff) << 8) | ((Random().nextInt(256) & 0xff) << 0)) &
            0xFFFFFFFF);

  /// 固定blue
  RandomColor.withBlue(int b)
      : super((((Random().nextInt(256) & 0xff) << 24) | ((Random().nextInt(256) & 0xff) << 16) | ((Random().nextInt(256) & 0xff) << 8) | ((b & 0xff) << 0)) &
            0xFFFFFFFF);

  /// 固定green
  RandomColor.withGreen(int g)
      : super((((Random().nextInt(256) & 0xff) << 24) | ((Random().nextInt(256) & 0xff) << 16) | ((g & 0xff) << 8) | ((Random().nextInt(256) & 0xff) << 0)) &
            0xFFFFFFFF);

  /// 固定alpha
  RandomColor.withAlpha(int a)
      : super((((a & 0xff) << 24) | ((Random().nextInt(256) & 0xff) << 16) | ((Random().nextInt(256) & 0xff) << 8) | ((Random().nextInt(256) & 0xff) << 0)) &
            0xFFFFFFFF);

  /// 固定alpha
  RandomColor.withOpacity(double opacity)
      : super(((((opacity * 0xff ~/ 1) & 0xff) << 24) |
                ((Random().nextInt(256) & 0xff) << 16) |
                ((Random().nextInt(256) & 0xff) << 8) |
                ((Random().nextInt(256) & 0xff) << 0)) &
            0xFFFFFFFF);
}

// /// 随机颜色
// class RandomColor {
//   /// 随机颜色，包括透明度
//   /// 如要限定范围，请使用RandomColor.range()
//   RandomColor({
//     int red,
//     int blue,
//     int green,
//     double opacity,
//     int alpha,
//   })  : assert(
//           opacity == null || alpha == null,
//           'Cannot provide both a opacity and a alpha! ',
//         ),
//         color = opacity != null
//             ? Color.fromRGBO(
//                 red ?? Random().nextInt(256),
//                 green ?? Random().nextInt(256),
//                 blue ?? Random().nextInt(256),
//                 opacity ?? Random().nextDouble(),
//               )
//             : Color.fromARGB(
//                 alpha ?? Random().nextInt(256),
//                 red ?? Random().nextInt(256),
//                 green ?? Random().nextInt(256),
//                 blue ?? Random().nextInt(256),
//               );

//   /// 根据范围随机，范围为：[min, max]
//   /// 请自行校验参数
//   RandomColor.range({
//     int red,
//     List<int> reds,
//     int blue,
//     List<int> blues,
//     int green,
//     List<int> greens,
//     double opacity,
//     List<double> opacities,
//     int alpha,
//     List<int> alphas,
//   })  : assert(
//           opacity == null ||
//               alpha == null ||
//               opacities == null ||
//               alphas == null,
//           'Cannot provide both a opacity and a alpha and a opacties and a alphas! ',
//         ),
//         color = opacity != null || opacities != null
//             ? Color.fromRGBO(
//                 red != null
//                     ? red
//                     : reds == null
//                         ? Random().nextInt(256)
//                         : Random().nextInt(reds[1] - reds[0] + 1) + reds[0],
//                 green != null
//                     ? green
//                     : greens == null
//                         ? Random().nextInt(256)
//                         : Random().nextInt(greens[1] - greens[0] + 1) +
//                             greens[0],
//                 blue != null
//                     ? blue
//                     : blues == null
//                         ? Random().nextInt(256)
//                         : Random().nextInt(blues[1] - blues[0] + 1) + blues[0],
//                 opacity ??
//                     Random().nextDouble() * (opacities[1] - opacities[0]) +
//                         opacities[0],
//               )
//             : Color.fromARGB(
//                 alpha != null
//                     ? alpha
//                     : alphas == null
//                         ? Random().nextInt(256)
//                         : Random().nextInt(alphas[1] - alphas[0] + 1) +
//                             alphas[0],
//                 red != null
//                     ? red
//                     : reds == null
//                         ? Random().nextInt(256)
//                         : Random().nextInt(reds[1] - reds[0] + 1) + reds[0],
//                 green != null
//                     ? green
//                     : greens == null
//                         ? Random().nextInt(256)
//                         : Random().nextInt(greens[1] - greens[0] + 1) +
//                             greens[0],
//                 blue != null
//                     ? blue
//                     : blues == null
//                         ? Random().nextInt(256)
//                         : Random().nextInt(blues[1] - blues[0] + 1) + blues[0],
//               );

//   final Color color;

//   Color withOpacity({double opacity = 1.0}) {
//     assert(opacity >= 0.0 && opacity <= 1.0);
//     return Color.fromRGBO(red, green, blue, opacity);
//   }

//   Color withAlpha({int alpha = 255}) {
//     return Color.fromARGB(alpha, red, green, blue);
//   }

//   int get red => color.red;

//   int get green => color.green;

//   int get blue => color.blue;

//   double get opacity => color.opacity;

//   int get alpha => color.alpha;

//   int value({bool withAlpha = true}) {
//     if (withAlpha) {
//       return ((((opacity * 0xff ~/ 1) & 0xff) << 24) |
//               ((red & 0xff) << 16) |
//               ((green & 0xff) << 8) |
//               ((blue & 0xff) << 0)) &
//           0xFFFFFFFF;
//     }
//     return (((red & 0xff) << 16) |
//             ((green & 0xff) << 8) |
//             ((blue & 0xff) << 0)) &
//         0xFFFFFFFF;
//   }

//   @override
//   String toString({bool withAlpha = true}) {
//     if (withAlpha) {
//       return colorToArgb(color);
//     }
//     return colorToRgb(color);
//   }
// }
