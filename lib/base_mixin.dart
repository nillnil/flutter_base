import 'package:flutter/widgets.dart' show BuildContext;

/// 通用方法
mixin BaseMixin {
  /// build之前调用
  void buildBefore(BuildContext context) {}

  /// buildByMaterial之前调用
  void buildByMaterialBefore(BuildContext context) {}

  /// buildByCupertino之前调用
  void buildByCupertinoBefore(BuildContext context) {}

  /// 从cupertino获取key对应的值，
  /// 如果为null取value的值，
  /// 如果还是null则取material里的值
  dynamic valueFromMap(Map<String, dynamic>? map, String key, dynamic value) {
    return map != null ? map[key] ?? value : value;
  }
}
