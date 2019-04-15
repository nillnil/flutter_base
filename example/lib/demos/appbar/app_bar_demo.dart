
import 'package:example/demos/appbar/custom_height_app_bar.dart';
import 'package:example/demos/demo_page.dart';
import 'package:example/demos/demo_tile.dart';
import 'package:example/demos/utils/color_block.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/painting.dart';

import 'news/news.dart';

/// AppBar 示例
class AppBarDemo extends StatelessWidget {

  final List<DemoTile> _demos = [
    DemoTile(
      title: Text('自定义高度'),
      page: CustomHeightAppBar()
    ),
    DemoTile(
      title: Text('Bottom'),
      page: News()
    )
  ];

  @override
  Widget build(BuildContext context) {
    return DemoPage(
      title: 'AppBar | NavBar',
      doc: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('BaseNavBar', style: TextStyle(
            fontWeight: FontWeight.bold
          )),
          Row(
            children: <Widget>[
              ColorBlock.material(),
              Expanded(
                child: Text('Material：使用修改了源码的AppBar'),
              )
            ]
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ColorBlock.cupertino(),
              Expanded(
                child: Text('Cupertino：使用修改了源码的CupertinoNavigationBar\n'),
              )
            ]
          ),
          Text('特殊参数说明'),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ColorBlock.attributes(),
              Expanded(
                child: Text('useBackdropFilter：是否加入高斯模糊，cupertino模式下有效，默认true\n'
                  'CupertinoNavigationBar会默认添加一层高斯模糊效果，即使背景色是半透明的也会。'
                  '设置成false可以实现全透明导航栏'),
              )
            ]
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ColorBlock.attributes(),
              Expanded(
                child: Text('height：自定义高度，AppBar默认56，CupertinoNavigationBar默认44。'),
              )
            ]
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ColorBlock.attributes(),
              Expanded(
                child: Text('bottom：Cupertino模式下也支持, 如加入TabBar，会去除水波纹跟高亮效果。'),
              )
            ]
          )
        ]
      ),
      demos: _demos
    );
  }

}
