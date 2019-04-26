
import 'package:base/platform/platform.dart';
import 'package:example/demos/demo_page.dart';
import 'package:example/demos/demo_tile.dart';
import 'package:example/demos/utils/color_block.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'tab_scaffold_demo.dart';
import 'transparent_app_bar.dart';

/// Scaffold 示例
class ScaffoldDemo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final List<DemoTile> _demos = <DemoTile>[];
    if (useCupertino) {
      _demos.add(
        DemoTile(
          title: const Text('transparent app bar'),
          page: TransparentAppBar(),
        )
      );
    }
    return DemoPage(
      doc: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('BaseScaffold', style: TextStyle(
              fontWeight: FontWeight.bold
            )),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 10.0, top: 3.0, bottom: 3.0),
                  color: Colors.pinkAccent,
                  width: 10.0,
                  height: 16.0,
                ),
                const Expanded(
                  child: Text('Material：use Scaffold'),
                )
              ]
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 10.0, top: 3.0, bottom: 3.0),
                  color: Colors.lightBlueAccent,
                  width: 10.0,
                  height: 16.0,
                ),
                const Expanded(
                  child: Text('Cupertino：use CupertinoPageScaffold\n'),
                )
              ]
            ),
            const Text('特殊参数说明'),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ColorBlock.attributes(),
                const Expanded(
                  child: Text('safeAreaTop：Cupertino模式下有效，默认false。'
                    '相当于SafeArea的top，当状态栏背景色可能为透明时，且没有用到BoxScrollView等自动设置top padding的组件时，'
                    '可以设置为true，此时页面起点在导航栏下方'
                  ),
                )
              ]
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ColorBlock.attributes(),
                const Expanded(
                  child: Text('safeAreaBottom：Cupertino模式下有效，默认false。'
                    '相当于SafeArea的bottom，设置为true可以避免页面被iphone下方的Home Indicator遮住'
                  ),
                )
              ]
            )
          ]
        ),
      ),
      demos: _demos
    );
  }

}