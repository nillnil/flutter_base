
import 'package:example/demos/demo_page.dart';
import 'package:example/demos/demo_tile.dart';
import 'package:example/demos/utils/color_block.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'transparent_app_bar.dart';


/// Scaffold 示例
class ScaffoldDemo extends StatelessWidget {

  final List<DemoTile> _demos = [
    DemoTile(
      title: Text('透明状态栏'),
      page: TransparentAppBar(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return DemoPage(
      title: 'Scaffold',
      doc: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Scaffold', style: TextStyle(
              fontWeight: FontWeight.bold
            )),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 10.0, top: 3.0, bottom: 3.0),
                  color: Colors.pinkAccent,
                  width: 10.0,
                  height: 16.0,
                ),
                Expanded(
                  child: Text('Material：使用Scaffold，一个页面时取body参数，多个页面时取tabBar和tabBarViews参数'),
                )
              ]
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 10.0, top: 3.0, bottom: 3.0),
                  color: Colors.lightBlueAccent,
                  width: 10.0,
                  height: 16.0,
                ),
                Expanded(
                  child: Text('Cupertino：使用CupertinoPageScaffold，多个页面时使用CupertinoTabScaffold\n'),
                )
              ]
            ),
            Text('特殊参数说明'),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ColorBlock.attributes(),
                Expanded(
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
                Expanded(
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