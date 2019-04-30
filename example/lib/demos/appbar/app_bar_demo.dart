import 'package:base/platform/platform.dart';
import 'package:flutter/widgets.dart';

import '../demo_page.dart';
import '../demo_tile.dart';
import 'backdrop_filter_demo.dart';
import 'custom_height.dart';
import 'news/news.dart';
import 'toolbar_opacity.dart';

/// AppBar 示例
class AppBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<DemoTile> _demos = <DemoTile>[
      DemoTile(
        title: const Text('height'),
        page: CustomHeight(),
      ),
      DemoTile(
        title: const Text('bottom'),
        page: News(),
      ),
    ];

    if (useCupertino) {
      _demos.add(
        DemoTile(
          title: const Text('toolbarOpacity'),
          page: ToolbarOpacity(),
        ),
      );
      _demos.add(
        DemoTile(
          title: const Text('backdropFilter'),
          page: BackdropFilterDemo(),
        ),
      );
    }
    return DemoPage(
      title: 'AppBar | NavBar',
      widgetName: 'BaseAppBar',
      materialDesc: '使用修改了源码的AppBar',
      cupertinoDesc: '使用修改了源码的CupertinoNavigationBar',
      parameterDesc: const <String, String>{
        'height': '自定义高度，AppBar默认56，CupertinoNavigationBar默认44。',
        'backdropFilter': 'Cupertino模式下有效，默认true，是否加入高斯模糊\n'
            'CupertinoNavigationBar在背景色透明时会默认添加一层高斯模糊效果。'
            '设置成false可以实现全透明导航栏',
        'bottom': 'Cupertino模式下也有效, 如加入TabBar，会去除水波纹跟高亮效果。',
        'toolbarOpacity':
            'Cupertino模式下也有效, 只是简单是设置leading，middle，trailing字体的透明度。',
        'autoSetBottomColor': 'Cupertino模式下有效, 默认true，bottom自动跟随状态栏字体颜色。',
        'autoSetMiddleColor': 'Cupertino模式下有效, 默认true，middle自动跟随状态栏字体颜色。',
        'autoSetLeadingColor': 'Cupertino模式下有效, 默认true，leading自动跟随状态栏字体颜色。',
        'autoSetTrailingColor': 'Cupertino模式下有效, 默认true，trailing自动跟随状态栏字体颜色。',
      },
      demos: _demos,
    );
  }
}
