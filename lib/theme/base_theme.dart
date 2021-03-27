import 'package:flutter/widgets.dart';

import 'base_theme_data.dart';

/// Reference Theme
/// 参考自Theme
class BaseTheme extends StatelessWidget {
  const BaseTheme({
    Key? key,
    required this.data,
    required this.child,
  })  : assert(child != null),
        assert(data != null),
        super(key: key);

  final BaseThemeData data;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _InheritedTheme(
      theme: this,
      child: child,
    );
  }

  static BaseThemeData of(BuildContext context,
      {bool shadowThemeOnly = false}) {
    final _InheritedTheme? inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<_InheritedTheme>();
    return inheritedTheme?.theme.data ?? BaseThemeData();
  }
}

class _InheritedTheme extends InheritedWidget {
  const _InheritedTheme({
    Key? key,
    required this.theme,
    required Widget child,
  })  : assert(theme != null),
        super(key: key, child: child);

  final BaseTheme theme;

  @override
  bool updateShouldNotify(_InheritedTheme old) => theme.data != old.theme.data;
}
