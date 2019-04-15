
import 'package:flutter/cupertino.dart' show CupertinoTheme, CupertinoThemeData;
import 'package:flutter/material.dart' show Theme, ThemeData;
import 'package:flutter/widgets.dart' show BuildContext, InheritedWidget, Key, StatelessWidget, Widget, required;

class BaseTheme extends StatelessWidget {

  final ThemeData materialTheme;
  final CupertinoThemeData cupertinoTheme;
  final Widget child;

  const BaseTheme({
    Key key, 
    this.materialTheme, 
    this.cupertinoTheme, 
    this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _InheritedBaseTheme(
      materialTheme: materialTheme,
      cupertinoTheme: cupertinoTheme,
      child: child
    );
  }

  static ThemeData ofMaterial(BuildContext context) {
    final _InheritedBaseTheme inheritedBaseTheme = context.inheritFromWidgetOfExactType(_InheritedBaseTheme);
    return inheritedBaseTheme != null ? inheritedBaseTheme.materialTheme : Theme.of(context);
  }

  static CupertinoThemeData ofCupertino(BuildContext context) {
    final _InheritedBaseTheme inheritedBaseTheme = context.inheritFromWidgetOfExactType(_InheritedBaseTheme);
    return inheritedBaseTheme != null ? inheritedBaseTheme.cupertinoTheme : CupertinoTheme.of(context);
  }
  
}

class _InheritedBaseTheme extends InheritedWidget {

  final ThemeData materialTheme;
  final CupertinoThemeData cupertinoTheme;
  final Widget child;

  _InheritedBaseTheme({
    Key key,
    @required this.materialTheme, 
    @required this.cupertinoTheme,
    @required this.child
  }): super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedBaseTheme oldWidget) {
    return materialTheme != oldWidget.materialTheme
      || cupertinoTheme != oldWidget.cupertinoTheme;
  }
  
}