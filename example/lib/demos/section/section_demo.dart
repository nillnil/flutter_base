import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../demo_page.dart';
import '../demo_tile.dart';
import 'wechat_profile.dart';

/// section 文档说明
class SectionDemo extends StatelessWidget {
  final List<DemoTile> _demos = <DemoTile>[
    DemoTile(title: const Text('仿微信我的页面'), page: WechatProfile())
  ];

  @override
  Widget build(BuildContext context) {
    return DemoPage(
      title: 'Section & Tile',
      widgetName: 'BaseSection, BaseTile',
      materialDesc: 'BaseSection: use custom Container\n'
          'BaseTile: use ListTile',
      cupertinoDesc: 'use costom Container\n'
          'BaseTile: use custom InkWell, 去除水波纹效果，按住时会有200ms延迟高亮',
      demos: _demos,
    );
  }
}
