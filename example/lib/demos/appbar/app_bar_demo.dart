
import 'package:example/demos/appbar/custom_height.dart';
import 'package:example/demos/demo_page.dart';
import 'package:example/demos/demo_tile.dart';
import 'package:example/demos/utils/color_block.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/painting.dart';

import 'backdrop_filter_demo.dart';
import 'bottom_opacity.dart';
import 'news/news.dart';

/// AppBar 示例
class AppBarDemo extends StatelessWidget {

  final List<DemoTile> _demos = <DemoTile>[
    DemoTile(
      title: const Text('height'),
      page: CustomHeight()
    ),
    DemoTile(
      title: const Text('backdropFilter'),
      page: BackdropFilterDemo(),
    ),
    DemoTile(
      title: const Text('bottom'),
      page: News()
    ),
    DemoTile(
      title: const Text('bottomOpacity'),
      page: BottomOpacity()
    )
  ];

  @override
  Widget build(BuildContext context) {
    return DemoPage(
      title: 'AppBar | NavBar',
      doc: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('BaseNavBar', style: TextStyle(
            fontWeight: FontWeight.bold
          )),
          Row(
            children: <Widget>[
              ColorBlock.material(),
              const Expanded(
                child: Text('Material：使用修改了源码的AppBar'),
              )
            ]
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ColorBlock.cupertino(),
              const Expanded(
                child: Text('Cupertino：使用修改了源码的CupertinoNavigationBar\n'),
              )
            ]
          ),
          const Text('特殊参数说明'),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ColorBlock.attributes(),
              const Expanded(
                child: Text('height：自定义高度，AppBar默认56，CupertinoNavigationBar默认44。'),
              )
            ]
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ColorBlock.attributes(),
              const Expanded(
                child: Text('backdropFilter：Cupertino模式下有效，默认true，是否加入高斯模糊\n'
                  'CupertinoNavigationBar在背景色透明时会默认添加一层高斯模糊效果。'
                  '设置成false可以实现全透明导航栏'),
              )
            ]
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ColorBlock.attributes(),
              const Expanded(
                child: Text('bottom：Cupertino模式下也有效, 如加入TabBar，会去除水波纹跟高亮效果。'),
              )
            ]
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ColorBlock.attributes(),
              const Expanded(
                child: Text('bottomOpactiy：Cupertino模式下也有效, 只是简单是设置leading，middle，trailing字体的透明度。'),
              )
            ]
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ColorBlock.attributes(),
              const Expanded(
                child: Text('autoSetBottomColor：Cupertino模式下有效, 默认true，bottom自动跟随状态栏字体颜色。'),
              )
            ]
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ColorBlock.attributes(),
              const Expanded(
                child: Text('autoSetMiddleColor：Cupertino模式下有效, 默认true，middle自动跟随状态栏字体颜色。'),
              )
            ]
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ColorBlock.attributes(),
              const Expanded(
                child: Text('autoSetLeadingColor：Cupertino模式下有效, 默认true，leading自动跟随状态栏字体颜色。'),
              )
            ]
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ColorBlock.attributes(),
              const Expanded(
                child: Text('autoSetTrailingColor：Cupertino模式下有效, 默认true，trailing自动跟随状态栏字体颜色。'),
              )
            ]
          ),
        ]
      ),
      demos: _demos
    );
  }

}
