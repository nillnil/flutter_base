
import 'package:example/demos/demo_page.dart';
import 'package:example/demos/demo_tile.dart';
import 'package:example/demos/section/wechat_profile.dart';
import 'package:example/demos/utils/color_block.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// section 文档说明
class SectionDemo extends StatelessWidget {

  final List<DemoTile> _demos = [
    DemoTile(
      title: Text('仿微信我的页面'),
      page: WechatProfile()
    )
  ];

  @override
  Widget build(BuildContext context) {
    return DemoPage(
      title: 'Section & Tile',
      doc: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 5.0),
            child: Text('BaseSection相当于多个BaseTile组成一块\nBseTile相当于ListTile', 
              style: TextStyle(
                fontWeight: FontWeight.bold
              )
            ),
          ),
          Row(
            children: <Widget>[
              ColorBlock.material(),
              Expanded(
                child: Text('Material：使用ListTile组装'),
              )
            ]
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ColorBlock.cupertino(),
              Expanded(
                child: Text('Cupertino：因使用自定义无法解决滚动时取消高亮状态，所以改用InkWell，去除水波纹效果，按住时会有200ms延迟高亮'),
              )
            ]
          )
        ]
      ),
      demos: _demos
    );
  }

}