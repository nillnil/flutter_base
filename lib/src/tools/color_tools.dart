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
