import 'package:flutter/widgets.dart';

import '../demo_page.dart';
import '../demo_tile.dart';

/// App 说明
class AppDemo extends StatelessWidget {
  const AppDemo({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const DemoPage(
      title: 'App',
      widgetName: 'BaseApp',
      materialDesc: 'use MaterialApp',
      cupertinoDesc: 'use CupertinoApp',
      parameterDesc: <String, String>{
        'platformMode': '平台模式，默认iOS，macOS使用Cupertino模式构建，android, fuchsia, linux 使用Material模式构建',
        'cupertinoTheme': '对应CupertinoApp.theme',
        'materialTheme': '对应MaterialApp.theme',
        'baseTheme': 'BaseTheme, 自定义的主题，包括appBarHeight，backdropFilter, '
            'autoSetMiddleColor, autoSetLeadingColor, '
            'autoSetTrailingColor, autoSetBottomColor '
            'transitionBetweenRoutes',
        'withoutSplashOnCupertino': '当Cupertino模式下使用Material组件时是否去除水波纹效果，'
            '默认true',
      },
      demos: <DemoTile>[],
    );
  }
}
