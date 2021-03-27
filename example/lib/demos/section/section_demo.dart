import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../demo_page.dart';
import '../demo_tile.dart';
import 'wechat_profile.dart';

/// section 文档说明
class SectionDemo extends StatelessWidget {
  const SectionDemo({
    Key? key,
  }) : super(key: key);
  List<DemoTile> get _demos => const <DemoTile>[
        DemoTile(
          title: Text('仿微信我的页面'),
          page: WechatProfile(),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return DemoPage(
      title: 'Section & Tile',
      widgetName: 'BaseSection, BaseTile',
      materialDesc: 'BaseSection: use custom Container\n'
          'BaseTile: use ListTile',
      cupertinoDesc: 'BaseSection: use costom Container\n'
          'BaseTile: use custom InkWell, 去除水波纹效果，按住时会有200ms延迟高亮',
      demos: _demos,
    );
  }
}
