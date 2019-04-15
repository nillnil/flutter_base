
import 'package:flutter/widgets.dart' show BuildContext;

/// 通用方法
mixin BaseMixin {

  // build之前调用
  void buildBefore(BuildContext context) {}

  // buildByMaterial之前调用
  void buildByMaterialBefore(BuildContext context) {}

  // buildByCupertino之前调用
  void buildByCupertinoBefore(BuildContext context) {}

}